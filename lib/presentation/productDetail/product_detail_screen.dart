import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String price;
  final String description;
  const ProductDetailScreen(
      {super.key,
      required this.title,
      required this.price,
      required this.description,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product detail',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[600]),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                image: DecorationImage(image: NetworkImage(imageUrl))),
            width: size.width - 0.6,
            height: 250,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            '\$$price',
            style: TextStyle(color: Colors.green, fontSize: 30),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
