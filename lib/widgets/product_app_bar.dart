import 'package:flutter/material.dart';

import '../constants.dart';

class ProductAppBar extends StatelessWidget {
  final double rating;
  const ProductAppBar({Key? key, required this.rating}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _size.size.width * (20 / 375.0)),
          child: Row(
            children: <Widget>[
              SizedBox(
                height: _size.size.width * (40 / 375.0),
                width: _size.size.width * (40 / 375.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    primary: Colors.black,
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Text(
                      "$rating",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.star, color: kPrimaryColor,),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
