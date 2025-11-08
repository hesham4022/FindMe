import 'dart:io';

import 'package:equatable/equatable.dart';

class UploadFile extends Equatable {
  final File? file;
  final String name;
  final String? url;
  final String? ext; // File extension
  final double progress; // Progress from 0.0 to 1.0
  final bool isUploading;
  final bool isCompleted;
  final String? fieldName; // ⬅️ بدل fieldKey إلى fieldName
  final double size; // Size in MB
  final String? token;

  const UploadFile({
    this.file,
    required this.name,
    this.url,
    this.ext,
    this.progress = 0.0,
    this.isUploading = true,
    this.isCompleted = false,
    this.fieldName, // ⬅️ هنا كمان
    this.size = 0,
    this.token,
  });

  UploadFile copyWith({
    File? file,
    String? name,
    String? ext,
    String? icon,
    double? progress,
    bool? isUploading,
    bool? isCompleted,
    String? fieldName, // ⬅️ وهنا برضه
    double? size,
    String? token,
  }) {
    return UploadFile(
      file: file ?? this.file,
      name: name ?? this.name,
      ext: ext ?? this.ext,
      progress: progress ?? this.progress,
      isUploading: isUploading ?? this.isUploading,
      isCompleted: isCompleted ?? this.isCompleted,
      fieldName: fieldName ?? this.fieldName, // ⬅️ استبدالها هنا
      size: size ?? this.size,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [
        file,
        name,
        ext,
        progress,
        isUploading,
        isCompleted,
        fieldName, // ⬅️ هنا كمان
        size,
        token,
      ];
}
