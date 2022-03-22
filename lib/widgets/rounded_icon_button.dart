import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';

class RoundedIconButton extends StatelessWidget {
  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  const RoundedIconButton({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Container(
      height: _size.size.width * (40 / 375.0),
      width: _size.size.width * (40 / 375.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: const Offset(0, 6),
              blurRadius: 10,
              color: const Color(0xFFB0B0B0).withOpacity(0.2),
            )
        ]
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            primary: kPrimaryColor,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50)),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
