import 'dart:convert';
import 'dart:io';

import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:path/path.dart';

class AgeFilterRemote {
  AgeFilterRemote();

  Future<String> applyAgeFilter(AgeFilterRequest data) async {
    try {
      final files = <UploadFile>[];
      if (data.imagePath.isNotEmpty) {
        files.add(UploadFile(
          file: File(data.imagePath),
          fieldName: 'file',
          name: basename(data.imagePath),
        ));
      }

      final fields = <String, String>{
        'source_age': data.sourceAge.toString(),
        'target_age': data.targetAge.toString(),
      };

      final response = await makeMultipartRequest(
        url: 'https://ahmed-sayed404-face-aging-ai.hf.space/predict',
        requestType: HttpRequestType.post,
        files: files,
        fields: fields, // ✅ هنا مش في الـ URL
        headers: {'Accept': 'application/json'},
        requiresAuth: false,
      );

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print('[log] [🧓 AGE FILTER RESPONSE CODE]: ${response.statusCode}');
      print('[log] [🧓 AGE FILTER RESPONSE BODY]: $json');

      if (response.statusCode >= 400) {
        final message = json['message'] ?? 'Age filter failed';
        throw ServerException(message);
      }

      final imagePath = json['image_url'] as String?;
      if (imagePath == null) throw ServerException('No image returned');

      return 'https://ahmed-sayed404-face-aging-ai.hf.space$imagePath';
    } catch (e) {
      print('[ERROR] applyAgeFilter: $e');
      rethrow;
    }
  }
}

class AgeFilterRequest {
  final String imagePath;
  final int sourceAge;
  final int targetAge;

  const AgeFilterRequest({
    required this.imagePath,
    required this.sourceAge,
    required this.targetAge,
  });
}
