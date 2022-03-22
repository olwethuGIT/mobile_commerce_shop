import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/widgets/product_description.dart';
import 'package:provider/provider.dart';

import '../widgets/color_dots.dart';
import '../widgets/top_rounded_container.dart';
import '../providers/products.dart';
import '../widgets/default_button.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName = '/product-detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    final productId =  ModalRoute.of(context)?.settings.arguments as String;
    final loadedProducts = Provider.of<Products>(context, listen: false).findById(productId);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(loadedProducts.imageUrl, fit: BoxFit.cover,),
            ),
            TopRoundedContainer(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Text(
                      'R ${loadedProducts.price}',
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(height: 10,),
                    ProductDescription(
                        description: loadedProducts.description,
                        press: () {},
                        isFavorite: loadedProducts.isFavourite,
                        title: loadedProducts.title,
                    ),
                    TopRoundedContainer(
                        color: const Color(0xFFF6F7F9),
                        child: Column(
                          children: <Widget>[
                            const ColorDots(),
                            TopRoundedContainer(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: _size.size.width * 0.15,
                                  right: _size.size.width * 0.15,
                                  bottom: _size.size.width * (40 / 375.0),
                                  top: _size.size.width * (15 / 375.0)
                                ),
                                child: DefaultButton(
                                  title: "Add To Card",
                                  press: () {},
                                ),
                              ),
                            )
                          ],
                        )
                    )
                  ],
                )
            )
          ],
        ),
      )
    );
  }
}
