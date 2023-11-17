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
                  clipBehavior: Clip.hardEdge,
                  child: LayoutBuilder(builder: (context, constraints) {
                    final maxHeight = constraints.maxHeight;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: maxHeight * 0.5,
                            child: Image.network(
                              e.image,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          Expanded(
                              child: Text(e.title,
                                  maxLines: 3, overflow: TextOverflow.ellipsis))
                        ],
                      ),
                    );
                  }),
                ))
            .toList());
  }
}
