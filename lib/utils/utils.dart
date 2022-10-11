import 'dart:math';
import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:memoir_reader/utils/const/image_url.dart';
import 'package:nanoid/nanoid.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:jiffy/jiffy.dart';

const FontFamily = "SF-Pro";

Duration get screenDuration => const Duration(milliseconds: 200);

double screenWidth(context) => MediaQuery.of(context).size.width;

double screenHeight(context) => MediaQuery.of(context).size.height;

EdgeInsetsGeometry get screenPadding =>
    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0);

SizedBox ySpace({double? height}) {
  return SizedBox(height: height ?? 20);
}

SizedBox xSpace({double? width}) {
  return SizedBox(width: width ?? 20);
}

closeKeyPad(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String formatDateOnly(DateTime now) => DateFormat.yMMMEd().format(now);

String formatDate(DateTime now) => DateFormat('yMd').format(now);

String fullDate(DateTime now) => DateFormat('d MMMM, y').format(now);

// String shortDate(DateTime now) => Jiffy(now).fromNow();
String shortDate(DateTime now) => Jiffy(now).E;
// String shortDate(DateTime now) => DateFormat('dd MMMM, yyyy').format(now);

const namePattern = r"[A-Za-z .'\-]+$";
const passwordPattern =
    r"^(?=.*[~!@#$%^&*()_\-+=|\\{}[\]:;<>?/])(?=.*[A-Z])(?=.*[a-z])\S{6,99}$";

navigate(BuildContext context, String route, {dynamic arguments}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

navigateAndClearAll(BuildContext context, String route,
    {String? secondRoute, dynamic arguments}) {
  Navigator.of(context).pushNamedAndRemoveUntil(
      route, ModalRoute.withName(secondRoute ?? '/'),
      arguments: arguments);
}

navigateAndDrop(BuildContext context) {
  Navigator.of(context).popUntil(ModalRoute.withName('/'));
}

navigateBackTill(BuildContext context, {String? route}) {
  Navigator.of(context).popUntil(ModalRoute.withName(route ?? '/'));
}

navigateAndClearPrev(BuildContext context, String route, {dynamic arguments}) {
  Navigator.of(context).popAndPushNamed(route, arguments: arguments);
}

navigateBack(BuildContext context) {
  Navigator.pop(context);
}

isEmpty(String? val) {
  return (val == null) || (val.trim().isEmpty);
}

isNotEmpty(String? val) {
  return !isEmpty(val);
}

isMap(dynamic val) {
  return (val is Map);
}

isNumber(String val) {
  return num.tryParse(val) != null;
}

isObjectEmpty(dynamic val) {
  if (val is Map) return val.isEmpty;
  if (val is List) return val.isEmpty;
  if (val is String) return isEmpty(val);
  return (val == null);
}

bool isDarkMode(context) {
  final Brightness brightness = MediaQuery.platformBrightnessOf(context);
  return brightness == Brightness.dark;
}

getObjectOrNull(dynamic val) {
  return isObjectEmpty(val) ? null : val;
}

String? notSpecifiedString(String? val) {
  return isEmpty(val) ? 'Not Specified' : val;
}

String submittedString(String? val) {
  return isEmpty(val) ? 'Not Specified' : 'Submitted';
}

String? nullSafeString(String? val) {
  return isObjectEmpty(val) ? 'N/A' : val;
}

String? trimValue(String? val) {
  return isNotEmpty(val) ? val!.trim() : null;
}

String capitalize(String s) {
  List<String> names = s.split(' ');
  if (names.isNotEmpty) {
    return names
        .map((e) => e[0].toUpperCase() + e.substring(1).toLowerCase())
        .join(' ');
  }
  return s;
}

double convertMoneyToDouble(dynamic value) =>
    double.parse((value as String).replaceAll(',', ''));

String formatAmount(double? amount) {
  if (amount == null) {
    return '';
  }
  return NumberFormat.currency(
          name: '', decimalDigits: (isInteger(amount)) ? 0 : 2)
      .format(amount);
  // MoneyInputFormatter fmf = MoneyInputFormatter(amount: amount, settings: MoneyFormatterSettings(fractionDigits: isInteger(amount) ? 0 : 2));
  // return fmf.output.nonSymbol;
}

num _newNum = 0;

String format(String val) {
  final NumberFormat format =
      NumberFormat.currency(locale: 'en', symbol: '', decimalDigits: 2);
  _newNum = num.tryParse(val) ?? 0;
  _newNum /= pow(10, format.decimalDigits!);
  return format.format(_newNum).trim();
}

bool isInteger(num value) => value is int || value == value.roundToDouble();

String formatCurrencyAmount(String ccy, double amount) {
  return '$ccy${formatAmount(amount)}';
}

safeNavigate(Function callback) {
  Future.microtask(() => callback());
}

enum _AlertType { error, success, message }

showNotification(
    {required String message,
    required Duration duration,
    GestureTapCallback? onTap}) {
  BotToast.showSimpleNotification(
    title: message,
    duration: duration,
    onTap: onTap,
  );
}

showText({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.message, d: duration);
}

_showAlert(String message, _AlertType alert, {Duration? d}) {
  var bgColor = Colors.black.withOpacity(.9);
  var duration = d ?? const Duration(seconds: 2);

  switch (alert) {
    case _AlertType.error:
      bgColor = Colors.red;
      duration = d ?? const Duration(seconds: 3);
      break;
    case _AlertType.success:
      bgColor = Colors.green;
      break;
    default:
      break;
  }
  BotToast.showText(
    text: message,
    contentColor: bgColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
    textStyle: const TextStyle(fontSize: 13.0, color: Colors.white),
    duration: duration,
  );
}

showSuccess({required String message}) {
  _showAlert(message, _AlertType.success);
}

showError({required String message, Duration? duration}) {
  _showAlert(message, _AlertType.error, d: duration);
}

String errorMessageToString(List<String>? message) {
  return isObjectEmpty(message)
      ? 'Sever error occurred. Please try again later'
      : message!.join("\n");
}

memoirLoader() {
  BotToast.showCustomLoading(
    toastBuilder: (_) => ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(80.0),
                child: Lottie.asset(
                  ImageUtils.book,
                  height: 60,
                ),
              ),
              // Lottie.network(
              //   // 'https://assets9.lottiefiles.com/private_files/lf30_t8f3t4.json',
              //   // 'https://assets9.lottiefiles.com/packages/lf20_o1zjyvqh.json',
              // "https://assets9.lottiefiles.com/packages/lf20_casefpt2.json",
              // ),
            ),
          ],
        ),
      ),
    ),
  );
}

showLoading({String? message, context}) {
  BotToast.showCustomLoading(
    toastBuilder: (_) => Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primary),
              ),
            ),
            if (isNotEmpty(message))
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: subtext(message!, context, fontSize: 13),
              )
          ],
        ),
      ),
    ),
  );
}

enum DialogAction { yes, cancel }

Future<DialogAction> showAlertDialog(
  BuildContext context, {
  String? title,
  required Widget body,
  bool withButton = true,
  bool withCancel = true,
  Widget? button,
  String? cancelTitle,
  String? okTitle,
}) async {
  final action = await showPlatformDialog(
    context: context,
    androidBarrierDismissible: false,
    builder: (_) => BasicDialogAlert(
      title: labelText(
        title ?? "Confirmation",
        context,
        color: primary,
        fontWeight: FontWeight.bold,
      ),
      content: body,
      actions: <Widget>[
        if (withCancel)
          BasicDialogAction(
            title: Text(
              cancelTitle ?? 'Cancel',
              textScaleFactor: 1.0,
              style: const TextStyle(
                color: primary,
              ),
            ),
            onPressed: () => Navigator.of(context).pop(DialogAction.cancel),
          ),
        BasicDialogAction(
          title: Text(
            okTitle ?? "ok",
            textScaleFactor: 1.0,
            style: const TextStyle(
              color: primary,
            ),
          ),
          onPressed: () => Navigator.of(context).pop(DialogAction.yes),
        ),
      ],
    ),
  );
  return (action != null) ? action : DialogAction.cancel;
}

generateUniqueCode() {
  return customAlphabet(
      '1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 10);
}

String getFileExtension(String path) {
  List<String> values = path.split('/');
  List<String> extensions = values[values.length - 1].split('.');
  return extensions[extensions.length - 1];
}

String getFileName(String path) {
  List<String> values = path.split('/');
  return values[values.length - 1];
}

// Future checkPermission() async {
//   final status = await Permission.storage.status;
//   if ((status == PermissionStatus.permanentlyDenied) || (status == PermissionStatus.restricted)) {
//     openAppSettings();
//     return false;
//   }
//   if (status != PermissionStatus.granted) {
//     final result = await Permission.storage.request();
//     if (result == PermissionStatus.granted) {
//       return true;
//     }
//   } else {
//     return true;
//   }
//   return false;
// }

extension StripWhiteSpace on String {
  String stripWhiteSpaces() {
    return replaceAll(' ', '');
  }
}
