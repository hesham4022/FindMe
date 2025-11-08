import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

/// ======================
/// 🟢 طلب إنشاء تقرير
/// ======================
class CreateReportRequest extends Equatable {
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final double? weight;
  final double? height;
  final String? description;
  final bool hasVehicle;
  final String? vehicleDetails;
  final String? fullBreakdownDetails;
  final String address;
  final String? lastSeenLocation;
  final String? dateLastSeen;
  final double? latitude;
  final double? longitude;
  final bool confirmInformation;
  final bool consentToShare;
  final List<String> photos; // مسارات الصور في الجهاز

  const CreateReportRequest({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    this.weight,
    this.height,
    this.description,
    required this.hasVehicle,
    this.vehicleDetails,
    this.fullBreakdownDetails,
    required this.address,
    this.lastSeenLocation,
    this.dateLastSeen,
    this.latitude,
    this.longitude,
    required this.confirmInformation,
    required this.consentToShare,
    this.photos = const [],
  });

  /// للتحويل إلى Map (بدون الصور)
  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'age': age,
      'gender': gender,
      'weight': weight,
      'height': height,
      'description': description,
      'has_vehicle': hasVehicle,
      'vehicle_details': vehicleDetails,
      'full_breakdown_details': fullBreakdownDetails,
      'address': address,
      'last_seen_location': lastSeenLocation,
      'date_last_seen': dateLastSeen,
      'latitude': latitude,
      'longitude': longitude,
      'confirm_information': confirmInformation,
      'consent_to_share': consentToShare,
    };
  }

  /// لتحويل البيانات إلى Multipart Map (في حالة رفع صور)
  Map<String, dynamic> toMultipartMap() {
    final map = Map<String, dynamic>.from(toMap());
    if (photos.isNotEmpty) {
      map['photos'] = photos;
    }
    return map;
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        age,
        gender,
        weight,
        height,
        description,
        hasVehicle,
        vehicleDetails,
        fullBreakdownDetails,
        address,
        lastSeenLocation,
        dateLastSeen,
        latitude,
        longitude,
        confirmInformation,
        consentToShare,
        photos,
      ];
}

/// ======================
/// 🔵 رد إنشاء التقرير
/// ======================
class CreateReportResponse extends Equatable {
  final String message;
  final CaseInfoModel data;

  const CreateReportResponse({
    required this.message,
    required this.data,
  });

  factory CreateReportResponse.fromMap(Map<String, dynamic> map) {
    return CreateReportResponse(
      message: map['message'] ?? '',
      data: CaseInfoModel.fromMap(map['data'] ?? {}),
    );
  }

  factory CreateReportResponse.fromJson(String source) =>
      CreateReportResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [message, data];
}

/// ======================
/// 📋 بيانات التقرير
/// ======================
// class ReportData extends Equatable {
// final int id;
// final int userId;
// final String firstName;
// final String lastName;
// final int age;
// final String gender;
// final double? weight;
// final double? height;
// final String? description;
// final bool hasVehicle;
// final String? vehicleDetails;
// final String? fullBreakdownDetails;
// final String address;
// final String? lastSeenLocation;
// final String? dateLastSeen;
// final double? latitude;
// final double? longitude;
// final bool confirmInformation;
// final bool consentToShare;
// final List<ReportPhoto> photos;
// final String createdAt;
// final String updatedAt;

// const ReportData({
//   required this.id,
//   required this.userId,
//   required this.firstName,
//   required this.lastName,
//   required this.age,
//   required this.gender,
//   this.weight,
//   this.height,
//   this.description,
//   required this.hasVehicle,
//   this.vehicleDetails,
//   this.fullBreakdownDetails,
//   required this.address,
//   this.lastSeenLocation,
//   this.dateLastSeen,
//   this.latitude,
//   this.longitude,
//   required this.confirmInformation,
//   required this.consentToShare,
//   this.photos = const [],
//   required this.createdAt,
//   required this.updatedAt,
// });

// factory ReportData.fromMap(Map<String, dynamic> map) {
//   return ReportData(
//     id: map['id'] ?? 0,
//     userId: map['user_id'] ?? 0,
//     firstName: map['first_name'] ?? '',
//     lastName: map['last_name'] ?? '',
//     age: map['age'] ?? 0,
//     gender: map['gender'] ?? '',
//     weight: map['weight'] != null
//         ? double.tryParse(map['weight'].toString())
//         : null,
//     height: map['height'] != null
//         ? double.tryParse(map['height'].toString())
//         : null,
//     description: map['description'],
//     hasVehicle: map['has_vehicle'] ?? false,
//     vehicleDetails: map['vehicle_details'],
//     fullBreakdownDetails: map['full_breakdown_details'],
//     address: map['address'] ?? '',
//     lastSeenLocation: map['last_seen_location'],
//     dateLastSeen: map['date_last_seen'],
//     latitude: map['latitude'] != null
//         ? double.tryParse(map['latitude'].toString())
//         : null,
//     longitude: map['longitude'] != null
//         ? double.tryParse(map['longitude'].toString())
//         : null,
//     confirmInformation: map['confirm_information'] ?? false,
//     consentToShare: map['consent_to_share'] ?? false,
//     photos: map['photos'] == null
//         ? []
//         : List<ReportPhoto>.from(
//             (map['photos'] as List).map((x) => ReportPhoto.fromMap(x))),
//     createdAt: map['created_at'] ?? '',
//     updatedAt: map['updated_at'] ?? '',
//   );
// }

//   @override
//   List<Object?> get props => [
//         id,
//         userId,
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
//         createdAt,
//         updatedAt,
//       ];
// }

/// ======================
/// 🖼️ الصور
/// ======================
class ReportPhoto extends Equatable {
  final int id;
  final String url;
  final String createdAt;

  const ReportPhoto({
    required this.id,
    required this.url,
    required this.createdAt,
  });

  factory ReportPhoto.fromMap(Map<String, dynamic> map) {
    return ReportPhoto(
      id: map['id'] ?? 0,
      url: map['url'] ?? '',
      createdAt: map['created_at'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, url, createdAt];
}
