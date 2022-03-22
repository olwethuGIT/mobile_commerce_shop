import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/widgets/home_body.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  _ProductsOverviewScreen createState() => _ProductsOverviewScreen();
}

class _ProductsOverviewScreen extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() { _isLoading = true; });
      Provider.of<Products>(context).getProducts().then((_) {
        setState(() { _isLoading = false; });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: const AppDrawer(),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : const HomeBody()
    );
  }
}

