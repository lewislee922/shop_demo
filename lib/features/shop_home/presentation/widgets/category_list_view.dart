import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onTap;
  const CategoryListView(
      {Key? key,
      required this.categories,
      required this.selected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTap(categories[index]);
          },
          child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: selected == categories[index]
                      ? Colors.black
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 2.0)),
              child: FittedBox(
                  child: Text(
                categories[index].toUpperCase(),
                style: TextStyle(
                    color: selected == categories[index]
                        ? Colors.white
                        : Colors.black),
              ))),
        );
      },
    );
  }
}
