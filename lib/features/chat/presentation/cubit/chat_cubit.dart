// chat_cubit.dart
import 'package:find_me_app/core/shared/models/upload_file.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:find_me_app/core/helpers/formfield_validator.dart';
import 'package:find_me_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:intl/intl.dart';

class ChatMessage {
  final String content;
  final String timestamp;
  final bool isUser;

  ChatMessage({
    required this.content,
    required this.timestamp,
    required this.isUser,
  });
}

class ChatCubit extends Cubit<ChatState> {
  ChatCubit()
      : super(
          ChatState(
            messages: [
              ChatMessage(
                content:
                    "Hi, I need clarification on my leave balance. Can you help?",
                timestamp: "03:32 PM",
                isUser: true,
              ),
              ChatMessage(
                content: "Sure, let me check that for you. One moment, please.",
                timestamp: "03:32 PM",
                isUser: false,
              ),
              ChatMessage(
                content:
                    "Thanks! Also, I'd like to know if there are any restrictions for applying for annual leave this month.",
                timestamp: "03:32 PM",
                isUser: true,
              ),
              ChatMessage(
                content:
                    "You currently have 12 days of leave remaining. There are no restrictions for annual leave applications this month. Would you like me to guide you through the process?",
                timestamp: "03:32 PM",
                isUser: false,
              ),
            ],
            pickedFiles: [],
          ),
        );

  void sendMessage(String message, int index) async {
    final timestamp = DateFormat('hh:mm a').format(DateTime.now());

    // Add user message
    emit(state.copyWith(messages: [
      ...state.messages,
      ChatMessage(
        content: message,
        timestamp: timestamp,
        isUser: index % 2 == 0 ? true : false,
      )
    ]));

    // Simulate bot response
    await Future.delayed(const Duration(seconds: 1));

    // Add bot response
    emit(state.copyWith(messages: [
      ...state.messages,
      ChatMessage(
        content:
            "Your request has been processed. Please check your email for confirmation.",
        timestamp: DateFormat('hh:mm a').format(DateTime.now()),
        isUser: false,
      )
    ]));
  }

  //! File Changed --------------------------------------------------------
  // void onAddFile(UploadFile? value) {
  //   if (value == null) return;
  //
  //   final currentFiles = state.pickedFiles ?? []; // Handle null case
  //   emit(state.copyWith(
  //     pickedFiles: List<UploadFile>.from(currentFiles)..add(value),
  //     fileErrorText: AppValidators.validatePickedFile(value),
  //   ));
  // }
  void onAddFile(UploadFile? value) {
    if (value == null) {
      return;
    }
    emit(state.copyWith(
      pickedFiles: List.from(state.pickedFiles)..add(value),
      fileErrorText: AppValidators.validatePickedFile(value),
      // status: TerminationRequestStatus.initial,
    ));
  }
}
