import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';
import '../screens/cart_screen.dart';
import '../size_config.dart';
import './circle_button.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: _size.size.width * 0.6,
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15)
            ),
            child: TextField(
              onChanged: (value)  {},
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0), vertical:  _size.size.width * (9 / 375.0)),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Search product",
                prefixIcon: const Icon(Icons.search)
              ),
            ),
          ),
          CircleButton(
              iconToUse: const Icon(Icons.shopping_cart),
              press: () => Navigator.of(context).pushNamed(CartScreen.routeName)
          ),
          CircleButton(
            iconToUse: const Icon(Icons.doorbell),
            press: () {},
          )
        ],
      ),
    );
  }
}
