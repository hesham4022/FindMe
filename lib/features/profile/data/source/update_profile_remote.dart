import 'dart:convert';

import 'dart:io';

import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/profile/data/model/update_profile_model.dart';
import 'package:path/path.dart';

class UpdateProfileRemote {
  UpdateProfileRemote();

  Future<Map<String, dynamic>> addCase(UpdateProfileRequest data) async {
    // final client = sl<AppHttpClient>().client;

    try {
      final fields = {
        'full_name': data.fullName,
        'email': data.email,
        'mobile_number': data.mobileNumber,
        'date_of_birth': data.dateOfBirth,
      };

      final files = <UploadFile>[];

      if (data.photo != null && data.photo!.isNotEmpty) {
        files.add(
          UploadFile(
            file: File(data.photo!),
            fieldName: 'photo',
            name: basename(data.photo!),
          ),
        );
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

      if (response.statusCode >= 400) {
        final message = json['message'] ?? 'Server error';
        throw ServerException(message);
      }

      return json;
    } finally {}
  }
}
