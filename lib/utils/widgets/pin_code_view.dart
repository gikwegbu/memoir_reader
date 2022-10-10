// import 'package:amaze/utils/const/commons.dart';
// import 'package:pinput/pin_put/pin_put.dart';

// class PinCodeView extends StatefulWidget {
//   final Function(String) onChanged;
//   final int length;
//   final bool coloredBg;
//   final bool obscureText;
//   final String errorMsg;
//   final TextInputType inputType;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldValidator<String>? validator;

//   const PinCodeView(
//       {Key? key,
//       required this.onChanged,
//       this.length = 4,
//       this.coloredBg = false,
//       this.onSaved,
//       this.validator,
//       this.obscureText = true,
//       this.errorMsg = 'Invalid Code',
//       this.inputType = TextInputType.number})
//       : super(key: key);

//   @override
//   _PinCodeViewState createState() => _PinCodeViewState();
// }

// class _PinCodeViewState extends State<PinCodeView> {
//   bool hasError = false;
//   late String _errorMsg;
//   late TextInputType _inputType;
//   late FocusNode _pinPutFocusNode;

//   BoxDecoration get _pinPutDecoration {
//     return BoxDecoration(
//       border: Border.all(color: BORDER),
//       borderRadius: BorderRadius.circular(5.0),
//     );
//   }

//   @override
//   void initState() {
//     _pinPutFocusNode = FocusNode();
//     if (mounted) {
//       _inputType = widget.inputType;
//       _errorMsg = widget.errorMsg;
//     }
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: pageWidth(context),
//       child: PinPut(
//         obscureText: widget.obscureText ? '⁕' : '',
//         validator: widget.validator ??
//             (text) {
//               if (isEmpty(text) || text!.length < widget.length) {
//                 return _errorMsg;
//               }
//               return null;
//             },
//         pinAnimationType: PinAnimationType.fade,
//         onSaved: widget.onSaved,
//         focusNode: _pinPutFocusNode,
//         keyboardType: _inputType,
//         fieldsCount: widget.length,
//         inputDecoration: FormUtils.pinInputDecoration(),
//         onChanged: (pin) => widget.onChanged(pin),
//         eachFieldHeight: 44,
//         eachFieldWidth: 44,
//         withCursor: true,
//         submittedFieldDecoration: _pinPutDecoration.copyWith(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         selectedFieldDecoration: _pinPutDecoration.copyWith(
//           border: Border.all(
//             color: SLIMY_GREEN,
//           ),
//         ),
//         followingFieldDecoration: _pinPutDecoration.copyWith(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         textStyle: TextStyle(
//           color: widget.coloredBg ? Colors.white : FORM_TEXT,
//           fontSize: 16,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _pinPutFocusNode.dispose();
//     super.dispose();
//   }
// }
