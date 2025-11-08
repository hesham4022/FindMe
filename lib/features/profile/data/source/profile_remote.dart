import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:http/http.dart' as http;

class ProfileRemote {
  ProfileRemote(
    this._client,
  );

  final http.Client _client;

  //! Profile Data Endpoints -----------------------------------------------------------
  Future<String> getProfileData(int employeeId) async {
    final response = await makeHttpRequest2(
      url: ApiConstants.profileData(employeeId),
      requestType: HttpRequestType.get,
      client: _client,
      needParsedResponse: false,
    );

    return utf8.decode(response.bodyBytes);
  }
}
