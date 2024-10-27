/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/appointment.svg
  String get appointment => 'assets/icons/appointment.svg';

  /// File path: assets/icons/back-icon.svg
  String get backIcon => 'assets/icons/back-icon.svg';

  /// File path: assets/icons/google.svg
  String get google => 'assets/icons/google.svg';

  /// File path: assets/icons/guest.svg
  String get guest => 'assets/icons/guest.svg';

  /// File path: assets/icons/home.svg
  String get home => 'assets/icons/home.svg';

  /// File path: assets/icons/measurement.svg
  String get measurement => 'assets/icons/measurement.svg';

  /// File path: assets/icons/order.svg
  String get order => 'assets/icons/order.svg';

  /// List of all assets
  List<String> get values =>
      [appointment, backIcon, google, guest, home, measurement, order];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/back_img.png
  AssetGenImage get backImg =>
      const AssetGenImage('assets/images/back_img.png');

  /// File path: assets/images/chat_bg.png
  AssetGenImage get chatBg => const AssetGenImage('assets/images/chat_bg.png');

  /// File path: assets/images/custom_icon.png
  AssetGenImage get customIcon =>
      const AssetGenImage('assets/images/custom_icon.png');

  /// File path: assets/images/custom_size.png
  AssetGenImage get customSize =>
      const AssetGenImage('assets/images/custom_size.png');

  /// File path: assets/images/front_img.png
  AssetGenImage get frontImg =>
      const AssetGenImage('assets/images/front_img.png');

  /// File path: assets/images/home_alteration.png
  AssetGenImage get homeAlteration =>
      const AssetGenImage('assets/images/home_alteration.png');

  /// File path: assets/images/home_appointment.png
  AssetGenImage get homeAppointment =>
      const AssetGenImage('assets/images/home_appointment.png');

  /// File path: assets/images/home_guide.png
  AssetGenImage get homeGuide =>
      const AssetGenImage('assets/images/home_guide.png');

  /// File path: assets/images/home_journey1.png
  AssetGenImage get homeJourney1 =>
      const AssetGenImage('assets/images/home_journey1.png');

  /// File path: assets/images/home_stitching.png
  AssetGenImage get homeStitching =>
      const AssetGenImage('assets/images/home_stitching.png');

  /// File path: assets/images/login_img.png
  AssetGenImage get loginImg =>
      const AssetGenImage('assets/images/login_img.png');

  /// File path: assets/images/login_success.png
  AssetGenImage get loginSuccess =>
      const AssetGenImage('assets/images/login_success.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/measurement_top.png
  AssetGenImage get measurementTop =>
      const AssetGenImage('assets/images/measurement_top.png');

  /// File path: assets/images/side_img.png
  AssetGenImage get sideImg =>
      const AssetGenImage('assets/images/side_img.png');

  /// File path: assets/images/splash1.png
  AssetGenImage get splash1 => const AssetGenImage('assets/images/splash1.png');

  /// File path: assets/images/splash2.png
  AssetGenImage get splash2 => const AssetGenImage('assets/images/splash2.png');

  /// File path: assets/images/splash3.png
  AssetGenImage get splash3 => const AssetGenImage('assets/images/splash3.png');

  /// File path: assets/images/standard_icon.png
  AssetGenImage get standardIcon =>
      const AssetGenImage('assets/images/standard_icon.png');

  /// File path: assets/images/standard_size.png
  AssetGenImage get standardSize =>
      const AssetGenImage('assets/images/standard_size.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        backImg,
        chatBg,
        customIcon,
        customSize,
        frontImg,
        homeAlteration,
        homeAppointment,
        homeGuide,
        homeJourney1,
        homeStitching,
        loginImg,
        loginSuccess,
        logo,
        measurementTop,
        sideImg,
        splash1,
        splash2,
        splash3,
        standardIcon,
        standardSize
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}