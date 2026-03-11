import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/networking/http_interceptors.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddCaseRemote {
  AddCaseRemote();

  Future<Map<String, dynamic>> addCase(CreateReportRequest data) async {
    // final client = sl<AppHttpClient>().client;

    try {
      final fields = {
        'first_name': data.firstName,
        'last_name': data.lastName,
        'age': '${data.age ?? ''}',
        'gender': data.gender,
        'weight': data.weight?.toString() ?? '',
        'height': data.height?.toString() ?? '',
        'description': data.description ?? '',
        'has_vehicle': data.hasVehicle ? '1' : '0',
        'vehicle_details': data.vehicleDetails ?? '',
        'full_breakdown_details': data.fullBreakdownDetails ?? '',
        'address': data.address,
        'last_seen_location': data.lastSeenLocation ?? '',
        'date_last_seen': data.dateLastSeen ?? '',
        'latitude': data.latitude?.toString() ?? '',
        'longitude': data.longitude?.toString() ?? '',
        'confirm_information': data.confirmInformation ? '1' : '0',
        'consent_to_share': data.consentToShare ? '1' : '0',
      };

      final files = <UploadFile>[];

      if (data.photos.isNotEmpty) {
        for (final photoPath in data.photos) {
          if (photoPath.isNotEmpty) {
            files.add(
              UploadFile(
                file: File(photoPath),
                fieldName: 'photos[]',
                name: basename(photoPath),
              ),
            );
          }
        }
      }

      final authLocal = sl<AuthLocal>();
      final token = await authLocal.getAccessToken();
      print("token = $token");
      final headers = {
        'Accept': 'application/json',
        'lang': 'EN',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final response = await makeMultipartRequest(
        url: ApiConstants.createReportURL,
        requestType: HttpRequestType.post,
        // client: client,
        fields: fields,
        files: files,
        headers: headers,
      );

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print('[log] [📩 RESPONSE CODE]: ${response.statusCode}');
      print('[log] [📩 RESPONSE BODY]: $json');

      // ✅ تحقق من كود الحالة
      if (response.statusCode >= 400) {
        final message = json['message'] ?? 'Server error';
        throw ServerException(message);
      }

      return json;
    } finally {}
  }
}
