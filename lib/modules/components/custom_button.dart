import 'package:flutter/material.dart';
import 'package:memoir_reader/utils/const/colors.dart';
import 'package:memoir_reader/utils/widgets/text_utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.press,
    required this.title,
  });

  final Function press;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: () => press(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: labelText(
          title,
          context,
          textAlign: TextAlign.center,
          color: isLight,
        ),
      ),
    );
  }
}
