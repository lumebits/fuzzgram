import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:flutter_native_admob/native_admob_options.dart';

class AdmobHelper {
  static final AdmobHelper _admobHelper = AdmobHelper._internal();

  AdmobHelper._internal();

  factory AdmobHelper() {
    return _admobHelper;
  }

  final _controller = NativeAdmobController();

  static String nativeAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-4626087653139766/7416737629'
      : 'ca-app-pub-4626087653139766/2698531909';

  Widget nativeAd() {
    return Container(
      height: 65,
      child: NativeAdmob(
        adUnitID: nativeAdUnitId,
        options: const NativeAdmobOptions(
            ratingColor: const Color(0xFFFF5757),
            adLabelTextStyle: NativeTextStyle(
                fontSize: 12,
                color: Colors.white,
                backgroundColor: const Color(0xFFFFDE59)),
          callToActionStyle: NativeTextStyle(
              fontSize: 15,
              color: Colors.white,
              backgroundColor: const Color(0xFFFF5757)
          ),
        ),
        type: NativeAdmobType.banner,
        controller: _controller,
      ),
    );
  }
}
