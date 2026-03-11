// import 'dart:convert';
// import 'package:equatable/equatable.dart';
// import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

// class SearchByImageRequest extends Equatable {
//   final String imagePath;

//   const SearchByImageRequest({
//     required this.imagePath,
//   });

//   Map<String, String> toMap() {
//     return {
//       'image': imagePath,
//     };
//   }

//   Map<String, dynamic> toMultipartMap() {
//     return {
//       'image': imagePath,
//     };
//   }

//   String toJson() => jsonEncode(toMap());

//   @override
//   List<Object?> get props => [imagePath];
// }

// class SearchByImageResponse extends Equatable {
//   final List<CaseInfoModel> cases;
//   final String? message;

//   const SearchByImageResponse({
//     required this.cases,
//     this.message,
//   });

//   factory SearchByImageResponse.fromJson(String str) =>
//       SearchByImageResponse.fromMap(jsonDecode(str));

//   factory SearchByImageResponse.fromMap(Map<String, dynamic> json) =>
//       SearchByImageResponse(
//         message: json['message'],
//         cases: json['data'] == null
//             ? []
//             : List<CaseInfoModel>.from(
//                 (json['data'] as List).map((x) => CaseInfoModel.fromMap(x))),
//       );

//   String toJson() => jsonEncode(toMap());

//   Map<String, dynamic> toMap() => {
//         "message": message,
//         "data": cases == null
//             ? []
//             : List<dynamic>.from(cases.map((x) => x.toMap())),
//       };

//   SearchByImageResponse copyWith({
//     List<CaseInfoModel>? cases,
//     String? message,
//   }) =>
//       SearchByImageResponse(
//         cases: cases ?? this.cases,
//         message: message ?? this.message,
//       );

//   @override
//   List<Object?> get props => [cases, message];
// }

import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:find_me_app/features/all_cases/data/model/case_model_info.dart';

class SearchByImageRequest extends Equatable {
  final String imagePath;

  const SearchByImageRequest({
    required this.imagePath,
  });

  Map<String, String> toMap() {
    return {
      'image': imagePath,
    };
  }

  Map<String, dynamic> toMultipartMap() {
    return {
      'image': imagePath,
    };
  }

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [imagePath];
}

class SearchByImageResponse extends Equatable {
  final List<CaseInfoModel> cases;
  final String? message;
  final bool? matchFound;

  const SearchByImageResponse({
    required this.cases,
    this.message,
    this.matchFound,
  });

  factory SearchByImageResponse.fromJson(String str) =>
      SearchByImageResponse.fromMap(jsonDecode(str));

  factory SearchByImageResponse.fromMap(Map<String, dynamic> json) {
    List<CaseInfoModel> extractedCases = [];

    if (json['matches'] != null && json['matches'] is List) {
      extractedCases = (json['matches'] as List)
          .map((match) {
            final reportData = match['report_data'];
            if (reportData != null) {
              return CaseInfoModel.fromMap(reportData);
            }
            return null;
          })
          .whereType<CaseInfoModel>()
          .toList();
    } else if (json['data'] != null && json['data'] is List) {
      extractedCases =
          (json['data'] as List).map((x) => CaseInfoModel.fromMap(x)).toList();
    }

    return SearchByImageResponse(
      message: json['message'],
      matchFound: json['match_found'],
      cases: extractedCases,
    );
  }

  String toJson() => jsonEncode(toMap());

  Map<String, dynamic> toMap() => {
        "message": message,
        "match_found": matchFound,
        "data": cases == null
            ? []
            : List<dynamic>.from(cases.map((x) => x.toMap())),
      };

  SearchByImageResponse copyWith({
    List<CaseInfoModel>? cases,
    String? message,
    bool? matchFound,
  }) =>
      SearchByImageResponse(
        cases: cases ?? this.cases,
        message: message ?? this.message,
        matchFound: matchFound ?? this.matchFound,
      );

  @override
  List<Object?> get props => [cases, message, matchFound];
}
