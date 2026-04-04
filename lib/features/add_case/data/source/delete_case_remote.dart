import 'dart:convert';
import 'dart:io';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/error_management/exception.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/features/add_case/data/model/create_report.dart';
import 'package:find_me_app/features/auth/data/source/auth_local.dart';
import 'package:http/http.dart' as http;

class DeleteCaseRemote {
  DeleteCaseRemote();

  Future<Map<String, dynamic>> deleteCase(int caseId) async {
    try {
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'lang': 'EN',
      };
      final response = await http.delete(
        Uri.parse('${ApiConstants.updateReportURL}/$caseId'),
        headers: headers,
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
