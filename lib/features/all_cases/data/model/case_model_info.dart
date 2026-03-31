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
  bool isLiked;
  double? similarityScore;

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
    this.isLiked = false,
    this.similarityScore,
  });

  factory CaseInfoModel.fromMap(Map<String, dynamic> json) => CaseInfoModel(
        id: json['id'],
        userId: json['user_id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        age: json['age'],
        gender: json['gender'],
        isLiked: json['isLiked'] ?? false,
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
        "similarity_score": similarityScore,
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
    double? similarityScore,
    double? latitude,
    double? longitude,
    bool? confirmInformation,
    bool? consentToShare,
    List<Photo>? photos,
    String? createdAt,
    String? updatedAt,
    bool? isLiked,
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
        isLiked: isLiked ?? this.isLiked,
        similarityScore: similarityScore ?? this.similarityScore,
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
