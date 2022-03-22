import 'package:flutter/material.dart';

import '../constants.dart';

class ProductDescription extends StatelessWidget {
  final String? description;
  final String? title;
  final bool isFavorite;
  final GestureTapCallback press;

  const ProductDescription({
    Key? key,
    required this.description,
    required this.press,
    this.isFavorite = false,
    required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
          child: Text(title!, style: Theme.of(context).textTheme.headline6,),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(_size.size.width * (15 / 375.0)),
            width: _size.size.width * (64 / 375.0),
            decoration: BoxDecoration(
              color: isFavorite ? const Color(0xFFFFE6E6) : const Color(0xFFF5F6F9),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: isFavorite ? const Icon(Icons.favorite) :const Icon(Icons.favorite_border),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: _size.size.width * (20 / 375.0),
            right: _size.size.width * (64 / 375.0),
          ),
          child: Text( description!,  maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _size.size.width * (20 / 375.0),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
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
