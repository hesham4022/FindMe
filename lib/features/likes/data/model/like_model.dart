import 'dart:convert';
import 'package:equatable/equatable.dart';

class LikeResponse extends Equatable {
  final String message;
  final bool isLiked;
  final int likesCount;

  const LikeResponse({
    required this.message,
    required this.isLiked,
    required this.likesCount,
  });

  factory LikeResponse.fromMap(Map<String, dynamic> map) {
    return LikeResponse(
      message: map['message'] ?? '',
      isLiked: map['isLiked'] ?? false,
      likesCount: map['likesCount'] ?? 0,
    );
  }

  factory LikeResponse.fromJson(String source) =>
      LikeResponse.fromMap(jsonDecode(source));

  @override
  List<Object?> get props => [message, isLiked, likesCount];
}
