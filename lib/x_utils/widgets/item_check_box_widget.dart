import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../x_res/app_text_style.dart';
import '../../x_res/my_config.dart';

class ItemCheckBoxWidget extends StatefulWidget {
  const ItemCheckBoxWidget({
    Key? key,
    required this.optionText,
    this.isChecked = false,
    this.isLeft = false, this.onPress,
  }) : super(key: key);

  final String optionText;
  final bool isChecked;
  final bool isLeft;
  final Function(bool)? onPress;

  @override
  State<ItemCheckBoxWidget> createState() => _ItemCheckBoxWidgetState();
}

class _ItemCheckBoxWidgetState extends State<ItemCheckBoxWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: (){
        widget.onPress?.call(!widget.isChecked);
      },
      child: Container(
        child: Row(
          children: [
            if (widget.isLeft)
              Text(
                widget.optionText,
                style: AppTextStyle.blackS14W300,
              ),
            Container(
              height: 20,
              width: 20,
              child: Checkbox(
                checkColor: Colors.white,
                value: widget.isChecked,
                activeColor: MyColor.MAIN_SOLID,
                side: BorderSide(color: MyColor.FOUNDATION),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6).w),
                onChanged: (bool? value) {
                  widget.onPress?.call(!widget.isChecked);
                },
              ),
            ),
            if (!widget.isLeft)
              Text(
                widget.optionText,
                style: AppTextStyle.blackS14W300,
              )
          ],
        ),
      ),
    );
  }
}
