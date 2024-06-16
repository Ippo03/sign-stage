import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBarcodeImage extends StatelessWidget {
  const CustomBarcodeImage({
    super.key,
    required this.barcode,
    required this.data,
    this.width = 200,
    this.height = 80,
  });

  final Barcode barcode;
  final String data;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final svg = barcode.toSvg(data, width: width, height: height);

    return SvgPicture.string(svg);
  }
}
