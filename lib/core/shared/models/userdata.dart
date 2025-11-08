class UserModel {
  final String name;
  final String imageUrl; // من السيرفر
  final String? localImage; // صورة محلية مؤقتة

  UserModel({
    required this.name,
    required this.imageUrl,
    this.localImage,
  });

  UserModel copyWith({
    String? name,
    String? imageUrl,
    String? localImage,
  }) {
    return UserModel(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      localImage: localImage ?? this.localImage,
    );
  }
}
