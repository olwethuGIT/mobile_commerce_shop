import 'package:flutter/material.dart';

class TopRoundedContainer extends StatelessWidget {
  final Color color;
  final Widget child;

  const TopRoundedContainer({Key? key, required this.color, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Container(
      margin: EdgeInsets.only(top: _size.size.width * (20 / 375.0)),
      padding: EdgeInsets.only(top: _size.size.width * (20 / 375.0)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
        )
      ),
      child: child,
    );
  }
}
