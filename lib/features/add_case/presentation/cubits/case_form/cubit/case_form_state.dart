import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/helpers/enums/report_type.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

class CaseFormState extends Equatable {
  final ReportType? reportType;

  final String? firstName;
  final String? lastName;
  final int? age;
  final String? address;
  final String? gender;
  final double? weight;
  final double? height;
  final String? clothingDescription;
  final String? description;
  final String? dateLastSeen;
  final String? lastSeenLocation;
  final bool hasVehicle;
  final String? vehicleDetails;
  final String? fullBreakdownDetails;
  final String? policeStation;

  final String? fullNameOfReporter;
  final String? emailOfReporter;
  final String? phoneOfReporter;
  final String? relationShipToChild;

  final bool confirmInformation;
  final bool consentToShare;

  final List<String> photos;

  final String? firstNameErrorText;
  final String? lastNameErrorText;
  final String? ageErrorText;
  final String? addressErrorText;
  final String? genderErrorText;
  final String? weightErrorText;
  final String? heightErrorText;
  final String? clothingDescriptionErrorText;
  final String? descriptionErrorText;
  final String? dateLastSeenError;
  final String? lastSeenLocationError;
  final String? vehicleDetailsError;
  final String? fullBreakdownDetailsError;
  final String? policeStationErrorText;
  final String? fullNameOfReporterError;
  final String? emailOfReporterError;
  final String? phoneOfReporterError;
  final String? relationShipToChildError;
  final String? consentErrorText;

  final CaseInfoModel? originalCase;

  const CaseFormState({
    this.reportType,
    this.firstName,
    this.lastName,
    this.age,
    this.address,
    this.gender,
    this.weight,
    this.height,
    this.clothingDescription,
    this.description,
    this.dateLastSeen,
    this.lastSeenLocation,
    this.hasVehicle = false,
    this.vehicleDetails,
    this.fullBreakdownDetails,
    this.policeStation,
    this.fullNameOfReporter,
    this.emailOfReporter,
    this.phoneOfReporter,
    this.relationShipToChild,
    this.confirmInformation = false,
    this.consentToShare = false,
    this.photos = const [],
    this.firstNameErrorText,
    this.lastNameErrorText,
    this.ageErrorText,
    this.addressErrorText,
    this.genderErrorText,
    this.weightErrorText,
    this.heightErrorText,
    this.clothingDescriptionErrorText,
    this.descriptionErrorText,
    this.dateLastSeenError,
    this.lastSeenLocationError,
    this.vehicleDetailsError,
    this.fullBreakdownDetailsError,
    this.policeStationErrorText,
    this.fullNameOfReporterError,
    this.emailOfReporterError,
    this.phoneOfReporterError,
    this.relationShipToChildError,
    this.consentErrorText,
    this.originalCase,
  });

  factory CaseFormState.initial() {
    return const CaseFormState();
  }

  CaseFormState copyWith({
    ReportType? reportType,
    String? firstName,
    String? lastName,
    int? age,
    String? address,
    String? gender,
    double? weight,
    double? height,
    String? clothingDescription,
    String? description,
    String? dateLastSeen,
    String? lastSeenLocation,
    bool? hasVehicle,
    String? vehicleDetails,
    String? fullBreakdownDetails,
    String? policeStation,
    String? fullNameOfReporter,
    String? emailOfReporter,
    String? phoneOfReporter,
    String? relationShipToChild,
    bool? confirmInformation,
    bool? consentToShare,
    List<String>? photos,
    String? firstNameErrorText,
    String? lastNameErrorText,
    String? ageErrorText,
    String? addressErrorText,
    String? genderErrorText,
    String? weightErrorText,
    String? heightErrorText,
    String? clothingDescriptionErrorText,
    String? descriptionErrorText,
    String? dateLastSeenError,
    String? lastSeenLocationError,
    String? vehicleDetailsError,
    String? fullBreakdownDetailsError,
    String? policeStationErrorText,
    String? fullNameOfReporterError,
    String? emailOfReporterError,
    String? phoneOfReporterError,
    String? relationShipToChildError,
    String? consentErrorText,
    CaseInfoModel? originalCase,
  }) {
    return CaseFormState(
      reportType: reportType ?? this.reportType,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      age: age ?? this.age,
      address: address ?? this.address,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      clothingDescription: clothingDescription ?? this.clothingDescription,
      description: description ?? this.description,
      dateLastSeen: dateLastSeen ?? this.dateLastSeen,
      lastSeenLocation: lastSeenLocation ?? this.lastSeenLocation,
      hasVehicle: hasVehicle ?? this.hasVehicle,
      vehicleDetails: vehicleDetails ?? this.vehicleDetails,
      fullBreakdownDetails: fullBreakdownDetails ?? this.fullBreakdownDetails,
      policeStation: policeStation ?? this.policeStation,
      fullNameOfReporter: fullNameOfReporter ?? this.fullNameOfReporter,
      emailOfReporter: emailOfReporter ?? this.emailOfReporter,
      phoneOfReporter: phoneOfReporter ?? this.phoneOfReporter,
      relationShipToChild: relationShipToChild ?? this.relationShipToChild,
      confirmInformation: confirmInformation ?? this.confirmInformation,
      consentToShare: consentToShare ?? this.consentToShare,
      photos: photos ?? this.photos,
      firstNameErrorText: firstNameErrorText ?? this.firstNameErrorText,
      lastNameErrorText: lastNameErrorText ?? this.lastNameErrorText,
      ageErrorText: ageErrorText ?? this.ageErrorText,
      addressErrorText: addressErrorText ?? this.addressErrorText,
      genderErrorText: genderErrorText ?? this.genderErrorText,
      weightErrorText: weightErrorText ?? this.weightErrorText,
      heightErrorText: heightErrorText ?? this.heightErrorText,
      clothingDescriptionErrorText:
          clothingDescriptionErrorText ?? this.clothingDescriptionErrorText,
      descriptionErrorText: descriptionErrorText ?? this.descriptionErrorText,
      dateLastSeenError: dateLastSeenError ?? this.dateLastSeenError,
      lastSeenLocationError:
          lastSeenLocationError ?? this.lastSeenLocationError,
      vehicleDetailsError: vehicleDetailsError ?? this.vehicleDetailsError,
      fullBreakdownDetailsError:
          fullBreakdownDetailsError ?? this.fullBreakdownDetailsError,
      policeStationErrorText:
          policeStationErrorText ?? this.policeStationErrorText,
      fullNameOfReporterError:
          fullNameOfReporterError ?? this.fullNameOfReporterError,
      emailOfReporterError: emailOfReporterError ?? this.emailOfReporterError,
      phoneOfReporterError: phoneOfReporterError ?? this.phoneOfReporterError,
      relationShipToChildError:
          relationShipToChildError ?? this.relationShipToChildError,
      consentErrorText: consentErrorText ?? this.consentErrorText,
      originalCase: originalCase ?? this.originalCase,
    );
  }

  @override
  List<Object?> get props => [
        reportType,
        firstName,
        lastName,
        age,
        address,
        gender,
        weight,
        height,
        clothingDescription,
        description,
        dateLastSeen,
        lastSeenLocation,
        hasVehicle,
        vehicleDetails,
        fullBreakdownDetails,
        policeStation,
        fullNameOfReporter,
        emailOfReporter,
        phoneOfReporter,
        relationShipToChild,
        confirmInformation,
        consentToShare,
        photos,
        firstNameErrorText,
        lastNameErrorText,
        ageErrorText,
        addressErrorText,
        genderErrorText,
        weightErrorText,
        heightErrorText,
        clothingDescriptionErrorText,
        descriptionErrorText,
        dateLastSeenError,
        lastSeenLocationError,
        vehicleDetailsError,
        fullBreakdownDetailsError,
        policeStationErrorText,
        fullNameOfReporterError,
        emailOfReporterError,
        phoneOfReporterError,
        relationShipToChildError,
        consentErrorText,
        originalCase,
      ];
}
