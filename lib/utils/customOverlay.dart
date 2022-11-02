//  WATER ATLAS
//
//  Created by Ronnie Zad.
//  2022, Centric Solutions-UG. All rights reserved.
//

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedTextExample {
  final String label;
  final Color? color;
  final Widget child;

  const AnimatedTextExample({
    required this.label,
    required this.color,
    required this.child,
  });
}

class CustomOverlay {
  CustomOverlay._();

  static showToast(String message, Color bgColor, Color textColor) {
    Padding widget = Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: Material(
        shadowColor: bgColor,
        borderRadius: BorderRadius.circular(3.r),
        color: bgColor,
        elevation: 23.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3.r),
          child: Container(
            width: double.infinity,
            height: 72.h,
            color: bgColor,
            child: Center(
                child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: textColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
            )),
          ),
        ),
      ),
    );
    showToastWidget(
      widget,
      position: ToastPosition.bottom,
      dismissOtherToast: true,
      animationCurve: Curves.linear,
      animationDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 4),
    );
  }

  ///specify duration in seconds eg 2
  static showLoaderOverlay({required int duration}) {

    Widget loaderOverlay = SizedBox(
      width: 80.w,
      height: 80.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: SizedBox(
            width: 30.w,
            height: 30.w,
            child: const CircularProgressIndicator(
              strokeWidth: 4.0,
              valueColor: AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
    showToastWidget(
      loaderOverlay,
      dismissOtherToast: true,
      position: ToastPosition.center,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 200),
      duration: Duration(seconds: duration),
    );
  }
}
