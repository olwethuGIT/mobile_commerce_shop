import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget{
  final bool showFavorites;
  const ProductsGrid({Key? key, required this.showFavorites}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsList = showFavorites ? Provider.of<Products>(context).favoriteItems: Provider.of<Products>(context).items;
    // TODO: implement build
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productsList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: productsList[i],
            child: const ProductItem(),
        )
    );
  }
}