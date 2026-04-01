import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';
import 'package:path/path.dart';

class AllCasesRemote {
  AllCasesRemote();

  Future<String> getAllCasesResponseData() async {
    final response = await makeHttpRequest(
      url: ApiConstants.allReportsUrl,
      requestType: HttpRequestType.get,
      needParsedResponse: false,
      requiresAuth: true,
    );
    return utf8.decode(response.bodyBytes);
  }

  // Future<String> getCaseByIdResponseData(String id) async {
  //   final response = await makeHttpRequest(
  //     url: ApiConstants.getCaseByIdUrl + id,
  //     requestType: HttpRequestType.get,
  //     // client: _client,
  //     needParsedResponse: false,
  //   );
  //   // final parsedResponse = ParseGeneralResponse.fromJson(response.body);
  //   // kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
  //   return utf8.decode(response.bodyBytes);
  // }

  Future<Map<String, dynamic>> searchByImage(SearchByImageRequest data) async {
    try {
      // final fields = <String, String>{};

      final files = <UploadFile>[];
      if (data.imagePath.isNotEmpty) {
        files.add(UploadFile(
          file: File(data.imagePath),
          fieldName: 'images[]',
          name: basename(data.imagePath),
        ));
      }

      final headers = {'Accept': 'application/json', 'lang': 'EN'};

      final response = await makeMultipartRequest(
        url: ApiConstants.searchByImageUrl,
        requestType: HttpRequestType.post,
        // fields: fields,
        files: files,
        headers: headers,
        requiresAuth: true,
      );

      final body = utf8.decode(response.bodyBytes);
      final json = jsonDecode(body);

      print('[log] [🔍 SEARCH IMAGE RESPONSE CODE]: ${response.statusCode}');
      print('[log] [🔍 SEARCH IMAGE RESPONSE BODY]: $json');

      // ✅ تحقق من كود الحالة
      if (response.statusCode >= 400) {
        final message = json['message'] ?? 'Failed search by image';
        throw ServerException(message);
      }

      return json;
    } catch (e) {
      print('[ERROR] searchByImage: $e');
      rethrow;
    }
  }

  Future<bool> toggleLike(int reportId) async {
    final response = await makeHttpRequest(
      url: '${ApiConstants.isLiked}$reportId',
      requestType: HttpRequestType.post,
      requiresAuth: true,
      needParsedResponse: false,
    );

    log('[❤️ LIKE RESPONSE CODE]: ${response.statusCode}');
    log('[❤️ LIKE RESPONSE BODY]: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to toggle like');
    }

    final json = jsonDecode(utf8.decode(response.bodyBytes));

    return json['isLiked'] ?? false;
  }
}
