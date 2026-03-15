part of 'add_case_cubit.dart';

enum AddCaseStatus {
  initial,
  loading,
  success,
  error,
}

class AddCaseState extends Equatable {
  final ReportType? reportType;
  final List<String> photos;
  final String? firstName;
  final String? lastName;
  final String? address;
  final int? age;
  final String? gender;
  final double? weight;
  final double? height;
  final String? clothingDescription;
  final String? description;

/////
  final String? dateLastSeen;
  final bool hasVehicle;
  final String? vehicleDetails;
  final String? fullBreakdownDetails;
  final String? lastSeenLocation;
  final String? policeStation;
////////

  final String? fullNameOfReporter;
  final String? relationShipToChild;
  final String? phoneOfReporter;
  final String? emailOfReporter;

///////
  final bool confirmInformation;
  final bool consentToShare;

  // validation messages

  final String? firstNameErrorText;
  final String? lastNameErrorText;
  final String? addressErrorText;
  final String? ageErrorText;
  final String? genderErrorText;
  final String? weightErrorText;
  final String? heightErrorText;
  final String? clothingDescriptionErrorText;
  final String? descriptionErrorText;

  ////
  final String? dateLastSeenError;
  final String? lastSeenLocationError;
  final String? fullBreakdownDetailsError;
  final String? vehicleDetailsError;
  final String? policeStationErrorText;

  ///

  final String? fullNameOfReporterError;
  final String? relationShipToChildError;
  final String? phoneOfReporterError;
  final String? emailOfReporterError;

  ///

  final String? consentErrorText;
  final CreateReportRequest? createReportRequest;
  final AddCaseStatus status;

  ///////
  final CreateReportResponse? success;
  final Failure? error;

  const AddCaseState({
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.clothingDescription,
    this.description,
    this.hasVehicle = false,
    this.vehicleDetails,
    this.fullBreakdownDetails,
    this.address,
    this.lastSeenLocation,
    this.dateLastSeen,
    this.confirmInformation = false,
    this.consentToShare = false,
    this.photos = const [],
    this.firstNameErrorText,
    this.lastNameErrorText,
    this.addressErrorText,
    this.ageErrorText,
    this.genderErrorText,
    this.weightErrorText,
    this.heightErrorText,
    this.clothingDescriptionErrorText,
    this.descriptionErrorText,
    this.dateLastSeenError,
    this.lastSeenLocationError,
    this.fullBreakdownDetailsError,
    this.vehicleDetailsError,
    this.consentErrorText,
    required this.status,
    this.success,
    this.error,
    this.createReportRequest,
    this.reportType,
    this.policeStation,
    this.policeStationErrorText,
    this.fullNameOfReporter,
    this.emailOfReporter,
    this.phoneOfReporter,
    this.relationShipToChild,
    this.fullNameOfReporterError,
    this.emailOfReporterError,
    this.phoneOfReporterError,
    this.relationShipToChildError,
  });

  AddCaseState copyWith({
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    double? weight,
    double? height,
    String? clothingDescription,
    String? description,
    bool? hasVehicle,
    String? vehicleDetails,
    String? fullBreakdownDetails,
    String? address,
    String? lastSeenLocation,
    String? dateLastSeen,
    bool? confirmInformation,
    bool? consentToShare,
    List<String>? photos,
    String? firstNameErrorText,
    String? lastNameErrorText,
    String? addressErrorText,
    String? ageErrorText,
    String? genderErrorText,
    String? weightErrorText,
    String? heightErrorText,
    String? clothingDescriptionErrorText,
    String? descriptionErrorText,
    String? dateLastSeenError,
    String? lastSeenLocationError,
    String? fullBreakdownDetailsError,
    String? vehicleDetailsError,
    String? consentErrorText,
    AddCaseStatus? status,
    CreateReportResponse? success,
    Failure? error,
    CreateReportRequest? createReportRequest,
    ReportType? reportType,
    String? policeStation,
    String? policeStationErrorText,

    /////
    String? fullNameOfReporter,
    String? relationShipToChild,
    String? phoneOfReporter,
    String? emailOfReporter,

    ///
    String? fullNameOfReporterError,
    String? relationShipToChildError,
    String? phoneOfReporterError,
    String? emailOfReporterError,
  }) {
    return AddCaseState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      clothingDescription: clothingDescription ?? this.clothingDescription,
      description: description ?? this.description,
      hasVehicle: hasVehicle ?? this.hasVehicle,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      fullBreakdownDetails: fullBreakdownDetails ?? this.fullBreakdownDetails,
      address: address ?? this.address,
      lastSeenLocation: lastSeenLocation ?? this.lastSeenLocation,
      dateLastSeen: dateLastSeen ?? this.dateLastSeen,
      confirmInformation: confirmInformation ?? this.confirmInformation,
      consentToShare: consentToShare ?? this.consentToShare,
      photos: photos ?? this.photos,
      firstNameErrorText: firstNameErrorText ?? this.firstNameErrorText,
      lastNameErrorText: lastNameErrorText ?? this.lastNameErrorText,
      addressErrorText: addressErrorText ?? this.addressErrorText,
      ageErrorText: ageErrorText ?? this.ageErrorText,
      genderErrorText: genderErrorText ?? this.genderErrorText,
      weightErrorText: weightErrorText ?? this.weightErrorText,
      heightErrorText: heightErrorText ?? this.heightErrorText,
      clothingDescriptionErrorText:
          clothingDescriptionErrorText ?? this.clothingDescriptionErrorText,
      descriptionErrorText: descriptionErrorText ?? this.descriptionErrorText,
      dateLastSeenError: dateLastSeenError ?? this.dateLastSeenError,
      lastSeenLocationError:
          lastSeenLocationError ?? this.lastSeenLocationError,
      fullBreakdownDetailsError:
          fullBreakdownDetailsError ?? this.fullBreakdownDetailsError,
      vehicleDetailsError: vehicleDetailsError ?? this.vehicleDetailsError,
      consentErrorText: consentErrorText ?? this.consentErrorText,
      status: status ?? this.status,
      success: success ?? this.success,
      error: error ?? this.error,
      createReportRequest: createReportRequest ?? this.createReportRequest,
      reportType: reportType ?? this.reportType,
      policeStation: policeStation ?? this.policeStation,
      policeStationErrorText:
          policeStationErrorText ?? this.policeStationErrorText,

      ///
      fullNameOfReporter: fullNameOfReporter ?? this.fullNameOfReporter,
      relationShipToChild: relationShipToChild ?? this.relationShipToChild,
      phoneOfReporter: phoneOfReporter ?? this.phoneOfReporter,
      emailOfReporter: emailOfReporter ?? this.emailOfReporter,

      ///

      fullNameOfReporterError:
          fullNameOfReporterError ?? this.fullNameOfReporterError,
      relationShipToChildError:
          relationShipToChildError ?? this.relationShipToChildError,
      phoneOfReporterError: phoneOfReporterError ?? this.phoneOfReporterError,
      emailOfReporterError: emailOfReporterError ?? this.emailOfReporterError,
    );
  }

  bool get isInitial => status == AddCaseStatus.initial;
  bool get isLoading => status == AddCaseStatus.loading;
  bool get isSuccess => status == AddCaseStatus.success;
  bool get isError => status == AddCaseStatus.error;

  factory AddCaseState.initial() {
    return const AddCaseState(
      status: AddCaseStatus.initial,
      firstName: '',
      lastName: '',
      gender: '',
      age: 0,
      hasVehicle: false,
      confirmInformation: false,
      consentToShare: false,
      photos: [],
      createReportRequest: null,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        age,
        gender,
        weight,
        height,
        clothingDescription,
        description,
        hasVehicle,
        vehicleDetails,
        fullBreakdownDetails,
        address,
        lastSeenLocation,
        dateLastSeen,
        confirmInformation,
        consentToShare,
        photos,
        firstNameErrorText,
        lastNameErrorText,
        addressErrorText,
        ageErrorText,
        genderErrorText,
        weightErrorText,
        heightErrorText,
        clothingDescriptionErrorText,
        descriptionErrorText,
        dateLastSeenError,
        lastSeenLocationError,
        fullBreakdownDetailsError,
        vehicleDetailsError,
        consentErrorText,
        status,
        success,
        error,
        createReportRequest,
        reportType,
        policeStation,
        policeStationErrorText,
        fullNameOfReporter,
        fullNameOfReporterError,
        emailOfReporter,
        emailOfReporterError,
        phoneOfReporter,
        phoneOfReporterError,
        relationShipToChild,
        relationShipToChildError,
      ];
}
