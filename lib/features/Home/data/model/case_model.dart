class CaseModel {
  final String name;
  final String city;
  final int daysAgo;
  final int views;
  final String avatarUrl;

  CaseModel({
    required this.name,
    required this.city,
    required this.daysAgo,
    required this.views,
    required this.avatarUrl,
    required String id,
    required String description,
  });
}
