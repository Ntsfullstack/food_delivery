import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'my_config.dart';

class AppTextStyle {
  ///black
  static final blackS57 = TextStyle(color: MyColor.black, fontSize: 57.sp);
  static final blackS45 = TextStyle(color: MyColor.black, fontSize: 45.sp);
  static final blackS36 = TextStyle(color: MyColor.black, fontSize: 36.sp);
  static final blackS32 = TextStyle(color: MyColor.black, fontSize: 32.sp);
  static final blackS28 = TextStyle(color: MyColor.black, fontSize: 28.sp);
  static final blackS24 = TextStyle(color: MyColor.black, fontSize: 24.sp);
  static final blackS22 = TextStyle(color: MyColor.black, fontSize: 22.sp);
  static final blackS20 = TextStyle(color: MyColor.black, fontSize: 20.sp);
  static final blackS18 = TextStyle(color: MyColor.black, fontSize: 18.sp);
  static final blackS16 = TextStyle(color: MyColor.black, fontSize: 16.sp);
  static final blackS14 = TextStyle(color: MyColor.black, fontSize: 14.sp);
  static final blackS13 = TextStyle(color: MyColor.black, fontSize: 13.sp);
  static final blackS12 = TextStyle(color: MyColor.black, fontSize: 12.sp);
  static final blackS11 = TextStyle(color: MyColor.black, fontSize: 11.sp);
  static final blackS10 = TextStyle(color: MyColor.black, fontSize: 10.sp);

  ///white
  static final whiteS57 = TextStyle(color: MyColor.white, fontSize: 57.sp);
  static final whiteS45 = TextStyle(color: MyColor.white, fontSize: 45.sp);
  static final whiteS36 = TextStyle(color: MyColor.white, fontSize: 36.sp);
  static final whiteS32 = TextStyle(color: MyColor.white, fontSize: 32.sp);
  static final whiteS28 = TextStyle(color: MyColor.white, fontSize: 28.sp);
  static final whiteS24 = TextStyle(color: MyColor.white, fontSize: 24.sp);
  static final whiteS22 = TextStyle(color: MyColor.white, fontSize: 22.sp);
  static final whiteS20 = TextStyle(color: MyColor.white, fontSize: 20.sp);
  static final whiteS18 = TextStyle(color: MyColor.white, fontSize: 18.sp);
  static final whiteS16 = TextStyle(color: MyColor.white, fontSize: 16.sp);
  static final whiteS15 = TextStyle(color: MyColor.white, fontSize: 15.sp);
  static final whiteS14 = TextStyle(color: MyColor.white, fontSize: 14.sp);
  static final whiteS12 = TextStyle(color: MyColor.white, fontSize: 12.sp);
  static final whiteS13 = TextStyle(color: MyColor.white, fontSize: 13.sp);
  static final whiteS11 = TextStyle(color: MyColor.white, fontSize: 11.sp);

  ///MAIN_SOLID
  static final purpleS14 = TextStyle(color: MyColor.PURPLE, fontSize: 14.sp);

  ///MAIN_SOLID
  static final hintInputS14 =
      TextStyle(color: MyColor.COLOR_SECONDARY_TEXT, fontSize: 14.sp);

  ///MAIN_SOLID
  static final mainSolidS11 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 11.sp);
  static final mainSolidS13 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 13.sp);
  static final mainSolidS14 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 14.sp);
  static final mainSolidS16 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 16.sp);
  static final mainSolidS18 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 18.sp);
  static final mainSolidS20 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 20.sp);
  static final mainSolidS24 =
      TextStyle(color: MyColor.MAIN_SOLID, fontSize: 24.sp);

  ///secondary
  static final secondaryS16 =
      TextStyle(color: MyColor.SECONDARY, fontSize: 16.sp);
  static final secondaryS14 =
      TextStyle(color: MyColor.SECONDARY, fontSize: 14.sp);

  ///secondary text
  static final secondaryTextS13 =
      TextStyle(color: MyColor.COLOR_SECONDARY_TEXT, fontSize: 13.sp);
  static final secondaryTextS14 =
      TextStyle(color: MyColor.COLOR_SECONDARY_TEXT, fontSize: 14.sp);
  static final secondaryTextS16 =
      TextStyle(color: MyColor.COLOR_SECONDARY_TEXT, fontSize: 16.sp);

  ///secondary
  static final darkSolidS14 =
      TextStyle(color: MyColor.COLOR_DARD_SOLID, fontSize: 14.sp);

  ///secondary
  static final greenS13 =
      TextStyle(color: MyColor.COLOR_GREEN, fontSize: 13.sp);

  ///error
  static final errorS13 = TextStyle(color: MyColor.ERROR, fontSize: 13.sp);
  static final errorS14 = TextStyle(color: MyColor.ERROR, fontSize: 14.sp);
  static final errorS16 = TextStyle(color: MyColor.ERROR, fontSize: 16.sp);
  static final errorS18 = TextStyle(color: MyColor.ERROR, fontSize: 18.sp);

  ///grey
  static final greyS10 = TextStyle(color: Colors.grey, fontSize: 10.sp);
  static final greyS13 = TextStyle(color: Colors.grey, fontSize: 13.sp);
  static final greyS14 = TextStyle(color: Colors.grey, fontSize: 14.sp);
  static final greyS16 = TextStyle(color: Colors.grey, fontSize: 16.sp);
  static final greyS17 = TextStyle(color: Colors.grey, fontSize: 17.sp);
  static final greyS15 = TextStyle(color: Colors.grey, fontSize: 15.sp);

  ///PRIMARY
  static final primary11 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 11.sp);  static final primary13 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 13.sp);
  static final primary24 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 24.sp);
  static final primary26 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 26.sp);
  static final primary28 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 28.sp);
  static final primary20 =
      TextStyle(color: MyColor.PRIMARY_COLOR, fontSize: 20.sp);

  ///weight s11
  static final whiteS11W400 = whiteS11.copyWith(fontWeight: FontWeight.w400);
  static final whiteS11W500 = whiteS11.copyWith(fontWeight: FontWeight.w500);
  static final blackS11W500 = blackS11.copyWith(fontWeight: FontWeight.w500);
  static final whiteS11W700 = whiteS11.copyWith(fontWeight: FontWeight.w700);

  ///weight s12
  static final whiteS12W400 = whiteS12.copyWith(fontWeight: FontWeight.w400);
  static final whiteS12W700 = whiteS12.copyWith(fontWeight: FontWeight.w700);
  static final whiteS12W500 = whiteS12.copyWith(fontWeight: FontWeight.w500);
  static final blackS12W500 = blackS12.copyWith(fontWeight: FontWeight.w500);
  static final blackS12W700 = blackS12.copyWith(fontWeight: FontWeight.w700);
  static final blackS12W300 = blackS12.copyWith(fontWeight: FontWeight.w300);

  ///weight s13
  static final blackS13W300 = blackS13.copyWith(fontWeight: FontWeight.w300);
  static final blackS13W500 = blackS13.copyWith(fontWeight: FontWeight.w500);
  static final whiteS13W300 = whiteS13.copyWith(fontWeight: FontWeight.w300);
  static final errorS13W300 = errorS13.copyWith(fontWeight: FontWeight.w300);
  static final errorS13W500 = errorS13.copyWith(fontWeight: FontWeight.w500);
  static final greenS13W500 = greenS13.copyWith(fontWeight: FontWeight.w500);
  static final secondaryS13W300 =
      secondaryTextS13.copyWith(fontWeight: FontWeight.w300);
  static final secondaryS16W300 =
      secondaryTextS16.copyWith(fontWeight: FontWeight.w300);

  ///weight s14
  static final blackS14W700 = blackS14.copyWith(fontWeight: FontWeight.w700);
  static final whiteS14W700 = whiteS14.copyWith(fontWeight: FontWeight.w700);
  static final whiteS14W300 = whiteS14.copyWith(fontWeight: FontWeight.w300);
  static final whiteS14W400 = whiteS14.copyWith(fontWeight: FontWeight.w400);
  static final blackS14W400 = blackS14.copyWith(fontWeight: FontWeight.w400);
  static final blackS14W300 = blackS14.copyWith(fontWeight: FontWeight.w300);
  static final mainSolidS14W600 =
      mainSolidS14.copyWith(fontWeight: FontWeight.w600);
  static final mainSolidS14W500 =
      mainSolidS14.copyWith(fontWeight: FontWeight.w500);
  static final purpleS14W500 = purpleS14.copyWith(fontWeight: FontWeight.w500);
  static final darkSolidS14W500 =
      darkSolidS14.copyWith(fontWeight: FontWeight.w500);
  static final errorS14W500 = errorS14.copyWith(fontWeight: FontWeight.w500);
  static final hintInputS14W300 =
      hintInputS14.copyWith(fontWeight: FontWeight.w300);
  static final errorS14W300 = errorS14.copyWith(fontWeight: FontWeight.w300);
  static final secondaryTextS14W500 =
      secondaryTextS14.copyWith(fontWeight: FontWeight.w500);

  ///weight s15
  static final whiteS15W600 = whiteS15.copyWith(fontWeight: FontWeight.w600);
  static final mainSolidS13W500 =
      mainSolidS13.copyWith(fontWeight: FontWeight.w500);
  static final mainSolidS13W300 =
      mainSolidS13.copyWith(fontWeight: FontWeight.w300);

  ///weight s16
  static final blackS16W500 = blackS16.copyWith(fontWeight: FontWeight.w500);
  static final blackS16W300 = blackS16.copyWith(fontWeight: FontWeight.w300);
  static final greyS16W700 = greyS16.copyWith(fontWeight: FontWeight.w700);
  static final whiteS16W500 = whiteS16.copyWith(fontWeight: FontWeight.w500);
  static final blackS16W700 = blackS16.copyWith(fontWeight: FontWeight.w700);
  static final whiteS16W400 = whiteS16.copyWith(fontWeight: FontWeight.w400);
  static final whiteS16W600 = whiteS16.copyWith(fontWeight: FontWeight.w600);
  static final whiteS16W700 = whiteS16.copyWith(fontWeight: FontWeight.w700);
  static final mainSolidS14W700 =
      mainSolidS14.copyWith(fontWeight: FontWeight.w700);
  static final mainSolidS16W700 =
      mainSolidS16.copyWith(fontWeight: FontWeight.w700);
  static final mainSolidS16W600 =
      mainSolidS16.copyWith(fontWeight: FontWeight.w600);
  static final mainSolidS16W500 =
      mainSolidS16.copyWith(fontWeight: FontWeight.w500);
  static final errorS16W500 = errorS16.copyWith(fontWeight: FontWeight.w500);
  static final secondaryS16W500 =
      secondaryS16.copyWith(fontWeight: FontWeight.w500);

  ///weight s18
  static final blackS18W500 = blackS18.copyWith(fontWeight: FontWeight.w500);
  static final blackS18W700 = blackS18.copyWith(fontWeight: FontWeight.w700);
  static final whiteS18W700 = whiteS18.copyWith(fontWeight: FontWeight.w700);
  static final whiteS18W500 = whiteS18.copyWith(fontWeight: FontWeight.w500);
  static final mainSolidS18W500 =
      mainSolidS18.copyWith(fontWeight: FontWeight.w500);
  static final errorS18W500 =
  errorS18.copyWith(fontWeight: FontWeight.w500);

  ///weight s14
  static final blackS14W500 = blackS14.copyWith(fontWeight: FontWeight.w500);
  static final whiteS14W500 = whiteS14.copyWith(fontWeight: FontWeight.w500);
  static final secondaryS14W500 =
      secondaryS14.copyWith(fontWeight: FontWeight.w500);

  ///weight s20
  static final blackS20W400 = blackS20.copyWith(fontWeight: FontWeight.w400);
  static final blackS20W700 = blackS20.copyWith(fontWeight: FontWeight.w700);
  static final blackS20W500 = blackS20.copyWith(fontWeight: FontWeight.w500);
  static final whiteS20W700 = whiteS20.copyWith(fontWeight: FontWeight.w700);
  static final mainSolidS20W500 =
      mainSolidS20.copyWith(fontWeight: FontWeight.w500);
  static final mainSolidS11W500 =
      mainSolidS11.copyWith(fontWeight: FontWeight.w500);

  ///weight s22
  static final whiteS22W500 = whiteS22.copyWith(fontWeight: FontWeight.w500);
  static final blackS22W500 = blackS22.copyWith(fontWeight: FontWeight.w500);

  ///weight s24
  static final whiteS24W600 = whiteS24.copyWith(fontWeight: FontWeight.w600);
  static final mainSolidS24W500 =
      mainSolidS24.copyWith(fontWeight: FontWeight.w500);
  static final primary24W700 = primary24.copyWith(fontWeight: FontWeight.w700);

  ///weight s28
  static final whiteS28W500 = whiteS28.copyWith(fontWeight: FontWeight.w500);
  static final primary28W700 = primary28.copyWith(fontWeight: FontWeight.w700);
  static final primary20W700 = primary20.copyWith(fontWeight: FontWeight.w700);
}
