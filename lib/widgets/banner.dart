import 'package:flutter/material.dart';

class DiscountBanner extends StatelessWidget {
  const DiscountBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(_size.size.width * (20 / 375.0)),
      padding: EdgeInsets.symmetric(
        horizontal: _size.size.width * (20 / 375.0),
        vertical: _size.size.width * (15 / 375.0)
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4A3298),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            const TextSpan(text: "A Summer Surprise\n"),
            TextSpan(
              text: "Cashback 20%",
              style: TextStyle(
                fontSize: _size.size.width * (24 / 375.0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ),
    );
  }
}
