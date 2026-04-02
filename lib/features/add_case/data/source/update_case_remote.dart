import 'dart:convert';
import 'dart:io';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:http/http.dart' as http;

class UpdateCaseRemote {
  UpdateCaseRemote();

  Future<Map<String, dynamic>> updateCase(
      CreateReportRequest data, int id) async {
    try {
      final authLocal = sl<AuthLocal>();
      final token = await authLocal.getAccessToken();

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'lang': 'EN',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final body = jsonEncode({
        'first_name': data.firstName,
        'last_name': data.lastName,
        'age': data.age,
        'gender': data.gender,
        'weight': data.weight,
        'height': data.height,
        'description': data.description ?? '',
        'has_vehicle': data.hasVehicle ? 1 : 0,
        'vehicle_details': data.vehicleDetails ?? '',
        'full_breakdown_details': data.fullBreakdownDetails ?? '',
        'address': data.address,
        'last_seen_location': data.lastSeenLocation ?? '',
        'date_last_seen': data.dateLastSeen ?? '',
        'latitude': data.latitude,
        'longitude': data.longitude,
        'confirm_information': data.confirmInformation,
        'consent_to_share': data.consentToShare,
      });

      final response = await http.put(
        Uri.parse('${ApiConstants.updateReportURL}/$id'),
        headers: headers,
        body: body,
      );

      final responseBody = utf8.decode(response.bodyBytes);
      final json = jsonDecode(responseBody);

      print('[log] [📩 RESPONSE CODE]: ${response.statusCode}');
      print('[log] [📩 RESPONSE BODY]: $json');

      if (response.statusCode >= 400) {
        throw ServerException(json['message'] ?? 'Server error');
      }
      return json;
    } finally {}
  }
}
