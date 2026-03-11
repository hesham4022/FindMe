// import 'dart:convert';
// import 'dart:io';

// import 'package:find_me_app/core/error_management/exception.dart';
// import 'package:find_me_app/core/helpers/enums/request_type.dart';
// import 'package:find_me_app/core/networking/api_constants.dart';
// import 'package:find_me_app/core/networking/functions.dart';
// import 'package:find_me_app/core/shared/models/upload_file.dart';
// import 'package:find_me_app/features/search_case/data/model/search_by_image_model.dart';
// import 'package:path/path.dart';

// class SearchImageRemote {
//   SearchImageRemote();

//   // Future<String> searchImageRemote() async {
//   //   final response = await makeHttpRequest(
//   //     url: ApiConstants.allReportsUrl,
//   //     requestType: HttpRequestType.post,
//   //     needParsedResponse: false,
//   //   );
//   //   return utf8.decode(response.bodyBytes);
//   // }

//   Future<Map<String, dynamic>> searchByImage(SearchByImageRequest data) async {
//     try {
//       final fields = <String, String>{};

//       final files = <UploadFile>[];
//       if (data.imagePath.isNotEmpty) {
//         files.add(UploadFile(
//           file: File(data.imagePath),
//           fieldName: 'image',
//           name: basename(data.imagePath),
//         ));
//       }

//       final headers = {'Accept': 'application/json', 'lang': 'EN'};

//       final response = await makeMultipartRequest(
//         url: "",
//         requestType: HttpRequestType.post,
//         fields: fields,
//         files: files,
//         headers: headers,
//         requiresAuth: true, // احتاج Authorization في الغالب
//       );

//       final body = utf8.decode(response.bodyBytes);
//       final json = jsonDecode(body);

//       print('[log] [🔍 SEARCH IMAGE RESPONSE CODE]: ${response.statusCode}');
//       print('[log] [🔍 SEARCH IMAGE RESPONSE BODY]: $json');

//       // ✅ تحقق من كود الحالة
//       if (response.statusCode >= 400) {
//         final message = json['message'] ?? 'فشل البحث بالصورة';
//         throw ServerException(message);
//       }

//       return json;
//     } finally {
//       client.close();
//     }
//   }
// }
