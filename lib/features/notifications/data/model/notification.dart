import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/shared/models/get_actions_data.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:find_me_app/core/di.dart';
import 'package:find_me_app/core/shared/functions.dart';
import 'package:find_me_app/features/app/data/source/app_local.dart';

class NotificationsResponse {
  final List<NotificationModel> notifications;
  final int? count;

  NotificationsResponse({
    required this.notifications,
    this.count,
  });

  factory NotificationsResponse.fromMap(Map<String, dynamic> map) {
    return NotificationsResponse(
      count: map['totalElements'] ?? 0,
      notifications: List<NotificationModel>.from(
        map['content']?.map((x) => NotificationModel.fromMap(x)),
      ),
    );
  }

  factory NotificationsResponse.fromJson(String json) =>
      NotificationsResponse.fromMap(jsonDecode(json)['notifications']);
}

class NotificationModel extends Equatable {
  final num? id;
  final num? flowId; //
  final String? title;
  final NotificationBody? body;
  final String? stringBody;
  final RequestType? requestType; // type
  final DateTime? createdOn;
  final bool read;
  final num? specialReference; // request id
  final String? reqActionType;
  final String? isWorkflowCompleted;
  final String? decisionType;
  final bool isAck;
  final num? employeeId;
  // final bool isManager; // 3: Employee, 2: Manager

  bool get showActions =>
      (reqActionType == "2" && decisionType == "0") ? true : false;

  bool get canNavToDetails => (specialReference != null &&
          requestType != null &&
          flowId != null &&
          (reqActionType == "2" ||
              reqActionType == "1" ||
              (requestType == RequestType.evaluation &&
                  reqActionType == "3")) &&
          decisionType == "0")
      ? true
      : false;

  const NotificationModel({
    this.id,
    this.reqActionType,
    this.isWorkflowCompleted,
    this.decisionType,
    this.flowId,
    this.title,
    this.body,
    this.stringBody,
    this.requestType,
    this.createdOn,
    this.read = false,
    this.specialReference,
    this.isAck = false,
    this.employeeId,
    // this.isManager = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'flowId': flowId,
      'title': title,
      'body': body,
      'type': requestType,
      'createdOn': createdOn?.toIso8601String(),
      'read': read ? '2' : '1',
      'isACK': isAck ? '1' : '0',
    };
  }

  String get parseCreatedOn => createdOn == null
      ? ""
      : GetTimeAgo.parse(createdOn!,
          locale: sl<AppLocal>().getCachedLanguage());

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    late Map<String, String> parsedData = kParseOneLineData(map['body']);

    return NotificationModel(
      id: map['id'],
      reqActionType: map['reqActionType']?.toString(),
      isWorkflowCompleted: map['isWorkflowCompleted']?.toString(),
      decisionType: map['decisionType']?.toString(),
      flowId:
          map['flowId'] is String ? num.tryParse(map['flowId']) : map['flowId'],
      title: map['title'],
      body: map['body'] != null ? NotificationBody.fromMap(parsedData) : null,
      stringBody:
          map['body'] != null && map['body'] is String ? map['body'] : null,
      // stringBody: map['reqActionType']?.toString() == "3" ? map['body'] : null,
      requestType: map['type'] != null
          ? RequestTypeExtension.fromId(num.tryParse(map['type']))
          : null,
      createdOn:
          map['createdOn'] != null ? DateTime.parse(map['createdOn']) : null,
      read: map['read'] == '2' ? true : false,
      specialReference: map['specialReference'] is String
          ? num.tryParse(map['specialReference'])
          : map['specialReference'],
      isAck: (map['isAck'] == 1 || map['isAck'] == '1') ? true : false,
      employeeId: map['employeeId'] is String
          ? num.tryParse(map['employeeId'])
          : map['employeeId'],
      // isManager: map['isManager'] == '2' ? true : false,
    );
  }

  @override
  List<Object?> get props => [title, body, requestType, createdOn, read];

  NotificationModel copyWith({
    String? title,
    NotificationBody? body,
    RequestType? type,
    DateTime? createdOn,
    bool? read,
    num? specialReference,
    num? id,
    String? reqActionType,
    num? flowId,
    String? stringBody,
    String? isWorkflowCompleted,
    String? decisionType,
  }) {
    return NotificationModel(
      id: id,
      title: title ?? this.title,
      body: body ?? this.body,
      requestType: type ?? requestType,
      createdOn: createdOn ?? this.createdOn,
      read: read ?? this.read,
      specialReference: specialReference ?? this.specialReference,
      reqActionType: reqActionType ?? this.reqActionType,
      flowId: flowId ?? this.flowId,
      stringBody: stringBody ?? this.stringBody,
      isWorkflowCompleted: isWorkflowCompleted ?? this.isWorkflowCompleted,
      decisionType: decisionType ?? this.decisionType,
    );
  }
}

class NotificationBody {
  final String? remarks;
  final String? employeeId;
  final String? name;
  final String? date;
  final String? fromTime;
  final String? toTime;

  NotificationBody({
    this.remarks,
    this.employeeId,
    this.name,
    this.date,
    this.fromTime,
    this.toTime,
  });

  factory NotificationBody.fromMap(Map<String, dynamic> map) {
    return NotificationBody(
      remarks: map['Remarks'],
      employeeId: map['Employee ID'],
      name: map['Name'],
      date: map['Date'],
      fromTime: map['From Time'],
      toTime: map['To Time'],
    );
  }
} 


// {
//    "notifications":{
//       "content":[
//          {
//             "id":1141,
//             "title":"Short Leave Request",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nDate : (17-02-2025)\r\n\r\nFrom Time  : (12:00)\r\nFrom Time  : (13:00)\r\n\r\nType : (Business Leave)\r\n\r\nRemarks: (sdsdsdsdsdsdsddsd)",
//             "type":null,
//             "read":"2",
//             "createdOn":"2025-02-17T10:40:43",
//             "specialReference":null
//          },
//          {
//             "id":1140,
//             "title":"Overtime Request",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nDate : (21-02-2025)\r\n\r\nNo Of Hours  : (3)\r\n\r\nRemakrs : (Test Test Test Test)",
//             "type":null,
//             "read":"2",
//             "createdOn":"2025-02-17T10:30:24",
//             "specialReference":null
//          },
//          {
//             "id":1139,
//             "title":"Expense Claim",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nDate : (19-02-2025)\r\n\r\nClaim Type : (Business Trips)\r\n\r\nAmount Claimed : (10)\r\n\r\nRequest Remarks : (Test Test Test)\r\n",
//             "type":null,
//             "read":"2",
//             "createdOn":"2025-02-17T10:29:43",
//             "specialReference":null
//          },
//          {
//             "id":1138,
//             "title":"Loan Request",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nLoan Type : (Personal Loan)\r\n\r\nAmount Requested : (1000)\r\n\r\nNo of Installments : (10)\r\n\r\nRequest Remarks : (Test Test Test)",
//             "type":null,
//             "read":"2",
//             "createdOn":"2025-02-17T10:26:18",
//             "specialReference":null
//          },
//          {
//             "id":1137,
//             "title":"Short Leave Request",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nDate : (17-02-2025)\r\n\r\nFrom Time  : (12:00)\r\nFrom Time  : (13:00)\r\n\r\nType : (Business Leave)\r\n\r\nRemarks: (Test Test Test Test Test)",
//             "type":null,
//             "read":"1",
//             "createdOn":"2025-02-17T10:21:16",
//             "specialReference":null
//          },
//          {
//             "id":1136,
//             "title":"Vacation Request",
//             "body":"Employee ID : (12)\r\n\r\nName : (sara ghareb haharoon)\r\n\r\nVacation Type : (unpaid vacation)\r\n\r\nFrom Date : (18-02-2025)\r\n\r\nTo Date  : (19-02-2025)\r\n\r\nRemarks : (Test Test Test Test Test Test Test Test Test)\r\n\r\nSubst. Employee : (4)\r\n\r\nHandover Details : (N/A)",
//             "type":null,
//             "read":"1",
//             "createdOn":"2025-02-17T10:15:08",
//             "specialReference":null
//          },
//          {
//             "id":570,
//             "title":"Shift Change Acknowledgement",
//             "body":"Your shift will be changed to (op) starting from (12-02-2024). Please Acknowledge.",
//             "type":null,
//             "read":"2",
//             "createdOn":"2025-01-31T16:23:59",
//             "specialReference":null
//          }
//       ],
//       "pageable":{
//          "sort":{
//             "unsorted":false,
//             "sorted":true,
//             "empty":false
//          },
//          "pageNumber":0,
//          "pageSize":7,
//          "offset":0,
//          "paged":true,
//          "unpaged":false
//       },
//       "last":false,
//       "totalPages":6,
//       "totalElements":36,
//       "numberOfElements":7,
//       "sort":{
//          "unsorted":false,
//          "sorted":true,
//          "empty":false
//       },
//       "first":true,
//       "size":7,
//       "number":0,
//       "empty":false
//    }
// }