import 'package:flutter/material.dart';

import '../../../../common/color.dart';

class CustomButton extends StatelessWidget {
  final String text;

  const CustomButton({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.backgroundColor,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: AppColor.whiteColor),
          ),
          Icon(
            Icons.arrow_forward,
            color: AppColor.whiteColor,
          ),
        ],
      ),
    );
  }
}