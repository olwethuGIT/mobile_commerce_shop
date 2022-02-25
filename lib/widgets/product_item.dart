import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget{
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    // TODO: implement build
    return Consumer<Product>(
        builder: (ctx, product, _) => ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
              },
              child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black38,
              leading: IconButton(
                icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  product.toggleFavouriteStatus();
                },
                color: Theme.of(context).accentColor,
              ),
              title: Text(product.title, textAlign: TextAlign.center,),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                },
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
    );
  }

}