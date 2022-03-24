import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/providers/auth.dart';
import 'package:mobile_commerce_shop/providers/product.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class ProductDescription extends StatefulWidget {
  final Product product;

  const ProductDescription({
    Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    final scaffold = ScaffoldMessenger.of(context);
    final authData = Provider.of<Auth>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
          child: Text(widget.product.title, style: Theme.of(context).textTheme.headline6,),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(_size.size.width * (15 / 375.0)),
            width: _size.size.width * (64 / 375.0),
            height: _size.size.width * (55 / 375.0),
            decoration: const BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: IconButton(
              icon: Icon(widget.product.isFavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () async {
                try {
                  final favoriteStatus = widget.product.isFavourite;
                  await widget.product.toggleFavouriteStatus(authData.token, authData.userId);
                  setState(() {
                    widget.product.isFavourite;
                  });

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
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: _size.size.width * (20 / 375.0),
            right: _size.size.width * (64 / 375.0),
          ),
          child: Text( widget.product.description,  maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _size.size.width * (20 / 375.0),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {
              print("See more is clicked!!");
            },
            child: Row(
              children: const <Widget>[
                Text( "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: kPrimaryColor),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
