import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';

Widget generalTextField(
  String hintText, {
  bool isPassword = false,
  TextInputType? textInputType,
  required FocusNode focusNode,
  bool hasSuffixIcon = false,
  IconData? icon,
  bool hasIconBackgroundColor = false,
  Color? iconBackgroundColor,
  TextEditingController? controller,
  String? errorText,
  double marginLeft = 0.0,
  double marginRight = 0.0,
  double marginTop = 0.0,
  double marginBottom = 0.0,
}) {
  return Container(
    margin: EdgeInsets.only(
      left: marginLeft,
      right: marginRight,
      top: marginTop,
      bottom: marginBottom,
    ),
    child: TextFormField(
      keyboardType: textInputType,
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        // suffixIcon: hasSuffixIcon
        //     ? Container(
        //         color: hasIconBackgroundColor
        //             ? iconBackgroundColor
        //             : Colors.transparent,
        //         child: Icon(icon),
        //       )
        //     : Container(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
        errorText: errorText,
        labelText: hintText,
        hintText: hintText,
        focusColor: primary,
        hintStyle: const TextStyle(color: primary),
        errorStyle: const TextStyle(color: primary),
        labelStyle: focusNode.hasFocus
            ? const TextStyle(color: primary)
            : const TextStyle(color: primary),
      ),
    ),
  );
}

Widget generalText(
  String text, {
  Color textColor = Colors.white,
  bool isUnderlined = false,
  double fontSize = 16.0,
  FontWeight fontWeight = FontWeight.normal,
  double marginLeft = 0.0,
  double marginRight = 0.0,
  double marginTop = 0.0,
  double marginBottom = 0.0,
  bool isTappable = false,
  double padding = 0.0,
  Function()? onTap,
  BoxDecoration? boxDecoration,
  TextAlign textAlign = TextAlign.center,
}) {
  return InkWell(
    onTap: isTappable ? onTap! : null,
    child: Container(
      padding: EdgeInsets.all(padding),
      decoration: boxDecoration,
      margin: EdgeInsets.only(
        left: marginLeft,
        right: marginRight,
        top: marginTop,
        bottom: marginBottom,
      ),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: fontWeight,
          decoration: isUnderlined ? TextDecoration.underline : null,
        ),
        textAlign: textAlign,
      ),
    ),
  );
}

Text labelText(
  String label,
  BuildContext context, {
  Color? color,
  TextAlign? textAlign,
  double? fontSize,
  FontWeight? fontWeight,
  TextOverflow? overflow,
  double? letterSpacing,
}) {
  return Text(
    label,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    overflow: overflow,
    softWrap: true,
    style: TextStyle(
      // color: color ?? primary,
      color: color ?? (isDarkMode(context) ? Colors.white : Colors.black),
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? 16,
      letterSpacing: letterSpacing,
    ),
  );
}

Text titleText(String label, BuildContext context, {TextAlign? textAlign}) {
  return labelText(
    label,
    context,
    fontWeight: FontWeight.bold,
    fontSize: 17,
    textAlign: textAlign,
  );
}

Text subtext(
  String label,
  BuildContext context, {
  Color? color,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  TextDecoration? textDecoration,
  double? fontSize,
  int? maxLines,
  TextOverflow? overflow,
  double height = 1.2,
}) {
  String finalLabel;
  if (label.contains('U+')) {
    final iconString = label.length > 7 ? label.substring(0, 7) : label;
    const find = 'U+';
    const replaceWith = '0x';
    final emoji = int.parse(iconString.replaceAll(find, replaceWith));
    finalLabel = String.fromCharCode(emoji);
  } else {
    finalLabel = label;
  }
  return Text(
    // label,
    finalLabel,
    textScaleFactor: 1.0,
    textAlign: textAlign,
    softWrap: true,
    overflow: overflow,
    maxLines: maxLines,
    style: TextStyle(
      // color: color ?? primary,
      color: color ?? (isDarkMode(context) ? Colors.white : Colors.black),
      fontSize: fontSize ?? 15,
      fontWeight: fontWeight ?? FontWeight.w400,
      decoration: textDecoration,
      height: height,
    ),
  );
}
