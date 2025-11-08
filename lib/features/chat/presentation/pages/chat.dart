import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/functions.dart';
import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:find_me_app/core/shared/widgets/custom_network_img.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';
import 'package:find_me_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:find_me_app/features/chat/presentation/cubit/chat_state.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 46,
        background: AppColors.baseWhite,
        overlayColor: AppColors.baseWhite,
        elevation: 0.3,
        titleText: AppStrings.liveChat,
      ),
      body: BlocProvider(
        create: (_) => ChatCubit(),
        child: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  _Body();

  final TextEditingController _controller = TextEditingController();

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              return ListView.builder(
                padding: EdgeInsets.all(16.w),
                reverse: false,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  this.index = index;
                  return _ChatBubble(
                    message: message.content,
                    timestamp: message.timestamp,
                    isUser: message.isUser,
                  );
                },
              );
            },
          ),
        ),
        _MessageInput(
          controller: _controller,
          index: index,
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String message;
  final String timestamp;
  final bool isUser;

  const _ChatBubble({
    required this.message,
    required this.timestamp,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser)
            CircleAvatar(
              backgroundColor: AppColors.daisyBush300,
              child: CustomNetworkImage(
                image: "imgURL",
                isCircle: true,
                width: 120,
                height: 120,
                placeholder: Icons.account_circle_rounded,
              ),
            ),
          if (!isUser) HSpace(8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: isUser ? AppColors.daisyBush800 : AppColors.baseWhite,
                borderRadius: BorderRadiusDirectional.only(
                  topStart:
                      isUser ? Radius.circular(12.r) : Radius.circular(0.r),
                  topEnd: isUser ? Radius.circular(0.r) : Radius.circular(12.r),
                  bottomStart: Radius.circular(12.r),
                  bottomEnd: Radius.circular(12.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.r,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: isUser ? Colors.white : Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  VSpace(4.h),
                  Align(
                    alignment: isUser
                        ? AlignmentDirectional.bottomEnd
                        : AlignmentDirectional.bottomStart,
                    child: Text(
                      timestamp,
                      style: TextStyle(
                        color: isUser
                            ? AppColors.daisyBush300
                            : AppColors.saltBox400,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  const _MessageInput({required this.controller, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      color: Colors.grey[100],
      child: Row(
        children: [
          Expanded(
            child: MessageField(),
          ),
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.all(12).w,
            decoration: BoxDecoration(
              color: AppColors.daisyBush800,
              borderRadius: BorderRadius.circular(12).r,
            ),
            child: InkWell(
              onTap: () => _sendMessage(context, index),
              child: Icon(
                Icons.send,
                color: AppColors.baseWhite,
                size: 24.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage(BuildContext context, int index) {
    final message = controller.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatCubit>().sendMessage(message, index);
      controller.clear();
    }
  }
}

class MessageField extends StatelessWidget {
  const MessageField({
    super.key,
    // this.onSubmit,
  });

  // final Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      // buildWhen: (previous, current) => (previous.usernameErrorText != current.usernameErrorText),
      builder: (context, state) {
        return CustomTextField(
          hint: AppStrings.yourMessage.ts,
          // errorText: state.usernameErrorText,
          // controller: controller,
          suffixIcon: GestureDetector(
            onTap: () async =>
                context.read<ChatCubit>().onAddFile(await kPickFile()),
            child: Icon(
              Icons.attach_file,
              size: 20.sp,
              color: AppColors.baseBlack,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          // onSubmit: onSubmit,
          onChanged: (value) {
            // context.read<SignInCubit>().usernameChanged(value);
          },
          // onValidate: (value) {
          //   final errorText = AppValidators.validateUsername(value);
          //   context.read<SignInCubit>()
          //       .usernameErrorTextChanged(errorText ?? "");
          //   return errorText;
          // },
        );
      },
    );
  }
}
