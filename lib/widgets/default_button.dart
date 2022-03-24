import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';

class DefaultButton extends StatelessWidget {
  final String? title;
  final Function? press;

  const DefaultButton({Key? key, required this.title, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return SizedBox(
      width: double.infinity,
      height: _size.size.width * (40 / 375.0),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
        onPressed: press as void Function()?,
        child: Text(title!, style: TextStyle(
          fontSize: _size.size.width * (18 / 375.0),
          color: Colors.white
        ),
        ),
      ),
    );
  }
}
