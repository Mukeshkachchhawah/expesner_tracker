import 'package:flutter/material.dart';

Widget hSpeace({double mHeight = 25.0}) {
  return SizedBox(
    height: mHeight,
  );
}

Widget wSpeace({double mwidth = 15.0}) {
  return SizedBox(
    width: mwidth,
  );
}

TextStyle textStyle16() {
  return const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}
TextStyle textStyle20({colors = Colors.black}) {
  return  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: colors);
}

TextStyle textStyle80() {
  return const TextStyle(fontSize: 80, fontWeight: FontWeight.bold);
}

Widget CustomButton(VoidCallback onttped, String text) {
  return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: () {},
          child: Text(
            text,
            style: textStyle20(),
          )));
}
