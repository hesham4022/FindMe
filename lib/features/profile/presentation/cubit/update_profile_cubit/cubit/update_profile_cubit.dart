import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/auth/presentation/cubit/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:find_me_app/features/profile/data/model/update_profile_model.dart';
import 'package:find_me_app/features/profile/data/repo/update_profile_repo.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final UpdateProfileRepo _repo;

  UpdateProfileCubit(this._repo) : super(UpdateProfileState.initial());

  final ImagePicker _picker = ImagePicker();

  void fullNameChanged(String value) {
    emit(state.copyWith(fullName: value));
  }

  void emailChanged(String value) {
    emit(state.copyWith(email: value));
  }

  void mobileNumberChanged(String value) {
    emit(state.copyWith(mobileNumber: value));
  }

  void dateOfBirthChanged(DateTime? value) {
    emit(state.copyWith(dateOfBirth: value));
  }

  void fullNameErrorTextChanged(String? value) =>
      emit(state.copyWith(fullNameErrorText: value));

  void emailErrorTextChanged(String? value) =>
      emit(state.copyWith(emailErrorText: value));

  void mobileNumberErrorTextChanged(String? value) =>
      emit(state.copyWith(mobileNumberErrorText: value));

  void photoErrorChanged(String? value) =>
      emit(state.copyWith(photoError: value));

  void dateOfBirthErrorTextChanged(String? value) =>
      emit(state.copyWith(dateOfBirthErrorText: value));

  void photoChanged(String? value) {
    emit(state.copyWith(photo: value));
  }

  Future<void> pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    emit(state.copyWith(photo: pickedFile.path));
  }

  void removePhoto() {
    emit(state.copyWith(photo: null));
  }

  void resetState() {
    emit(UpdateProfileState.initial());
  }

  Future<void> updateProfile() async {
    if (state.isLoading) return;

    emit(state.copyWith(
      status: UpdateProfileStatus.loading,
      error: null,
    ));

    final request = UpdateProfileRequest(
      fullName: state.fullName,
      email: state.email,
      mobileNumber: state.mobileNumber,
      dateOfBirth: state.dateOfBirth,
      photo: state.photo,
    );

    log("📤 Sending Update Profile Request: ${request.toJson()}");

    final result = await _repo.updateProfile(request);

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: UpdateProfileStatus.error,
          error: failure,
        ));
      },
      (response) async {
        emit(state.copyWith(
          status: UpdateProfileStatus.success,
          success: response,
          error: null,
        ));

        // 1) حدّث الكاش
        await sl<AuthLocal>().updateCachedUserFromProfile(response.data);

        // 2) هات اليوزر الجديد من الكاش
        final updatedUser = await sl<AuthLocal>().getCachedAuthedUser();

        // 3) حدّث AuthCubit (دي أهم خطوة)
        await sl<AuthCubit>().updateCurrentUser(updatedUser);
        log("${await sl<AuthLocal>().getCachedAuthedUser()}");
      },
    );
  }
}
