import 'dart:math';

import 'package:flutter/material.dart';
import '../models/order_item.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}
class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text('R ${widget.order.amount}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: _expanded ? const Icon(Icons.expand_less) : const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),

          _expanded ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.order.products.length * 20.0 + 15, 180),
            child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.order.products[i].title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      '${widget.order.products[i].quantity}x R ${widget.order.products[i].price}',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey
                      ),
                    )
                  ],
                )
            ),
          ) : Container()
        ],
      ),
    );
  }
}
