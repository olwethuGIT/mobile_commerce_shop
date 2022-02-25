import 'package:flutter/material.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget{
  static const routeName = '/product-detail';
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 10,),
            Text(
              '${loadedProducts.price}',
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProducts.description,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      )
    );
  }

}