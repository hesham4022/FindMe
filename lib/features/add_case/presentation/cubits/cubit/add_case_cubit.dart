import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/error_management/failure.dart';
import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/core/shared/widgets/alerts.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/add_case/data/repo/add_case_repo.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'package:find_me_app/features/all_cases/presentation/cubits/cubit/all_cases_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
part 'add_case_state.dart';

class AddCaseCubit extends Cubit<AddCaseState> {
  final AddCasesRepo _repo;

  AddCaseCubit(this._repo) : super(AddCaseState.initial());

  // 🔹 Field changes

  void reportTypeChanged(ReportType type) {
    emit(state.copyWith(reportType: type));
  }

  void firstNameChanged(String value) => emit(state.copyWith(
        firstName: value,
        firstNameErrorText: null,
      ));

  void firstNameErrorTextChanged(String value) =>
      emit(state.copyWith(firstNameErrorText: value));

  void lastNameChanged(String value) =>
      emit(state.copyWith(lastName: value, lastNameErrorText: null));

  void lastNameErrorTextChanged(String value) =>
      emit(state.copyWith(lastNameErrorText: value));

  void ageChanged(String value) {
    final parsedAge = int.tryParse(value);
    emit(state.copyWith(age: parsedAge));
  }

  void ageErrorChanged(String value) {
    emit(state.copyWith(ageErrorText: value));
  }

  void addressChanged(String value) =>
      emit(state.copyWith(address: value, addressErrorText: null));

  void addressErrorChanged(String value) =>
      emit(state.copyWith(addressErrorText: value));

  void genderChanged(String value) =>
      emit(state.copyWith(gender: value, genderErrorText: ''));

  void weightChanged(String value) =>
      emit(state.copyWith(weight: double.tryParse(value)));

  void weightErrorChanged(String value) =>
      emit(state.copyWith(weightErrorText: value));

  void heightChanged(String value) =>
      emit(state.copyWith(height: double.tryParse(value)));

  void heightErrorChanged(String value) =>
      emit(state.copyWith(heightErrorText: value));

  void clothingDescriptionChanged(String value) =>
      emit(state.copyWith(clothingDescription: value));

  void clothingDescriptionErrorChanged(String value) =>
      emit(state.copyWith(clothingDescriptionErrorText: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void descriptionErrorChanged(String value) =>
      emit(state.copyWith(descriptionErrorText: value));

  void dateLastseenChanged(String value) =>
      emit(state.copyWith(dateLastSeen: value));

  void dateLastseenErrorChanged(String value) =>
      emit(state.copyWith(dateLastSeenError: value));

  void lastseenLocationChanged(String value) =>
      emit(state.copyWith(lastSeenLocation: value));

  void lastseenLocationErrorChanged(String value) =>
      emit(state.copyWith(lastSeenLocationError: value));

  void hasVehicleChanged(bool value) => emit(state.copyWith(hasVehicle: value));

  void vehicleDetailsChanged(String value) =>
      emit(state.copyWith(vehicleDetails: value));

  void vehicleDetailsErrorChanged(String value) =>
      emit(state.copyWith(vehicleDetailsError: value));

  void breakdownDetailsChanged(String value) =>
      emit(state.copyWith(fullBreakdownDetails: value));

  void breakdownDetailsErrorChanged(String value) =>
      emit(state.copyWith(fullBreakdownDetailsError: value));

  void policeStationChanged(String value) =>
      emit(state.copyWith(policeStation: value));

  void policeStationErrorChanged(String value) =>
      emit(state.copyWith(policeStationErrorText: value));

  //reporter information
  void fullNameOfReporterChanged(String value) =>
      emit(state.copyWith(fullNameOfReporter: value));

  void fullNameOfReporterErrorChanged(String value) =>
      emit(state.copyWith(fullNameOfReporterError: value));

  void emailOfReporterChanged(String value) =>
      emit(state.copyWith(emailOfReporter: value));

  void emailOfReporterErrorChanged(String value) =>
      emit(state.copyWith(emailOfReporterError: value));

  void phoneOfReporterChanged(String value) =>
      emit(state.copyWith(phoneOfReporter: value));

  void phoneOfReporterErrorChanged(String value) =>
      emit(state.copyWith(phoneOfReporterError: value));

  void relationShipToChildChanged(String value) =>
      emit(state.copyWith(relationShipToChild: value));

  void relationShipToChildErrorChanged(String value) =>
      emit(state.copyWith(relationShipToChildError: value));

  ////

  void confirmInformationChanged(bool value) =>
      emit(state.copyWith(confirmInformation: value, consentErrorText: null));

  void consentToShareChanged(bool value) =>
      emit(state.copyWith(consentToShare: value, consentErrorText: null));
  void resetState() {
    emit(AddCaseState.initial());
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    // compress image Before Addtion
    final compressedFile = await _compressImage(File(pickedFile.path));

    final updatedPhotos = List<String>.from(state.photos)
      ..add(compressedFile.path);
    emit(state.copyWith(photos: updatedPhotos));
  }

  Future<File> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = join(dir.path, "compressed_${basename(file.path)}");

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
    );

    if (result == null) return file;
    if (result is XFile) {
      return File(result.path);
    }

    return result as File;
  }

  void removePhoto(String path) {
    final newPhotos = List<String>.from(state.photos)..remove(path);
    emit(state.copyWith(photos: newPhotos));
  }

  // 🔹 Validation
  void validateFieldsBeforeSubmit(BuildContext context) {
    bool hasError = false;
    log("✅ validateFieldsBeforeSubmit called");

    final firstNameErr = AppValidators.validateUsername(state.firstName);
    if (firstNameErr != null) {
      emit(state.copyWith(firstNameErrorText: firstNameErr));
      hasError = true;
    }

    final lastNameErr = AppValidators.validateLastName(state.lastName);
    if (lastNameErr != null) {
      emit(state.copyWith(lastNameErrorText: lastNameErr));
      hasError = true;
    }

    final addressErr = AppValidators.validateAddress(state.address);
    if (addressErr != null) {
      emit(state.copyWith(addressErrorText: addressErr));
      hasError = true;
    }

    final ageErr = AppValidators.validateAge(state.age?.toString());
    if (ageErr != null) {
      emit(state.copyWith(ageErrorText: ageErr));
      hasError = true;
    }

    if (state.gender == null || state.gender!.isEmpty) {
      emit(state.copyWith(genderErrorText: "Please select a gender"));
      hasError = true;
    }

    if (!state.confirmInformation || !state.consentToShare) {
      emit(state.copyWith(
          consentErrorText: "You must confirm and consent before submitting."));
      hasError = true;
    }

    if (!hasError) {
      submitReport(context);
    } else {
      showAlertSnackBar(
          context, "Please fix the highlighted fields", AlertType.error);
    }
  }

  Future<void> submitReport(BuildContext context) async {
    if (state.isLoading) return;
    emit(state.copyWith(status: AddCaseStatus.loading));

    final request = CreateReportRequest(
      firstName: state.firstName ?? '',
      lastName: state.lastName ?? '',
      address: state.address ?? '',
      age: state.age ?? 0,
      gender: state.gender ?? '',
      weight: state.weight,
      height: state.height,
      description: state.description,
      dateLastSeen: state.dateLastSeen,
      lastSeenLocation: state.lastSeenLocation,
      fullBreakdownDetails: state.fullBreakdownDetails,
      vehicleDetails: state.vehicleDetails,
      hasVehicle: false,
      confirmInformation: state.confirmInformation,
      consentToShare: state.consentToShare,
      photos: state.photos,
    );

    log("📤 Sending Report Request: ${request.toJson()}");

    final result = await _repo.addCase(request);

    result.fold(
      (failure) {
        emit(state.copyWith(status: AddCaseStatus.error, error: failure));
      },
      (response) {
        CaseInfoModel? caseInfoModel = response.data;
        emit(state.copyWith(status: AddCaseStatus.success, success: response));
        context.read<AllCasesCubit>().state.filtered.insert(0, caseInfoModel);
      },
    );
  }
}
