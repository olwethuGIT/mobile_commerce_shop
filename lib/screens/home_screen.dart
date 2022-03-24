import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './splash_screen.dart';
import '../widgets/home_body.dart';
import '../providers/products.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
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
          child: SplashScreen(),
        ) : const HomeBody()
    );
  }
}

