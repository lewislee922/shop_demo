import 'package:flutter/material.dart';

import '../../domain/entities/product.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  const ProductGridView({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: products
            .map((e) => Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.network(
                          e.image,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(e.title)
                    ],
                  ),
                ))
            .toList());
  }
}
