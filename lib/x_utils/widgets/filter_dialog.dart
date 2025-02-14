// import 'package:drum_app/base/base_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get_core/src/get_main.dart';
//
//
// import '../../../x_res/app_text_style.dart';
// import '../../../x_utils/widgets/bottom_button_widget.dart';
// import '../../../x_utils/widgets/date_picker.dart';
// import '../date_time_util.dart';
//
// class FilterOrdersModel {
//   final DateTime? fromDate;
//   final DateTime? toDate;
//   final String? selectFilter;
//   final num? invoiceCode;
//   final num? daTra;
//   final String? mst;
//
//   FilterOrdersModel(
//       {this.fromDate,
//       this.toDate,
//       this.selectFilter,
//       this.invoiceCode,
//       this.daTra,
//       this.mst});
// }
//
// class FilterDialog extends StatefulWidget {
//   FilterDialog({
//     Key? key,
//     this.onPressFilter,
//     this.toDate,
//     this.fromDate,
//     this.scrollController,
//     this.selectFilter,
//     this.filterOrdersModel,
//   }) : super(key: key);
//   final Function(FilterOrdersModel option)? onPressFilter;
//   final String? selectFilter;
//   final DateTime? toDate;
//   final DateTime? fromDate;
//   final ScrollController? scrollController;
//   final FilterOrdersModel? filterOrdersModel;
//
//   @override
//   State<FilterDialog> createState() => _FilterDialogState();
// }
//
// class _FilterDialogState extends State<FilterDialog> {
//   late DateTime toDate, fromDate;
//   String selectFilter = "Hôm nay";
//   num? order, money;
//
//   @override
//   void initState() {
//     toDate = widget.toDate ?? DateTime.now();
//     fromDate = widget.fromDate ?? (DateTime.now().subtract(Duration(days: 1)));
//     if (widget.selectFilter != null) selectFilter = widget.selectFilter!;
//     money = widget.filterOrdersModel?.daTra;
//     order = widget.filterOrdersModel?.invoiceCode;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DraggableScrollableSheet(
//         initialChildSize: 0.75,
//         minChildSize: 0.7,
//         maxChildSize: maxChildSize(),
//         expand: false,
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Container(
//             padding: EdgeInsets.all(16).w,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(16).w)),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () => Get.back(),
//                       child: Icon(
//                         Icons.close,
//                         size: 20,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20.h),
//                 SizedBox(height: 10.h),
//                 Container(
//                   padding: EdgeInsets.all(16).w,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(16).w,
//                       color: MyColor.LIGHT_SOLID),
//                   child: buildDate(),
//                 ),
//                 SizedBox(height: 16.w),
//                 Expanded(
//                   child: ListView(
//                     controller: scrollController,
//                     children: [
//                       Text("Hoá đơn", style: AppTextStyle.blackS12W700),
//                       SizedBox(height: 8.h),
//                       Row(
//                         children: [
//                           Expanded(
//                               child: ButtonFilter(
//                             title: "Không xuất hoá đơn",
//                             onPress: () {
//                               setState(() {
//                                 order = 1;
//                               });
//                             },
//                             isSelected: order == 1,
//                           )),
//                           SizedBox(width: 16.w),
//                           Expanded(
//                               child: ButtonFilter(
//                             title: "Đã xuất hoá đơn",
//                             onPress: () {
//                               setState(() {
//                                 order = 2;
//                               });
//                             },
//                             isSelected: order == 2,
//                           ))
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       Text("Công nợ", style: AppTextStyle.blackS12W700),
//                       SizedBox(height: 8.h),
//                       Row(
//                         children: [
//                           Expanded(
//                               child: ButtonFilter(
//                             title: "Đã trả",
//                             onPress: () {
//                               setState(() {
//                                 money = 2;
//                               });
//                             },
//                             isSelected: money == 2,
//                           )),
//                           SizedBox(width: 16.w),
//                           Expanded(
//                               child: ButtonFilter(
//                             title: "Công nợ",
//                             onPress: () {
//                               setState(() {
//                                 money = 1;
//                               });
//                             },
//                             isSelected: money == 1,
//                           ))
//                         ],
//                       ),
//                       SizedBox(height: 8.h),
//                       Text("Trong quá khứ", style: AppTextStyle.blackS12W700),
//                       buildItemSelect(
//                         text1: "Tất cả",
//                         text2: "3 ngày trước",
//                         onTap1: () {
//                           toDate = DateTime.now().subtract(Duration(days: 1));
//                           fromDate = DateTime.now().subtract(Duration(days: 1));
//                         },
//                         onTap2: () {
//                           toDate = DateTime.now().subtract(Duration(days: 1));
//                           fromDate = DateTime.now().subtract(Duration(days: 3));
//                         },
//                       ),
//                       buildItemSelect(
//                           text1: "7 ngày trước",
//                           text2: "30 ngày trước",
//                           onTap1: () {
//                             toDate = DateTime.now().subtract(Duration(days: 1));
//                             fromDate =
//                                 DateTime.now().subtract(Duration(days: 7));
//                           },
//                           onTap2: () {
//                             toDate = DateTime.now().subtract(Duration(days: 1));
//                             fromDate =
//                                 DateTime.now().subtract(Duration(days: 30));
//                           }),
//                       SizedBox(height: 16.w),
//                       // Text("Gợi ý", style: AppTextStyle.blackS12W700),
//                       // buildItemSelect(
//                       //     text1: "Hôm nay",
//                       //     text2: "Tuần này",
//                       //     onTap1: () {
//                       //       fromDate = DateTime.now();
//                       //       toDate = DateTime.now();
//                       //     },
//                       //     onTap2: () {
//                       //       toDate = DateTime.now();
//                       //       fromDate =
//                       //           DateTime.now().subtract(Duration(days: 7));
//                       //     }),
//                       // buildItemSelect(
//                       //     text1: "Tháng này",
//                       //     text2: "Năm nay",
//                       //     onTap1: () {
//                       //       toDate = DateTime.now();
//                       //       fromDate = DateTime(toDate.year, toDate.month, 1);
//                       //     },
//                       //     onTap2: () {
//                       //       toDate = DateTime.now();
//                       //       fromDate = DateTime(fromDate.year, 1, 1);
//                       //     }),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 BottomButton(
//                   rightText: 'Áp dụng',
//                   onPressRight: () {
//                     Get.back();
//                     var data = FilterOrdersModel(
//                       fromDate: fromDate,
//                       toDate: toDate,
//                       selectFilter: selectFilter,
//                       daTra: money,
//                       invoiceCode: order,
//                     );
//                     widget.onPressFilter?.call(data);
//                   },
//                   onPressLeft: () {
//                     var data = FilterOrdersModel(
//                       fromDate: null,
//                       toDate: null,
//                       selectFilter: "Tất cả",
//                       daTra: null,
//                       invoiceCode: null,
//                     );
//                     widget.onPressFilter?.call(data);
//                   },
//                   padding: EdgeInsets.zero,
//                 ),
//                 SizedBox(height: 16.h)
//               ],
//             ),
//           );
//         });
//   }
//
//   Widget buildItemOther(
//       {String? text1,
//       String? text2,
//       VoidCallback? onTap1,
//       VoidCallback? onTap2}) {
//     return Container(
//       margin: EdgeInsets.only(top: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: text1 != null
//                 ? InkWell(
//                     onTap: () {
//                       onTap1?.call();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
//                       decoration: BoxDecoration(
//                           color: MyColor.MAIN_SOLID
//                               .withOpacity(selectFilter == text1 ? 1 : 0.3),
//                           borderRadius: BorderRadius.circular(8).w),
//                       child: Text(text1, style: AppTextStyle.whiteS14W500),
//                     ),
//                   )
//                 : Container(height: 0),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: text2 != null
//                 ? InkWell(
//                     onTap: () {
//                       onTap2?.call();
//                     },
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
//                       decoration: BoxDecoration(
//                           color: MyColor.MAIN_SOLID
//                               .withOpacity(selectFilter == text2 ? 1 : 0.3),
//                           borderRadius: BorderRadius.circular(8).w),
//                       child: Text(text2, style: AppTextStyle.whiteS14W500),
//                     ),
//                   )
//                 : Container(height: 0),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildItemSelect(
//       {String? text1,
//       String? text2,
//       VoidCallback? onTap1,
//       VoidCallback? onTap2}) {
//     return Container(
//       margin: EdgeInsets.only(top: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: text1 != null
//                 ? InkWell(
//                     onTap: () => setState(() {
//                       selectFilter = text1;
//                       onTap1?.call();
//                     }),
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
//                       decoration: BoxDecoration(
//                           color: MyColor.MAIN_SOLID
//                               .withOpacity(selectFilter == text1 ? 1 : 0.3),
//                           borderRadius: BorderRadius.circular(8).w),
//                       child: Text(text1, style: AppTextStyle.whiteS14W500),
//                     ),
//                   )
//                 : Container(height: 0),
//           ),
//           SizedBox(width: 16.w),
//           Expanded(
//             child: text2 != null
//                 ? InkWell(
//                     onTap: () => setState(() {
//                       selectFilter = text2;
//                       onTap2?.call();
//                     }),
//                     child: Container(
//                       alignment: Alignment.center,
//                       padding:
//                           EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
//                       decoration: BoxDecoration(
//                           color: MyColor.MAIN_SOLID
//                               .withOpacity(selectFilter == text2 ? 1 : 0.3),
//                           borderRadius: BorderRadius.circular(8).w),
//                       child: Text(text2, style: AppTextStyle.whiteS14W500),
//                     ),
//                   )
//                 : Container(height: 0),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Row buildDate() {
//     return Row(
//       children: [
//         Expanded(
//           child: InkWell(
//             onTap: () => _iosDatePicker(
//                 value: fromDate,
//                 maximumDate: DateTime.now(),
//                 onChange: (value) => setState(() {
//                       fromDate = value;
//                       selectFilter = "";
//                     })),
//             child: Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(16).w,
//                       topLeft: Radius.circular(16).w)),
//               padding: EdgeInsets.all(16).w,
//               child: Row(
//                 children: [
//                   Text(DateTimeUtil.getDMYFromDateTime(fromDate)),
//                   Spacer(),
//                   SvgPicture.asset(XR().svgImage.ic_calender)
//                 ],
//               ),
//             ),
//           ),
//         ),
//         SizedBox(width: 16.w),
//         Expanded(
//           child: InkWell(
//             onTap: () => _iosDatePicker(
//                 maximumDate: DateTime.now(),
//                 value: toDate,
//                 onChange: (value) => setState(() {
//                       toDate = value;
//                       selectFilter = "";
//                       if (toDate.microsecondsSinceEpoch <
//                           fromDate.microsecondsSinceEpoch) {
//                         fromDate = value;
//                       }
//                     })),
//             child: Container(
//               padding: EdgeInsets.all(16).w,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       bottomRight: Radius.circular(16).w,
//                       topLeft: Radius.circular(16).w)),
//               child: Row(
//                 children: [
//                   Text(DateTimeUtil.getDMYFromDateTime(toDate)),
//                   Spacer(),
//                   SvgPicture.asset(XR().svgImage.ic_calender)
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
//   double maxChildSize() {
//     return 0.9;
//   }
//
//   _iosDatePicker(
//       {DateTime? value,
//       DateTime? maximumDate,
//       DateTime? minimumDate,
//       Function(DateTime value)? onChange}) {
//     showCupertinoModalPopup(
//         context: Get.context!,
//         builder: (BuildContext builder) {
//           return DatePicker(
//             initialDateTime: value,
//             onChange: (value) {
//               onChange?.call(value);
//             },
//             maximumDate: maximumDate,
//             minimumDate: minimumDate,
//           );
//         });
//   }
// }
//
// class ButtonFilter extends StatelessWidget {
//   final VoidCallback? onPress;
//   final bool isSelected;
//   final String title;
//
//   const ButtonFilter(
//       {Key? key, this.onPress, this.title = "", this.isSelected = false})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onPress?.call();
//       },
//       child: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
//         decoration: BoxDecoration(
//             color: MyColor.MAIN_SOLID.withOpacity(isSelected ? 1 : 0.3),
//             borderRadius: BorderRadius.circular(8).w),
//         child: Text(title, style: AppTextStyle.whiteS14W500),
//       ),
//     );
//   }
// }
