import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();

  //  0xFF  constant for color

  static const Color coral1 = Color(0xffff5100);
  static const Color coral2 = Color(0xffffa47a);
  static const Color grey = Color(0xFF153b50);
  static const Color grey2 = Color(0xFF687980);

  static const Color blue1 = Color(0xFF0D47A1);
  static const Color blue2 = Color(0xffc6e3e3);
  static const Color blue3 = Color(0xffdff1f1);

  //  new
  static const Color pink1 = Color(0xffEB455F);
  static const Color pink2 = Color(0xffF3BDA1);
  static const Color blu1 = Color(0xff2B3467);
  static const Color blu2 = Color(0xffBAD7E9);
  static const Color blu3 = Color(0xffFFFF);
  static const Color white1 = Color(0xffFCFFE7);


  static const black = Colors.black;

}

const green = Color(0xFF00C2A8);
const blue = Color(0xFF0089BA);
const lavander = Color(0xFF845EC2);
const purple = Color(0xFFD65DB1);
const pink = Color(0xFFFF6F91);
const orange = Color(0xFFFF9671);
const yellow = Color(0xFFFFC75F);

List<Color> colorList = [
  green,
  blue,
  lavander,
  purple,
  pink,
  orange,
  yellow
];



ColorList colorListFromJson(String str) => ColorList.fromJson(json.decode(str));

String colorListToJson(ColorList data) => json.encode(data.toJson());

class ColorList {
  ColorList({
    this.colorList,
  });

  List<Color> colorList;

  factory ColorList.fromJson(Map<String, dynamic> json) => ColorList(
    colorList: json["colorList"] == null ? null : List<Color>.from(json["colorList"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "colorList": colorList == null ? null : List<dynamic>.from(colorList.map((x) => x)),
  };
}


