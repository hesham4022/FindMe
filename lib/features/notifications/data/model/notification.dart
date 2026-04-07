class NotificationResponseModel {
  final int total;
  final List<AppNotificationModel> notifications;

  NotificationResponseModel({
    required this.total,
    required this.notifications,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    return NotificationResponseModel(
      total: json['total'] ?? 0,
      notifications: (json['notifications'] as List<dynamic>? ?? [])
          .map((e) => AppNotificationModel.fromJson(e))
          .toList(),
    );
  }
}

class AppNotificationModel {
  final String id;
  final String type;
  final String notifiableType;
  final int notifiableId;
  final NotificationDataModel data;
  final String? readAt;
  final String createdAt;
  final String updatedAt;

  AppNotificationModel({
    required this.id,
    required this.type,
    required this.notifiableType,
    required this.notifiableId,
    required this.data,
    required this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isRead => readAt != null;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      notifiableType: json['notifiable_type'] ?? '',
      notifiableId: json['notifiable_id'] ?? 0,
      data: NotificationDataModel.fromJson(json['data'] ?? {}),
      readAt: json['read_at'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class NotificationDataModel {
  final int? reportId;
  final String message;

  NotificationDataModel({
    required this.reportId,
    required this.message,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) {
    return NotificationDataModel(
      reportId: json['report_id'],
      message: json['message'] ?? '',
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