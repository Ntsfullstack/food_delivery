import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:senpos_ticket/x_res/app_text_style.dart';
// import 'package:senpos_ticket/x_res/my_config.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';

class AppTextField extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final Widget? prefixIcon;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final EdgeInsets? contentPadding;
  final BoxConstraints? prefixIconConstraints;
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final bool readOnly;
  final bool enabled;
  final Color? colorText;
  final VoidCallback? onPressed;
  final TextInputType keyboardType;
  final Color? bgColor;
  final double? radius;
  final double? padding;
  final int? maxLines;
  final Color? colorHint;
  // final Validate? validate;
  final String? title;
  final TextStyle? textStyle;
  final bool isRequire;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    Key? key,
    this.onChanged,
    required this.hintText,
    this.prefixIcon,
    this.onPressed,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.contentPadding,
    this.prefixIconConstraints,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.readOnly = false,
    this.colorText,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.bgColor,
    this.radius,
    this.padding,
    this.maxLines,
    this.colorHint,
    // this.validate,
    this.title,
    this.margin,
    this.textStyle,
    this.isRequire = false,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _passwordHidden = true;

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
    if (mounted) {
      setState(() {
        _passwordHidden = widget.obscureText ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Container(
              margin: const EdgeInsets.only(bottom: 8, left: 8).r,
              child: Row(
                children: [
                  Text(
                    widget.title ?? '',
                    style: AppTextStyle.blackS14W500,
                  ),
                  if (widget.isRequire)
                    RichText(
                      text:
                          TextSpan(style: AppTextStyle.blackS14W500, children: [
                        const TextSpan(text: ' ('),
                        TextSpan(text: '*', style: AppTextStyle.errorS14W500),
                        const TextSpan(text: ')'),
                      ]),
                    )
                ],
              ),
            ),
          InkWell(
            onTap: widget.onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0).r,
              decoration: BoxDecoration(
                  color: widget.bgColor ?? Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.radius ?? 16).w)),
              child: TextFormField(
                controller: widget.controller,
                enabled: widget.enabled,
                inputFormatters: widget.inputFormatters,
                // validator: (value) {
                //   if (widget.validate != null &&
                //       widget.validate!.validate(value) != null) {
                //     return widget.validate!.validate(value);
                //   }
                //   return null;
                // },

                maxLines: widget.maxLines ?? 1,
                decoration: InputDecoration(
                  border: widget.border ??
                      OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(const Radius.circular(16).w),
                      ),
                  focusedBorder: widget.focusedBorder ??
                      OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(const Radius.circular(16).w),
                      ),
                  enabledBorder: widget.enabledBorder ??
                      OutlineInputBorder(
                        borderSide: const BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(const Radius.circular(16).w),
                      ),
                  // hintText: widget.hintText,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: widget.colorHint ?? MyColor.COLOR_SECONDARY_TEXT,
                      fontSize: 16),
                  floatingLabelStyle:
                      const TextStyle(color: Colors.black, fontSize: 15, height: 0.7),
                  contentPadding: widget.contentPadding ?? const EdgeInsets.all(16).w,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: _buildSuffixIcon(),
                  prefixIconConstraints: widget.prefixIconConstraints,
                  suffixIconConstraints: const BoxConstraints(maxWidth: 50).r,
                ),
                style: widget.textStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: widget.colorText ?? Colors.black,
                    ),
                obscureText: _passwordHidden,
                readOnly: widget.readOnly,
                onChanged: (value) => widget.onChanged?.call(value),
                keyboardType: widget.keyboardType,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText ?? false) {
      Icon icon = Icon(
        _passwordHidden
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        color: MyColor.BUTTON_COLOR,
        size: 20,
      );
      return IconButton(
          padding: const EdgeInsets.only(right: 5),
          onPressed: () {
            if (mounted) {
              setState(() {
                _passwordHidden = !_passwordHidden;
              });
            }
          },
          icon: icon);
    } else {
      if (widget.enabled) {
        // return widget.suffixIcon ?? _showClearButton();
        return widget.suffixIcon ?? Container();
      } else {
        return widget.suffixIcon;
      }
    }
  }
}
