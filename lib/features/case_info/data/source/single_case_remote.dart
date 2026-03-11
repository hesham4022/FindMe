import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';

class SingleCaseRemote {
  Future<String> getCaseByIdResponseData(String id) async {
    final response = await makeHttpRequest(
      url: ApiConstants.getCaseByIdUrl + id,
      requestType: HttpRequestType.get,
      needParsedResponse: false,
    );

    return utf8.decode(response.bodyBytes);
  }
}
