import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/utils.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';
import 'package:super_tooltip/super_tooltip.dart';

const FORM_STYLE = TextStyle(fontSize: 15);

class FormUtils {
  static InputDecoration formDecoration({
    String? labelText,
    String? helperText,
    Widget? suffix,
    Widget? prefix,
    String? hintText,
    String? suffixText,
    Widget? suffixIcon,
    bool isLoading = false,
    double? verticalPadding,
    Widget? prefixIcon,
    bool enabled = true,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 16.0),
      helperText: helperText,
      helperStyle: const TextStyle(fontSize: 15.0),
      hintText: hintText,
      hintStyle: const TextStyle(fontSize: 14.0),
      suffix: suffix,
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(maxWidth: 30),
      prefix: prefix,
      alignLabelWithHint: true,
      enabled: enabled,
      suffixText: suffixText,
      suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      suffixIcon: suffixIcon,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(color: green, width: 1),
      ),
      errorStyle: const TextStyle(
        fontSize: 14.0,
        color: Colors.red,
      ),
      filled: true,
      fillColor: Colors.white24,
      isDense: true,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12, vertical: verticalPadding ?? 16),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: green,
        ),
      ),
    );
  }

  static InputDecoration pinInputDecoration() {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 0),
    );
    return const InputDecoration(
      errorStyle: TextStyle(
        fontSize: 14.0,
      ),
      border: border,
      focusedErrorBorder: border,
      contentPadding: EdgeInsets.all(0),
      enabledBorder: border,
      counterText: "",
      enabled: false,
      errorBorder: border,
      focusedBorder: border,
    );
  }

  static InputDecoration searchInputDecorator({
    String? placeHolder,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade200,
      hintText: placeHolder ?? "Try ‘don jazzy’",
      suffixIcon: suffixIcon,
      prefixIcon: const Icon(
        Icons.search,
        size: 22,
        color: primary,
      ),
      hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
      enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
          borderSide: BorderSide(color: Colors.transparent, width: 0)),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  static Widget formSpacer() {
    return const SizedBox(
      height: 28.0,
    );
  }
}

class FormLabel extends StatefulWidget {
  final String label;
  final Color? color;
  final String? hint;

  const FormLabel({Key? key, required this.label, this.color, this.hint})
      : super(key: key);

  @override
  _FormLabelState createState() => _FormLabelState();
}

class _FormLabelState extends State<FormLabel> {
  SuperTooltip? tooltip;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            subtext(widget.label, context,
                fontSize: 13,
                color: widget.color ?? Colors.grey,
                fontWeight: FontWeight.w600),
            xSpace(width: 8),
            if (isNotEmpty(widget.hint))
              InkWell(
                onTap: _onTap,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Icon(
                    Icons.info,
                    size: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
        if (isEmpty(widget.hint))
          const SizedBox(
            height: 8.0,
          ),
      ],
    );
  }

  void _onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      // arrowTipDistance: 15.0,
      arrowBaseWidth: 40.0,
      borderColor: green.withOpacity(0.6),
      backgroundColor: black,
      showCloseButton: ShowCloseButton.none,
      closeButtonColor: Colors.transparent,
      closeButtonSize: 18,

      content: Material(
        // color: Colors.blue.shade100,
        color: black,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.info,
              color: Colors.white,
              size: 20,
            ),
            xSpace(width: 8),
            Expanded(
              child: subtext(
                widget.hint!,
                context,
                fontSize: 11,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: const Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 2.0),
            //     child: Icon(
            //       Icons.clear,
            //       color: Colors.white,
            //       size: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );

    tooltip!.show(context);
  }
}

class SectionDivider extends StatelessWidget {
  final String label;

  const SectionDivider({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      const Expanded(child: Divider()),
      xSpace(width: 5),
      subtext(label, context, fontSize: 12, color: Colors.grey),
      xSpace(width: 5),
      const Expanded(child: Divider()),
    ]);
  }
}
