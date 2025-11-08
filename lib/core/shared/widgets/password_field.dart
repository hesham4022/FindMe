import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';

import 'package:find_me_app/core/resources/strings.dart';
import 'package:find_me_app/core/shared/widgets/custom_textfield.dart';

class RPasswordField extends StatefulWidget {
  const RPasswordField({
    super.key,
    this.hint = AppStrings.password,
    required this.validate,
    this.onSave,
    this.onChanged,
    this.isOptional = false,
    this.state = CustomState.active,
    this.prefixIcon,
    this.errorText,
  });

  final String? Function(String?) validate;
  final dynamic Function(String?)? onSave;
  final dynamic Function(String)? onChanged;
  final CustomState state;
  final String hint;
  final bool isOptional;
  final Widget? prefixIcon;
  final String? errorText;

  @override
  State<RPasswordField> createState() => _RPasswordFieldState();
}

class _RPasswordFieldState extends State<RPasswordField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      hint: widget.hint,
      errorText: widget.errorText,
      textDirection: TextDirection.ltr,

      textAlign: context.locale.languageCode == 'ar'
          ? TextAlign.right
          : TextAlign.start,
      secureText: !showPassword,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.state != CustomState.disabled
          ? InkWell(
              onTap: () {
                setState(() => showPassword = !showPassword);
              },
              child: _PasswordVisibiltyButton(showPassword),
            )
          : null,
      onValidate: widget.validate,
      onChanged: widget.onChanged,
      // formatter: [
      //   FilteringTextInputFormatter.allow(
      //     RegExp(r'[!-~]'), // Allow only ASCII characters (excluding spaces)
      //   ),
      // ],
    );
  }
}

class _PasswordVisibiltyButton extends StatelessWidget {
  const _PasswordVisibiltyButton(
    this.isVisible,
  );

  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Icon(
      isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      size: 22.sp,
      color: Color(0xff1C1B1F),
    );
  }
}
