// import 'dart:convert';
// import 'dart:io';
// import 'package:find_me_app/core/helpers/enums/request_type.dart';
// import 'package:find_me_app/core/networking/api_constants.dart';
// import 'package:find_me_app/core/networking/functions.dart';
// import 'package:find_me_app/core/shared/models/upload_file.dart';
// import 'package:find_me_app/features/add_case/data/model/create_report.dart';

// import 'package:path/path.dart';

// class UpdateReportRemote {
//   UpdateReportRemote();

//   Future<Map<String, dynamic>> updateReport(
//       String id, CreateReportRequest data) async {
//     try {
//       final fields = {
//         'first_name': data.firstName,
//         'last_name': data.lastName,
//         'age': '${data.age ?? ''}',
//         'gender': data.gender,
//         'weight': data.weight?.toString() ?? '',
//         'height': data.height?.toString() ?? '',
//         'description': data.description ?? '',
//         'has_vehicle': data.hasVehicle ? '1' : '0',
//         'vehicle_details': data.vehicleDetails ?? '',
//         'full_breakdown_details': data.fullBreakdownDetails ?? '',
//         'address': data.address,
//         'last_seen_location': data.lastSeenLocation ?? '',
//         'date_last_seen': data.dateLastSeen ?? '',
//         'latitude': data.latitude?.toString() ?? '',
//         'longitude': data.longitude?.toString() ?? '',
//         'confirm_information': data.confirmInformation ? '1' : '0',
//         'consent_to_share': data.consentToShare ? '1' : '0',
//       };

//       // إضافة الصور إذا كانت موجودة
//       final files = <UploadFile>[];

//       if (data.photos.isNotEmpty) {
//         for (final photoPath in data.photos) {
//           if (photoPath.isNotEmpty) {
//             files.add(
//               UploadFile(
//                 file: File(photoPath),
//                 fieldName: 'photos[]',
//                 name: basename(photoPath),
//               ),
//             );
//           }
//         }
//       }

//       final headers = {
//         'Accept': 'application/json',
//         'lang': 'EN',
//       };

//       // إجراء الـ PUT request
//       final response = await makeMultipartRequest(
//         url: ApiConstants.updateReportUrl + id,
//         requestType: HttpRequestType.put,
//         fields: fields,
//         files: files,
//         headers: headers,
//         requiresAuth: true, // يجب وجود التوثيق هنا
//       );

//       final body = utf8.decode(response.bodyBytes);
//       final json = jsonDecode(body);

//       print('[log] [📩 RESPONSE CODE]: ${response.statusCode}');
//       print('[log] [📩 RESPONSE BODY]: $json');

//       if (response.statusCode >= 400) {
//         final message = json['message'] ?? 'Server error';
//         throw Exception(
//             message); // يمكن استبدال بـ Exception مخصص مثل ServerException
//       }

//       return json; // إرجاع الاستجابة
//     } catch (e) {
//       print('Error updating report: $e');
//       rethrow;
//     }
//   }
// }
