import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:senpos_ticket/x_res/app_text_style.dart';
// import 'package:senpos_ticket/x_res/my_config.dart';

import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';
import '../validate.dart';

class AppTextFieldNonBody extends StatefulWidget {
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
  final Color? colorHint;
  // final Validate? validate;
  final String? title;
  final TextStyle? textStyle;
  final bool isRequire;
  final EdgeInsetsGeometry? margin;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextFieldNonBody({
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
    this.colorHint,
    // this.validate,
    this.title,
    this.margin,
    this.textStyle,
    this.isRequire = false,
    this.inputFormatters,
    this.textAlign,
  }) : super(key: key);

  @override
  _AppTextFieldNonBodyState createState() => _AppTextFieldNonBodyState();
}

class _AppTextFieldNonBodyState extends State<AppTextFieldNonBody> {
  late bool _passwordHidden = true;

  @override
  void initState() {
    widget.controller?.addListener(() {
      if (this.mounted) {
        setState(() {});
      }
    });
    super.initState();
    if (this.mounted) {
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
              margin: EdgeInsets.only(bottom: 8, left: 8).r,
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
                        TextSpan(text: ' ('),
                        TextSpan(text: '*', style: AppTextStyle.errorS14W500),
                        TextSpan(text: ')'),
                      ]),
                    )
                ],
              ),
            ),
          InkWell(
            onTap: widget.onPressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: widget.padding ?? 0).r,
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

                textAlign: widget.textAlign??TextAlign.start,
                decoration: InputDecoration(
                  border: widget.border ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(Radius.circular(16).w),
                      ),
                  focusedBorder: widget.focusedBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(Radius.circular(16).w),
                      ),
                  enabledBorder: widget.enabledBorder ??
                      OutlineInputBorder(
                        borderSide: BorderSide(color: MyColor.COLOR_STOKE),
                        borderRadius: BorderRadius.all(Radius.circular(16).w),
                      ),
                  // hintText: widget.hintText,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: widget.colorHint ?? MyColor.COLOR_SECONDARY_TEXT,
                      fontSize: 16),
                  floatingLabelStyle:
                      TextStyle(color: Colors.black, fontSize: 15, height: 0.7),
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.symmetric(vertical: 12).w,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: _buildSuffixIcon(),
                  prefixIconConstraints: widget.prefixIconConstraints,
                  suffixIconConstraints: BoxConstraints(maxWidth: 50).r,
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
      Icon _icon = Icon(
        _passwordHidden
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        color: MyColor.BUTTON_COLOR,
        size: 20,
      );
      return IconButton(
          padding: EdgeInsets.only(right: 5),
          onPressed: () {
            if (this.mounted) {
              setState(() {
                _passwordHidden = !_passwordHidden;
              });
            }
          },
          icon: _icon);
    } else {
      if (widget.enabled) // return widget.suffixIcon ?? _showClearButton();
        return widget.suffixIcon ?? Container();
      else
        return widget.suffixIcon;
    }
  }
}
