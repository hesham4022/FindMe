import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/error_response.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/core/networking/http_interceptors.dart';
import 'package:http/http.dart' as http;

class AllCasesRemote {
  AllCasesRemote(
    this._client,
  );

  final http.Client _client;

  Future<String> getAllCasesResponseData() async {
    final response = await makeHttpRequest(
      url: ApiConstants.allReportsUrl,
      requestType: HttpRequestType.get,
      // client: _client,
      needParsedResponse: false,
    );
    // final parsedResponse = ParseGeneralResponse.fromJson(response.body);
    // kThrowAuthExceptionIfFails(parsedResponse.code, parsedResponse.msg);
    return utf8.decode(response.bodyBytes);
  }
}
