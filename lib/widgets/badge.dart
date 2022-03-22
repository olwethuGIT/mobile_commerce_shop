import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required this.child,
    required this.value,
    this.color,
  }) : super(key: key);

  final Widget? child;
  final String value;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child ?? Container(),
        Positioned(
          right: 0,
          top: -3,
          child: Container(
            height: size.size.width * (16 / 375.0),
            width: size.size.width * (16 / 375.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.5, color: Colors.white),
              color: const Color(0xFFFF4848),
            ),
            child: Center(
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1,
                  fontWeight: FontWeight.w600,
                  color: Colors.white
                ),
              ),
            )
          ),
        )
      ],
    );
  }
}
