import 'dart:convert';

import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

class SingleCaseResponse {
  final CaseInfoModel data;

  SingleCaseResponse({required this.data});

  factory SingleCaseResponse.fromJson(String str) =>
      SingleCaseResponse.fromMap(jsonDecode(str));

  factory SingleCaseResponse.fromMap(Map<String, dynamic> json) =>
      SingleCaseResponse(
        data: CaseInfoModel.fromMap(json['data']),
      );

  Map<String, dynamic> toMap() => {
        "data": data.toMap(),
      };

  String toJson() => jsonEncode(toMap());
}
