import 'dart:convert';
import 'dart:developer';

class BaseUrlResponse {
  int? id;
  String? nameA;
  String? nameL;
  int? licenseEmps;
  DateTime? licenseStartDate;
  num? licenseDurationMonths;
  DateTime? licenseEndDate;
  int? boUsersLimit;
  String? tokenId;
  String? boUrl;
  final String? mobileUrl;
  int? port;
  int? status;
  DateTime? statusDate;
  String? email;
  int? mobile;
  String? remarks;
  String? schemaName;

  BaseUrlResponse({
    this.id,
    this.nameA,
    this.nameL,
    this.licenseEmps,
    this.licenseStartDate,
    this.licenseDurationMonths,
    this.licenseEndDate,
    this.boUsersLimit,
    this.tokenId,
    this.boUrl,
    this.mobileUrl,
    this.port,
    this.status,
    this.statusDate,
    this.email,
    this.mobile,
    this.remarks,
    this.schemaName,
  });

  factory BaseUrlResponse.fromMap(Map<String, dynamic> json) {
    return BaseUrlResponse(
      id: json["id"],
      nameA: json["nameA"],
      nameL: json["nameL"],
      licenseEmps: json["licenseEmps"],
      licenseStartDate: json["licenseStartDate"] == null
          ? null
          : DateTime.parse(json["licenseStartDate"]),
      licenseDurationMonths: json["licenseDurationMonths"],
      licenseEndDate: json["licenseEndDate"] == null
          ? null
          : DateTime.parse(json["licenseEndDate"]),
      boUsersLimit: json["boUsersLimit"],
      tokenId: json["tokenId"],
      boUrl: json["boUrl"],
      mobileUrl: json["mobileUrl"],
      port: json["port"],
      status: json["status"],
      statusDate: json["statusDate"] == null
          ? null
          : DateTime.parse(json["statusDate"]),
      email: json["email"],
      mobile: json["mobile"],
      remarks: json["remarks"],
      schemaName: json["schemaName"],
    );
  }

  factory BaseUrlResponse.fromJson(String jsonString) {
    try {
      final decodedJson = jsonDecode(jsonString);
      return BaseUrlResponse.fromMap(decodedJson);
    } catch (e) {
      log("Error decoding JSON: $e");
      return BaseUrlResponse(); // Return an empty object to prevent crashes
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nameA": nameA,
      "nameL": nameL,
      "licenseEmps": licenseEmps,
      "licenseStartDate": licenseStartDate?.toIso8601String(),
      "licenseDurationMonths": licenseDurationMonths,
      "licenseEndDate": licenseEndDate?.toIso8601String(),
      "boUsersLimit": boUsersLimit,
      "tokenId": tokenId,
      "boUrl": boUrl,
      "mobileUrl": mobileUrl,
      "port": port,
      "status": status,
      "statusDate": statusDate?.toIso8601String(),
      "email": email,
      "mobile": mobile,
      "remarks": remarks,
      "schemaName": schemaName,
    };
  }

  BaseUrlResponse copyWith({
    int? id,
    String? nameA,
    String? nameL,
    int? licenseEmps,
    DateTime? licenseStartDate,
    num? licenseDurationMonths,
    DateTime? licenseEndDate,
    int? boUsersLimit,
    String? tokenId,
    String? boUrl,
    String? mobileUrl,
    int? port,
    int? status,
    DateTime? statusDate,
    String? email,
    int? mobile,
    String? remarks,
    String? schemaName,
  }) {
    return BaseUrlResponse(
      id: id ?? this.id,
      nameA: nameA ?? this.nameA,
      nameL: nameL ?? this.nameL,
      licenseEmps: licenseEmps ?? this.licenseEmps,
      licenseStartDate: licenseStartDate ?? this.licenseStartDate,
      licenseDurationMonths:
          licenseDurationMonths ?? this.licenseDurationMonths,
      licenseEndDate: licenseEndDate ?? this.licenseEndDate,
      boUsersLimit: boUsersLimit ?? this.boUsersLimit,
      tokenId: tokenId ?? this.tokenId,
      boUrl: boUrl ?? this.boUrl,
      mobileUrl: mobileUrl ?? this.mobileUrl,
      port: port ?? this.port,
      status: status ?? this.status,
      statusDate: statusDate ?? this.statusDate,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      remarks: remarks ?? this.remarks,
      schemaName: schemaName ?? this.schemaName,
    );
  }
}
