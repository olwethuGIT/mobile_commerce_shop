import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../providers/product.dart';
import 'package:provider/provider.dart';
import '../screens/product_detail_screen.dart';
import '../providers/cart.dart';

class ProductItem extends StatelessWidget{
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Product>(context);
    final scaffold = ScaffoldMessenger.of(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
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
                onPressed: () async {
                  try {
                    final favoriteStatus = product.isFavourite;
                    await product.toggleFavouriteStatus(authData!.token, authData!.userId);

                    if (!favoriteStatus) {
                      scaffold.showSnackBar(const SnackBar(content: Text("Product marked as favorite."),));
                    } else {
                      scaffold.showSnackBar(const SnackBar(content: Text("Product removed from the favorites."),));
                    }
                  } catch (error) {
                    scaffold.showSnackBar(const SnackBar(content: Text("Failed to toggle the favorite status"),));
                  }
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              title: Text(product.title, textAlign: TextAlign.center,),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: const Text('Added item to cart.'),
                        duration: const Duration(seconds: 2),
                        action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(product.id);
                            }
                          ),
                      )
                  );
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
    );
  }

}