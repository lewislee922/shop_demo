import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShopHomeShimmerView extends StatelessWidget {
  static final gradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  const ShopHomeShimmerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            Shimmer(
              gradient: gradient,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
              ),
            ),
            Shimmer(gradient: gradient, child: CircleAvatar(child: Text(""))),
          ]),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.05,
            child: Shimmer(
              gradient: gradient,
              child: StatefulBuilder(builder: (context, cateState) {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                    4,
                    (index) => Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border:
                                Border.all(color: Colors.black, width: 2.0)),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Loading".toUpperCase(),
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16.0),
          Shimmer(
            gradient: gradient,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List<Widget>.generate(
                  6,
                  (_) => Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_basket),
                            SizedBox(height: 16.0),
                            Text('loading')
                          ],
                        ),
                      )),
            ),
          )
        ],
      ),
      drawer: Container(),
    );
  }
}
