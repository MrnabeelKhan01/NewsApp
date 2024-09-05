import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  VoidCallback onPressed;
  String btnLabel;
  double width;
  double height;
  Color ?color;
  Color ?textColor;
  double ?textSize;
  FontWeight ?fontWeight;

  AppButton(
      {super.key, required this.onPressed,
        required this.btnLabel,
        this.color,
        this.textSize=16,
        this.fontWeight=FontWeight.w400,
        this.textColor=Colors.white,
        this.width = double.infinity,
        this.height = 48});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? const Color(0xff231204),
          fixedSize: Size(width, height),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            btnLabel,
            style:  TextStyle(
              color:textColor!,
              fontWeight:fontWeight,
              fontFamily:"Poppins",
              fontSize: textSize!,
            ),
          ),
        ],
      ),
    );
  }
}
