import 'package:equatable/equatable.dart';
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:find_me_app/features/chat/presentation/cubit/chat_cubit.dart';

class ChatState extends Equatable {
  final List<ChatMessage> messages;
  final List<UploadFile> pickedFiles;
  final String? fileErrorText;

  const ChatState({
    required this.messages,
    required this.pickedFiles,
    this.fileErrorText,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    List<UploadFile>? pickedFiles,
    String? fileErrorText,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      pickedFiles: pickedFiles ?? this.pickedFiles,
      fileErrorText: fileErrorText ?? this.fileErrorText,
    );
  }

  @override
  List<Object?> get props => [
        messages,
        pickedFiles,
        fileErrorText,
      ];
}
