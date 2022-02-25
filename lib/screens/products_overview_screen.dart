import 'package:flutter/material.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';
import '../models/filter_options.dart';
import '../widgets/badge.dart';
import './cart_screen.dart';
import '../widgets/app_drawer.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreen createState() => _ProductsOverviewScreen();
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.favorites) {
                    _showOnlyFavourites = true;
                  } else {
                    _showOnlyFavourites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem( child: Text('Only favourites'), value: FilterOptions.favorites),
                const PopupMenuItem( child: Text('Show All'), value: FilterOptions.all)
              ]
          ),
          Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString()
              ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductsGrid(showFavorites: _showOnlyFavourites),
    );
  }
}

