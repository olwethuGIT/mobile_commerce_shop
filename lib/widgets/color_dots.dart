import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';
import 'package:mobile_commerce_shop/widgets/rounded_icon_button.dart';

class ColorDots extends StatelessWidget {
  const ColorDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedColor = 3;
    final _size = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
        child: Row(
          children: <Widget>[
            ...List.generate(
                4,
                (i) => ColorDot(
                    color: Colors.green,
                    isSelected: i == selectedColor
                )
            ),
            const Spacer(),
            RoundedIconButton(
              icon: Icons.remove,
              press: () {},
            ),
            SizedBox(
              width: _size.size.width * (20 / 375.0),
            ),
            RoundedIconButton(
                icon: Icons.add,
                showShadow: true,
                press: () {}
            )
          ],
        ),
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorDot({Key? key, required this.color, required this.isSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Container(
      margin: const EdgeInsets.only(right: 2),
      padding: EdgeInsets.all(_size.size.width * (8 / 375.0)),
      height: _size.size.width * (40 / 375.0),
      width: _size.size.width * (40 / 375.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: isSelected ? kPrimaryColor : Colors.transparent),
        shape: BoxShape.circle
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
        ),
      ),
    );
  }
}
