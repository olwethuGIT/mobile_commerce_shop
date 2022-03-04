import 'dart:io';

import 'package:flutter/material.dart';
import './providers/auth.dart';
import 'package:provider/provider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/orders_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_product_screen.dart';
import './screens/auth_screen.dart';

class PostHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {

 HttpOverrides.global = PostHttpOverrides();
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth()
          ),
          ChangeNotifierProvider(
            create: (ctx) => Products(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Orders(),
          ),
        ],
      child: MaterialApp(
            title: 'My Shop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Lato', colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.deepOrange)
            ),
            home: const AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserProductScreen.routeName: (ctx) => const UserProductScreen(),
              EditProductScreen.routeName: (ctx) => const EditProductScreen()
            },
      ),
    );
  }
}
