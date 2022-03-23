import 'package:flutter/material.dart';
import '../providers/auth.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    final productList = Provider.of<Products>(context).items;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
          child: Text("Special for you", style: TextStyle(fontSize: _size.size.width * (18 / 375.0), color: Colors.black),),
        ),
        SizedBox(height: _size.size.width * (20 / 375.0)),
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                    value: productList[i],
                    child: const SpecialOfferCard(),
                  ),
                ),
              )
            ]
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {

  const SpecialOfferCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    //final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Padding(
        padding: EdgeInsets.only(left: _size.size.width * (20 / 375.0)),
        child: Consumer<Product>(
          builder: (ctx, product, _) => GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName, arguments: product.id);
            },
            child: SizedBox(
              width: _size.size.width * (242 / 375.0),
              height: _size.size.width * (100 / 375.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: <Widget>[
                    Image.network(
                        product.photos[0].url,
                        fit: BoxFit.cover
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF343434).withOpacity(0.4),
                              const Color(0xFF343434).withOpacity(0.15),
                            ]
                        )
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: _size.size.width * (15.0 / 375.0),
                          vertical: _size.size.width * (10 / 375.0)
                        ),
                        child: Text.rich(
                          TextSpan(
                            style: const TextStyle(color: Colors.white),
                            children: [
                              TextSpan(
                                text: product.title,
                                style: TextStyle(
                                  fontSize: _size.size.width * (18 / 375.0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]
                          )
                        ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
