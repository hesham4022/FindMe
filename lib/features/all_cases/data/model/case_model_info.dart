import 'dart:convert';

import 'package:find_me_app/core/app_secured_data/env.dart';

class AllCasesResponse {
  List<CaseInfoModel> allCases;

  AllCasesResponse({this.allCases = const []});

  /// fromJson from String
  factory AllCasesResponse.fromJson(String str) =>
      AllCasesResponse.fromMap(jsonDecode(str));

  /// toJson to String
  String toJson() => jsonEncode(toMap());

  factory AllCasesResponse.fromMap(Map<String, dynamic> json) =>
      AllCasesResponse(
        allCases: json['data'] == null
            ? []
            : List<CaseInfoModel>.from(
                (json['data'] as List).map((x) => CaseInfoModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": allCases == null
            ? []
            : List<dynamic>.from(allCases.map((x) => x.toMap())),
      };

  AllCasesResponse copyWith({List<CaseInfoModel>? allCases}) =>
      AllCasesResponse(
        allCases: allCases ?? this.allCases,
      );
}

class CaseInfoModel {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  int? age;
  String? gender;
  double? weight;
  double? height;
  String? description;
  bool? hasVehicle;
  String? vehicleDetails;
  String? fullBreakdownDetails;
  String? address;
  String? lastSeenLocation;
  String? dateLastSeen;
  double? latitude;
  double? longitude;
  bool? confirmInformation;
  bool? consentToShare;
  List<Photo> photos;
  String? createdAt;
  String? updatedAt;
  bool isFavorite;

  CaseInfoModel({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.weight,
    this.height,
    this.description,
    this.hasVehicle,
    this.vehicleDetails,
    this.fullBreakdownDetails,
    this.address,
    this.lastSeenLocation,
    this.dateLastSeen,
    this.latitude,
    this.longitude,
    this.confirmInformation,
    this.consentToShare,
    this.photos = const [],
    this.createdAt,
    this.updatedAt,
    this.isFavorite = false,
  });

  factory CaseInfoModel.fromMap(Map<String, dynamic> json) => CaseInfoModel(
        id: json['id'],
        userId: json['user_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        age: json['age'],
        gender: json['gender'],
        weight: json['weight'] != null
            ? double.tryParse(json['weight'].toString())
            : null,
        height: json['height'] != null
            ? double.tryParse(json['height'].toString())
            : null,
        description: json['description'],
        hasVehicle: json['has_vehicle'],
        vehicleDetails: json['vehicle_details'],
        fullBreakdownDetails: json['full_breakdown_details'],
        address: json['address'],
        lastSeenLocation: json['last_seen_location'],
        dateLastSeen: json['date_last_seen'],
        latitude: json['latitude'] != null
            ? double.tryParse(json['latitude'].toString())
            : null,
        longitude: json['longitude'] != null
            ? double.tryParse(json['longitude'].toString())
            : null,
        confirmInformation: json['confirm_information'],
        consentToShare: json['consent_to_share'],
        photos: json['photos'] == null
            ? []
            : List<Photo>.from(
                (json['photos'] as List).map((x) => Photo.fromMap(x))),
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "age": age,
        "gender": gender,
        "weight": weight,
        "height": height,
        "description": description,
        "has_vehicle": hasVehicle,
        "vehicle_details": vehicleDetails,
        "full_breakdown_details": fullBreakdownDetails,
        "address": address,
        "last_seen_location": lastSeenLocation,
        "date_last_seen": dateLastSeen,
        "latitude": latitude,
        "longitude": longitude,
        "confirm_information": confirmInformation,
        "consent_to_share": consentToShare,
        "photos": photos == null
            ? []
            : List<dynamic>.from(photos!.map((x) => x.toMap())),
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  CaseInfoModel copyWith({
    int? id,
    int? userId,
    String? firstName,
    String? lastName,
    int? age,
    String? gender,
    double? weight,
    double? height,
    String? description,
    bool? hasVehicle,
    String? vehicleDetails,
    String? fullBreakdownDetails,
    String? address,
    String? lastSeenLocation,
    String? dateLastSeen,
    double? latitude,
    double? longitude,
    bool? confirmInformation,
    bool? consentToShare,
    List<Photo>? photos,
    String? createdAt,
    String? updatedAt,
    bool? isFavorite,
  }) =>
      CaseInfoModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        weight: weight ?? this.weight,
        height: height ?? this.height,
        description: description ?? this.description,
        hasVehicle: hasVehicle ?? this.hasVehicle,
        vehicleDetails: vehicleDetails ?? this.vehicleDetails,
        fullBreakdownDetails: fullBreakdownDetails ?? this.fullBreakdownDetails,
        address: address ?? this.address,
        lastSeenLocation: lastSeenLocation ?? this.lastSeenLocation,
        dateLastSeen: dateLastSeen ?? this.dateLastSeen,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        confirmInformation: confirmInformation ?? this.confirmInformation,
        consentToShare: consentToShare ?? this.consentToShare,
        photos: photos ?? this.photos,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

class Photo {
  int? id;
  String? url;
  String? createdAt;

  Photo({this.id, this.url, this.createdAt});

  factory Photo.fromMap(Map<String, dynamic> json) {
    String? rawUrl = json['url'];

    if (rawUrl != null) {
      // 🔹 لو الرابط فيه '/storage/https' → نحذف '/storage/'
      if (rawUrl.startsWith('/storage/https')) {
        rawUrl = rawUrl.replaceFirst('/storage/', '');
      }

      // 🔹 لو الرابط نسبي، نضيف الـ base URL اللي جاي من .env
      if (!rawUrl.startsWith('http')) {
        rawUrl = "${Env.baseDevUrl}$rawUrl";
      }
    }

    return Photo(
      id: json['id'],
      url: rawUrl,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "created_at": createdAt,
      };

  Photo copyWith({int? id, String? url, String? createdAt}) => Photo(
        id: id ?? this.id,
        url: url ?? this.url,
        createdAt: createdAt ?? this.createdAt,
      );
}

// // case_model_info.dart
// import 'package:find_me_app/core/helpers/enums/gender.dart';

// class CaseInfoModel {
//   final String? name;
//   final String? location;
//   final String? duration;
//   final String? views;
//   final String? imageUrl;
//   final String? id;
//   final Gender? gender;
//   final bool isFavorite;
//   final int? old;
//   final String? height; // الطول
//   final String? eyeColor; // لون العين
//   final String? skinColor; // لون البشرة
//   final String? hairColor; // لون الشعر
//   final String? birthMark;
//   final String? lastSeenWearing;
//   final String? detailsOfPerpetrator;
//   final String? detailsWhatHappene;

//   CaseInfoModel({
//     this.name,
//     this.location,
//     this.imageUrl,
//     this.gender,
//     this.id,
//     this.isFavorite = false,
//     this.old,
//     this.height,
//     this.eyeColor,
//     this.birthMark,
//     this.hairColor,
//     this.skinColor,
//     this.detailsOfPerpetrator,
//     this.detailsWhatHappene,
//     this.lastSeenWearing,
//     this.duration,
//     this.views,
//   });

//   CaseInfoModel copyWith({
//     String? name,
//     String? location,
//     String? imageUrl,
//     String? id,
//     Gender? gender,
//     bool? isFavorite,
//     int? old,
//     String? height, // الطول
//     String? eyeColor, // لون العين
//     String? skinColor, // لون البشرة
//     String? hairColor, // لون الشعر
//     String? birthMark,
//     String? lastSeenWearing,
//     String? detailsOfPerpetrator,
//     String? detailsWhatHappene,
//     String? duration,
//     String? views,
//   }) {
//     return CaseInfoModel(
//       name: name ?? this.name,
//       location: location ?? this.location,
//       imageUrl: imageUrl ?? this.imageUrl,
//       gender: gender ?? this.gender,
//       id: id ?? this.id,
//       isFavorite: isFavorite ?? this.isFavorite,
//       old: old ?? this.old,
//       height: height ?? this.height,
//       eyeColor: eyeColor ?? this.eyeColor,
//       skinColor: skinColor ?? this.skinColor,
//       hairColor: hairColor ?? this.hairColor,
//       birthMark: birthMark ?? this.birthMark,
//       lastSeenWearing: lastSeenWearing ?? this.lastSeenWearing,
//       detailsOfPerpetrator: detailsOfPerpetrator ?? this.detailsOfPerpetrator,
//       detailsWhatHappene: detailsWhatHappene ?? this.detailsWhatHappene,
//       duration: duration ?? this.duration,
//       views: views ?? this.views,
//     );
//   }
// }
