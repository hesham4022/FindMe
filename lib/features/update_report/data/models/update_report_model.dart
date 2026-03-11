// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

// class UpdateReportRequest extends Equatable {
//   final int id;
//   final String firstName;
//   final String lastName;
//   final int age;
//   final String gender;
//   final double? weight;
//   final double? height;
//   final String? description;
//   final bool hasVehicle;
//   final String? vehicleDetails;
//   final String? fullBreakdownDetails;
//   final String address;
//   final String? lastSeenLocation;
//   final String? dateLastSeen;
//   final double? latitude;
//   final double? longitude;
//   final bool confirmInformation;
//   final bool consentToShare;
//   final List<String> photos; // مسارات الصور في الجهاز

//   const UpdateReportRequest({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.age,
//     required this.gender,
//     this.weight,
//     this.height,
//     this.description,
//     required this.hasVehicle,
//     this.vehicleDetails,
//     this.fullBreakdownDetails,
//     required this.address,
//     this.lastSeenLocation,
//     this.dateLastSeen,
//     this.latitude,
//     this.longitude,
//     required this.confirmInformation,
//     required this.consentToShare,
//     this.photos = const [],
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'first_name': firstName,
//       'last_name': lastName,
//       'age': age,
//       'gender': gender,
//       'weight': weight,
//       'height': height,
//       'description': description,
//       'has_vehicle': hasVehicle,
//       'vehicle_details': vehicleDetails,
//       'full_breakdown_details': fullBreakdownDetails,
//       'address': address,
//       'last_seen_location': lastSeenLocation,
//       'date_last_seen': dateLastSeen,
//       'latitude': latitude,
//       'longitude': longitude,
//       'confirm_information': confirmInformation,
//       'consent_to_share': consentToShare,
//     };
//   }

//   Map<String, dynamic> toMultipartMap() {
//     final map = Map<String, dynamic>.from(toMap());
//     if (photos.isNotEmpty) {
//       map['photos'] = photos;
//     }
//     return map;
//   }

//   String toJson() => jsonEncode(toMap());

//   @override
//   List<Object?> get props => [
//         id,
//         firstName,
//         lastName,
//         age,
//         gender,
//         weight,
//         height,
//         description,
//         hasVehicle,
//         vehicleDetails,
//         fullBreakdownDetails,
//         address,
//         lastSeenLocation,
//         dateLastSeen,
//         latitude,
//         longitude,
//         confirmInformation,
//         consentToShare,
//         photos,
//       ];
// }

// class UpdateReportResponse extends Equatable {
//   final String message;
//   final CaseInfoModel data;

//   const UpdateReportResponse({
//     required this.message,
//     required this.data,
//   });

//   factory UpdateReportResponse.fromMap(Map<String, dynamic> map) {
//     return UpdateReportResponse(
//       message: map['message'] ?? '',
//       data: CaseInfoModel.fromMap(map['data'] ?? {}),
//     );
//   }

//   factory UpdateReportResponse.fromJson(String source) =>
//       UpdateReportResponse.fromMap(jsonDecode(source));

//   @override
//   List<Object?> get props => [message, data];
// }

// class ReportPhoto extends Equatable {
//   final int id;
//   final String url;
//   final String createdAt;

//   const ReportPhoto({
//     required this.id,
//     required this.url,
//     required this.createdAt,
//   });

//   factory ReportPhoto.fromMap(Map<String, dynamic> map) {
//     return ReportPhoto(
//       id: map['id'] ?? 0,
//       url: map['url'] ?? '',
//       createdAt: map['created_at'] ?? '',
//     );
//   }

//   @override
//   List<Object?> get props => [id, url, createdAt];
// }
