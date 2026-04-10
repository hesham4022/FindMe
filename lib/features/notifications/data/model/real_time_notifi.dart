import 'dart:convert';

class RealtimeNotificationModel {
  final String id;
  final String message;
  final int? reportId;
  final String? type;

  RealtimeNotificationModel({
    required this.id,
    required this.message,
    this.reportId,
    this.type,
  });

  factory RealtimeNotificationModel.fromRawJson(String source) {
    final json = jsonDecode(source);
    return RealtimeNotificationModel(
      id: json['id']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      reportId: json['report_id'] is int
          ? json['report_id']
          : int.tryParse(json['report_id']?.toString() ?? ''),
      type: json['type']?.toString(),
    );
  }
}
