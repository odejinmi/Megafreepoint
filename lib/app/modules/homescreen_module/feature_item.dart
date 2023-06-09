import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FeatureItem extends StatelessWidget {
  final String? text;
  final String? asset;
  final GestureTapCallback? onTap;

  const FeatureItem({Key? key, this.text, this.asset, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 250.w,
        height: 275.w,
        child: Column(
          children: [
            Image.asset(
              asset!,
              width: 148.w,
              height: 148.w,
              fit: BoxFit.cover,
            ),
            Expanded(child: Container()),
            SizedBox(
              width: 250.w,
              child: AutoSizeText(
                text!,
                textAlign: TextAlign.center,
                maxLines: 1,
                minFontSize: 1,
                style: TextStyle(fontSize: 44.sp, color: const Color(0xFF1c1c1c)),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}