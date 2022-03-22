import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/widgets/banner.dart';
import 'package:mobile_commerce_shop/widgets/categories.dart';
import 'package:mobile_commerce_shop/widgets/home_header.dart';
import 'package:mobile_commerce_shop/widgets/special_offers.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox( height: _size.size.height * (20 / 812.0)),
            const HomeHeader(),
            SizedBox(height: _size.size.width * (10 / 375.0)),
            const DiscountBanner(),
            const Categories(),
            const SpecialOffers(),
            SizedBox(height: _size.size.width * (30 / 375.0)),
          ],
        ),
      ),
    );
  }
}
