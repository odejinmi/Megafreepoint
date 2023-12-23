import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialogWidget extends StatelessWidget {
  final Widget? widget;
  final Color? color;

  const CustomAlertDialogWidget({super.key, this.widget, this.color});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: widget,
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
    );
  }
}

CustomAlertDialogWidgetloader({required Widget widget, Color color = Colors.white}) {
  Get.dialog(CustomAlertDialogWidget(
    widget: widget,
    color: color,
  ));
}
