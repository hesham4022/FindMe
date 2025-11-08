import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:find_me_app/core/helpers/extensions/translation_ex.dart';
import 'package:find_me_app/core/resources/colors.dart';
import 'package:find_me_app/core/resources/themes.dart';
import 'package:find_me_app/core/shared/widgets/buttons/custom_btn.dart';
import 'package:find_me_app/core/shared/widgets/sizes.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.secureText = false,
    this.onChanged,
    this.onTap,
    this.onSubmit,
    this.onValidate,
    this.formatter,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.radius = 12,
    this.readOnly = false,
    this.value,
    this.textInputAction = TextInputAction.next,
    this.width,
    this.height,
    this.showBorders = true,
    this.contentPadding,
    this.errorText,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.autoFocus = true,
    this.borderStyle = BorderStyle.solid,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.labelText,

    /// Accept FocusNode from outside
    // this.expands = false,
  });

  final double? width;
  final double? height;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final bool secureText;
  final List<TextInputFormatter>? formatter;
  final TextEditingController? controller;
  final int? minLines;
  final int? maxLines;
  final bool readOnly;
  final String? value;
  final double radius;
  final TextInputAction textInputAction;
  final bool showBorders;
  final Function()? onTap;
  final String? Function(String)? onValidate;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final EdgeInsetsGeometry? contentPadding;
  final String? errorText;
  final TextDirection? textDirection;
  final TextAlign textAlign;
  final bool autoFocus;
  final BorderStyle borderStyle;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? labelText;

  // final bool expands;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  late Color _filledColor;
  late Color _borderColor;

  late CustomState _state;

  late final FocusNode _focusNode;

  @override
  void initState() {
    _state = CustomState.inActive;
    _errorText = widget.errorText;
    _focusNode = FocusNode();

    // Listener to detect focus changes
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        if (_state != CustomState.error) {
          _state = CustomState.active;
        }
      } else {
        if (_state != CustomState.error) {
          _state = CustomState.inActive;
        }
      }

      setState(() {
        _state;
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.errorText != oldWidget.errorText) {
      _errorText = widget.errorText;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  _fillColors() {
    switch (_state) {
      case CustomState.active:
        _filledColor = AppColors.daisyBush50;
        _borderColor = AppColors.daisyBush800;
        break;

      case CustomState.inActive:
        _filledColor = AppColors.saltBox50;
        _borderColor = AppColors.saltBox200;
        break;

      case CustomState.error:
        _filledColor = AppColors.error50;
        _borderColor = AppColors.error500;
        break;

      case CustomState.disabled:
        _filledColor = AppColors.saltBox200;
        _borderColor = AppColors.saltBox200;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    _fillColors();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            suffixIconConstraints: const BoxConstraints(
              minWidth: 30, // الحجم الأدنى
              minHeight: 30,
            ),
            isDense: true,
            fillColor: const Color(0xffECF1FF),
            labelText: widget.labelText,
            filled: true,
            suffixIcon: widget.suffixIcon,
            prefixIcon:
                _state != CustomState.disabled && widget.prefixIcon != null
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: context.locale.languageCode == 'ar' ? 10 : 18,
                          right: context.locale.languageCode == 'ar' ? 18 : 10,
                        ).w,
                        child: widget.prefixIcon,
                      )
                    : null,
            hintText: widget.hint?.ts,
            labelStyle: Theme.of(context).textTheme.kCaptionRegular,
            hintStyle: Theme.of(context)
                .textTheme
                .kCaptionRegular
                .copyWith(color: AppColors.saltBox300, fontSize: 14),
            contentPadding: widget.contentPadding,
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _borderColor,
                style: widget.borderStyle,
                width: widget.showBorders ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.radius).r,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: _borderColor,
                style: widget.borderStyle,
                width: widget.showBorders ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.radius).r,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _borderColor,
                style: widget.borderStyle,
                width: widget.showBorders ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.radius).r,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _borderColor,
                style: widget.borderStyle,
                width: widget.showBorders ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.radius).r,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _borderColor,
                style: widget.borderStyle,
                width: widget.showBorders ? 1 : 0,
              ),
              borderRadius: BorderRadius.circular(widget.radius).r,
            ),
          ),
          enabled: _state == CustomState.disabled ? false : true,
          autofocus: widget.autoFocus,
          focusNode: widget.focusNode ?? _focusNode,
          obscureText: widget.secureText,
          inputFormatters: widget.formatter,
          keyboardType: widget.keyboardType,
          enableSuggestions: true,
          enableInteractiveSelection: true,
          enableIMEPersonalizedLearning: true,
          textInputAction: widget.textInputAction,
          style: Theme.of(context).textTheme.kCaptionRegular,
          strutStyle: const StrutStyle(forceStrutHeight: true),
          cursorColor: AppColors.daisyBush800,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          readOnly: widget.readOnly,
          controller: widget.controller,
          textDirection: widget.textDirection,
          textAlign: widget.textAlign,
          textCapitalization: widget.textCapitalization,
          onTap: widget.onTap,
          // For Scrolling text field upper keyboard when it is open.
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  Theme.of(context).textTheme.kCaptionRegular.fontSize! * 4),
          onChanged: (value) {
            if (widget.onValidate != null) {
              setState(() {
                _errorText = widget.onValidate!(value);
                if (_errorText != null && _errorText!.isNotEmpty) {
                  _state = CustomState.error;
                } else {
                  _state = CustomState.active;
                }
              });
            }

            widget.onChanged?.call(value);
          },
          onSubmitted: widget.onSubmit,
        ),
        if (_errorText != null && _errorText!.isNotEmpty) VSpace(8),
        if (_errorText != null && _errorText!.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.error500,
                size: 16,
              ),
              HSpace(4),
              Expanded(
                child: Text(
                  _errorText!.ts,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context)
                      .textTheme
                      .kParagraph01Regular
                      .copyWith(color: AppColors.error500),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
