import 'dart:convert';
import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';

class DeleteCaseRemote {
  DeleteCaseRemote();

  Future<String> deleteCase(int CaseId) async {
    final response = await makeHttpRequest(
      url: ('${ApiConstants.updateReportURL}/$CaseId'),
      requestType: HttpRequestType.delete,
      requiresAuth: true,
      needParsedResponse: false,
    );
    final responseString = utf8.decode(response.bodyBytes);
    final jsonData = jsonDecode(responseString);
    return jsonData['message'] ?? "error try again";
  }
}
