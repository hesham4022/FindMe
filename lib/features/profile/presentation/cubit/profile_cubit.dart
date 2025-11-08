import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/networking/success_response.dart';
import 'package:find_me_app/features/profile/data/model/user_profile_model.dart';
import 'package:find_me_app/features/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._repo) : super(ProfileState.initial());

  final ProfileRepo _repo;

  // Future<bool> getProfile(int employeeId) async {
  //   emit(state.copyWith(
  //     status: ProfileStatus.fetchProfileDataLoading,
  //   ));
  //
  //   final result = await _repo.getProfileData(employeeId);
  //
  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(
  //       status: ProfileStatus.fetchProfileDataError,
  //       failure: failure,
  //     ));
  //       return false;
  //     },
  //     (success) {
  //       emit(state.copyWith(
  //         status: ProfileStatus.fetchProfileDataSuccess,
  //         profileData: success,
  //       ));
  //       return true;
  //
  //     },
  //   );
  //   return false;
  //
  // }
  Future<bool> getProfile(int employeeId) async {
    emit(state.copyWith(
      status: ProfileStatus.fetchProfileDataLoading,
    ));

    final result = await _repo.getProfileData(employeeId);

    // Declare a variable to store the return value
    bool isSuccess = false;

    result.fold(
      (failure) {
        emit(state.copyWith(
          status: ProfileStatus.fetchProfileDataError,
          failure: failure,
        ));
        isSuccess = false; // Explicitly set to false
      },
      (success) {
        emit(state.copyWith(
          status: ProfileStatus.fetchProfileDataSuccess,
          profileData: success,
        ));
        isSuccess = true; // Explicitly set to true
      },
    );

    return isSuccess; // Now correctly returning true or false
  }
}
