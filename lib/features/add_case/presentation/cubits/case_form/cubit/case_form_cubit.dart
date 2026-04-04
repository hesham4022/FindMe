import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';
import 'case_form_state.dart';

class CaseFormCubit extends Cubit<CaseFormState> {
  CaseFormCubit() : super(CaseFormState.initial());

  final ImagePicker _picker = ImagePicker();

  void reportTypeChanged(ReportType type) {
    emit(state.copyWith(reportType: type));
  }

  void firstNameChanged(String value) {
    emit(state.copyWith(firstName: value, firstNameErrorText: null));
  }

  void lastNameChanged(String value) {
    emit(state.copyWith(lastName: value, lastNameErrorText: null));
  }

  void ageChanged(String value) {
    emit(state.copyWith(age: int.tryParse(value), ageErrorText: null));
  }

  void addressChanged(String value) {
    emit(state.copyWith(address: value, addressErrorText: null));
  }

  void genderChanged(String value) {
    emit(state.copyWith(gender: value, genderErrorText: null));
  }

  void weightChanged(String value) {
    emit(state.copyWith(weight: double.tryParse(value)));
  }

  void heightChanged(String value) {
    emit(state.copyWith(height: double.tryParse(value)));
  }

  void clothingDescriptionChanged(String value) {
    emit(state.copyWith(clothingDescription: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void dateLastSeenChanged(String value) {
    emit(state.copyWith(dateLastSeen: value));
  }

  void lastSeenLocationChanged(String value) {
    emit(state.copyWith(lastSeenLocation: value));
  }

  void hasVehicleChanged(bool value) {
    emit(state.copyWith(hasVehicle: value));
  }

  void vehicleDetailsChanged(String value) {
    emit(state.copyWith(vehicleDetails: value));
  }

  void breakdownDetailsChanged(String value) {
    emit(state.copyWith(fullBreakdownDetails: value));
  }

  void policeStationChanged(String value) {
    emit(state.copyWith(policeStation: value));
  }

  void fullNameOfReporterChanged(String value) {
    emit(state.copyWith(fullNameOfReporter: value));
  }

  void emailOfReporterChanged(String value) {
    emit(state.copyWith(emailOfReporter: value));
  }

  void phoneOfReporterChanged(String value) {
    emit(state.copyWith(phoneOfReporter: value));
  }

  void relationShipToChildChanged(String value) {
    emit(state.copyWith(relationShipToChild: value));
  }

  void confirmInformationChanged(bool value) {
    emit(state.copyWith(confirmInformation: value, consentErrorText: null));
  }

  void consentToShareChanged(bool value) {
    emit(state.copyWith(consentToShare: value, consentErrorText: null));
  }

  void resetState() {
    emit(CaseFormState.initial());
  }

  Future<void> pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final compressedFile = await _compressImage(File(pickedFile.path));

    final updatedPhotos = List<String>.from(state.photos)
      ..add(compressedFile.path);

    emit(state.copyWith(photos: updatedPhotos));
  }

  Future<File> _compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath = join(dir.path, 'compressed_${basename(file.path)}');

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 75,
    );

    if (result == null) return file;
    if (result is XFile) return File(result.path);
    return result as File;
  }

  void removePhoto(String path) {
    final newPhotos = List<String>.from(state.photos)..remove(path);
    emit(state.copyWith(photos: newPhotos));
  }

  bool validateForm() {
    final firstNameError = AppValidators.validateUsername(state.firstName);
    final lastNameError = AppValidators.validateLastName(state.lastName);
    final addressError = AppValidators.validateAddress(state.address);
    final ageError = AppValidators.validateAge(state.age?.toString());
    final genderError = (state.gender == null || state.gender!.isEmpty)
        ? 'Gender is required'
        : null;
    final consentError = (!state.confirmInformation || !state.consentToShare)
        ? 'Please accept required consents'
        : null;

    emit(state.copyWith(
      firstNameErrorText: firstNameError,
      lastNameErrorText: lastNameError,
      addressErrorText: addressError,
      ageErrorText: ageError,
      genderErrorText: genderError,
      consentErrorText: consentError,
    ));

    return firstNameError == null &&
        lastNameError == null &&
        addressError == null &&
        ageError == null &&
        genderError == null &&
        consentError == null;
  }

  bool get isFormValid {
    return AppValidators.validateUsername(state.firstName) == null &&
        AppValidators.validateLastName(state.lastName) == null &&
        AppValidators.validateAddress(state.address) == null &&
        AppValidators.validateAge(state.age?.toString()) == null &&
        state.gender != null &&
        state.gender!.isNotEmpty &&
        state.confirmInformation &&
        state.consentToShare;
  }

  void fillWithCase(CaseInfoModel? caseModel) {
    if (caseModel == null) return;

    emit(state.copyWith(
      originalCase: caseModel,
      firstName: caseModel.firstName,
      lastName: caseModel.lastName,
      address: caseModel.address,
      age: caseModel.age,
      gender: caseModel.gender,
      weight: caseModel.weight,
      height: caseModel.height,
      description: caseModel.description,
      photos: caseModel.photos.map((e) => e.url ?? '').toList(),
      confirmInformation: caseModel.confirmInformation,
      consentToShare: caseModel.consentToShare,
    ));
  }

  bool get isFormUpdateChanged {
    final caseModel = state.originalCase;
    if (caseModel == null) return false;

    final originalPhotos = caseModel.photos.map((e) => e.url ?? '').toList();

    return state.firstName != caseModel.firstName ||
        state.lastName != caseModel.lastName ||
        state.address != caseModel.address ||
        state.age != caseModel.age ||
        state.gender != caseModel.gender ||
        state.weight != caseModel.weight ||
        state.height != caseModel.height ||
        state.description != caseModel.description ||
        state.confirmInformation != caseModel.confirmInformation ||
        state.consentToShare != caseModel.consentToShare ||
        !const ListEquality().equals(state.photos, originalPhotos);
  }

  bool get canUpdate => isFormUpdateChanged && isFormValid;
}
