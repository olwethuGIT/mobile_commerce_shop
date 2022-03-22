import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> categories = [
      {"icon": const Icon(Icons.bolt), "text": "Flash Deal"},
      {"icon": const Icon(Icons.beach_access), "text": "Bill"},
      {"icon": const Icon(Icons.videogame_asset), "text": "Game"},
      {"icon": const Icon(Icons.audiotrack), "text": "Daily Gift"},
      {"icon": const Icon(Icons.beach_access), "text": "More"}
    ];
    final _size = MediaQuery.of(context);
    return Padding(
        padding: EdgeInsets.all(_size.size.width * (20 / 375.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            categories.length,
            (index) => CategoryCard(icon: categories[index]["icon"], text: categories[index]["text"], press: () {})
          ),
        ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Icon? icon;
  final String? text;
  final GestureTapCallback press;

  const CategoryCard({Key? key, required this.icon, required this.text, required this.press}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context);
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: _size.size.width * (55 / 375.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(_size.size.width * (15 / 375.0)),
              height: _size.size.width * (55 / 375.0),
              width: _size.size.width * (55 / 375.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10)
              ),
              child: icon,
            ),
            const SizedBox(height: 5,),
            Text(text!, textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}

