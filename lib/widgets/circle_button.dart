import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/providers/cart.dart';
import 'package:provider/provider.dart';
import 'badge.dart';

class CircleButton extends StatelessWidget {
  final Icon iconToUse;
  final GestureTapCallback press;

  const CircleButton({Key? key, required this.iconToUse, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString()
            ),
            child: iconToUse,
          )
        ],
      ),
    );
  }
}
