// import 'package:amaze/utils/const/image_utils.dart';
// import 'package:amaze/utils/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class AppWrapper extends StatelessWidget {
//   final Widget body;
//   final Widget? title;
//   final Widget? leading;
//   final List<Widget>? actions;
//   final Widget? floatingActionButton;
//   final Color? backgroundColor;
//   final EdgeInsets? padding;
//   final bool isCancel;
//   final bool safeBottom;
//   final bool hasBar;
//   final double? leadingWidth;
//   final GestureTapCallback? onTap;

//   const AppWrapper(
//       {Key? key,
//       this.actions,
//       required this.body,
//       this.title,
//       this.safeBottom = true,
//       this.hasBar = false,
//       this.leading,
//       this.floatingActionButton,
//       this.backgroundColor,
//       this.padding,
//       this.leadingWidth,
//       this.onTap,
//       this.isCancel = true})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor ?? Colors.white,
//       appBar: AppBar(
//         backgroundColor: backgroundColor ?? Colors.white,
//         elevation: 0,
//         title: title,
//         centerTitle: true,
//         toolbarHeight: 60,
//         leading: !isObjectEmpty(leading)
//             ? leading
//             : Visibility(
//                 visible: !isCancel,
//                 child: InkWell(
//                   onTap: onTap ?? () => Navigator.pop(context),
//                   child: Padding(
//                     padding: hasBar
//                         ? const EdgeInsets.only(top: 30.0)
//                         : const EdgeInsets.all(10.0),
//                     child: SvgPicture.asset(ImageUtils.back),
//                   ),
//                 ),
//               ),
//         leadingWidth: leadingWidth,
//         actions: (!isCancel)
//             ? actions
//             : [
//                 Visibility(
//                   visible: isCancel,
//                   child: InkWell(
//                     onTap: () => Navigator.pop(context),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: SvgPicture.asset(ImageUtils.cancel),
//                     ),
//                   ),
//                 ),
//               ],
//       ),
//       body: SafeArea(
//         bottom: safeBottom,
//         child: Container(
//           height: pageHeight(context),
//           width: pageWidth(context),
//           padding: padding ?? pagePadding,
//           child: body,
//         ),
//       ),
//       floatingActionButton: floatingActionButton,
//     );
//   }
// }

// class BottomSheetWrapper extends StatelessWidget {
//   final Widget child;
//   final bool closeOnTap;

//   const BottomSheetWrapper({
//     Key? key,
//     required this.child,
//     this.closeOnTap = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           width: pageWidth(context),
//           constraints: BoxConstraints(
//             maxHeight: pageHeight(context) * .85,
//           ),
//           margin: const EdgeInsets.only(top: 40),
//           child: SingleChildScrollView(
//             padding:
//                 const EdgeInsets.symmetric(horizontal: 20.0, vertical: 36.0),
//             child: Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//               ),
//               child: child,
//             ),
//           ),
//         ),
//         if (closeOnTap)
//           Positioned(
//             right: 0,
//             top: 16,
//             child: MaterialButton(
//               onPressed: () => navigateBack(context),
//               child: SizedBox(
//                 height: 40,
//                 width: 40,
//                 child: SvgPicture.asset(ImageUtils.cancel),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
