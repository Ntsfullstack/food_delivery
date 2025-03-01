import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../x_res/my_config.dart';

/*
FormInputFieldWithIcon(
                controller: _email,
                iconPrefix: Icons.link,
                labelText: 'Post URL',
                validator: Validator.notEmpty,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                onChanged: (value) => print('changed'),
                onSaved: (value) => print('implement me'),
              ),
*/

class FormInputFieldWithIcon extends StatefulWidget {
  const FormInputFieldWithIcon(
      {super.key, required this.controller,
      this.iconPrefix,
      this.labelText,
      this.hintText,
      required this.validator,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.minLines = 1,
      this.maxLines = 1,
      this.margin,
      required this.onChanged,
      required this.onSaved,
      this.suffix,
      this.fillColor,
      this.borderSize,
      this.radius,
      this.contentPadding,
      this.tailText,
      this.inputFormatters,
      this.labelTextIcon,
      this.onTabOnIcon,
      this.readOnly = false});

  final TextEditingController controller;
  final IconData? iconPrefix;
  final String? labelText;
  final String? labelTextIcon;
  final VoidCallback? onTabOnIcon;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final int minLines;
  final int? maxLines;
  final EdgeInsets? margin;
  final void Function(String) onChanged;
  final void Function(String?)? onSaved;
  final Widget? suffix;
  final Color? fillColor;
  final double? borderSize;
  final double? radius;
  final EdgeInsetsGeometry? contentPadding;
  final String? tailText;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;

  @override
  _FormInputFieldWithIconState createState() => _FormInputFieldWithIconState();
}

class _FormInputFieldWithIconState extends State<FormInputFieldWithIcon> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.labelText != null
              ? Container(
                  margin: const EdgeInsets.only(bottom: 8).r,
                  child: Row(
                    children: [
                      Text(
                        widget.labelText!,
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      if (widget.labelTextIcon != null)
                        InkWell(
                          onTap: widget.onTabOnIcon,
                          child: Image.asset(
                            widget.labelTextIcon!,
                            width: 16.w,
                            height: 16.h,
                          ),
                        ),
                      const Spacer(),
                      if (widget.tailText != null)
                        Text(
                          widget.tailText!,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black.withOpacity(0.25),
                              fontWeight: FontWeight.w600),
                        ),
                    ],
                  ))
              : Container(),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              contentPadding: widget.contentPadding ?? (widget.labelText != null
                      ? const EdgeInsets.only(left: 16, right: 16).r
                      : const EdgeInsets.all(0)),
              prefixIcon:
                  widget.iconPrefix != null ? Icon(widget.iconPrefix) : null,
              hintStyle: TextStyle(color: MyColor.PRIMARY_SWATCH, fontSize: 14.sp),
              // labelText: widget.labelText,
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 5.0).w),
                borderSide: BorderSide(color: MyColor.PRIMARY_SWATCH, width: 1.h),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radius ?? 5.0).w),
                borderSide: BorderSide(
                    color: MyColor.PRIMARY_SWATCH,
                    width: widget.borderSize ?? 1),
              ),
              suffixIcon: widget.suffix ?? (widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        )
                      : null),
            ),
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText ? _isObscure : false,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            validator: widget.validator,
            readOnly: widget.readOnly,
          ),
        ],
      ),
    );
  }
}
