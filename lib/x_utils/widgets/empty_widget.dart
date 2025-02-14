// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:senpos_ticket/x_res/x_r.dart';
// import 'package:lottie/lottie.dart';
//
// class EmptyScreen extends StatefulWidget {
//   final Future<void> Function()? onRefresh;
//   final String? title;
//   const EmptyScreen({Key? key, this.onRefresh, this.title}) : super(key: key);
//
//   @override
//   _EmptyScreenState createState() => _EmptyScreenState();
// }
//
// class _EmptyScreenState extends State<EmptyScreen> {
//   bool _isLoading = false;
//
//   Future<void> _handleRefresh() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     await widget.onRefresh?.call();
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // SvgPicture.asset(XR().svgImage.ic_empty),
//             Lottie.asset('assets/gif/empty.json',width: 150.w),
//             SizedBox(height: 16),
//             Text(widget.title??'No data'),
//             SizedBox(height: 8),
//             // if (_isLoading)
//             //   CircularProgressIndicator()
//             // else
//             //   ElevatedButton.icon(
//             //     onPressed: _handleRefresh,
//             //     icon: Icon(Icons.refresh),
//             //     label: Text('Pull to reload'),
//             //   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
