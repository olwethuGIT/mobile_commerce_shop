import 'package:flutter/material.dart';
import 'package:mobile_commerce_shop/constants.dart';
import 'package:mobile_commerce_shop/providers/product.dart';

class ProductImages extends StatefulWidget {
  final Product product;
  const ProductImages({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductImages> createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int _selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        SizedBox(
          width: _size.size.width * (238 / 375.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
              tag: widget.product.id.toString(),
              child: Image.network(widget.product.photos[_selectedImage].url),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ...List.generate(widget.product.photos.length, (index) => smallProductPreview(index))
          ],
        )
      ],
    );
  }

  GestureDetector smallProductPreview(int index) {
    final _size = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        height: _size.size.width * (48 / 375.0),
        width: _size.size.width * (48 / 375.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryColor.withOpacity(_selectedImage == index ? 1 : 0))
        ),
        child: Image.network(widget.product.photos[index].url),
      ),
    );
  }
}
