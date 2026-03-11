import 'dart:convert';

import 'package:find_me_app/core/helpers/enums/request_type.dart';
import 'package:find_me_app/core/networking/api_constants.dart';
import 'package:find_me_app/core/networking/functions.dart';
import 'package:find_me_app/features/likes/data/model/like_model.dart';

class LikeRemote {
  Future<LikeResponse> likeInPost(String id) async {
    final response = await makeHttpRequest(
      url: ApiConstants.likeInPostUrl + id,
      requestType: HttpRequestType.post,
      needParsedResponse: false,
    );

    final responseString = utf8.decode(response.bodyBytes);
    final jsonMap = jsonDecode(responseString);

    return LikeResponse.fromMap(jsonMap);
  }
}
