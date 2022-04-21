import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/shop_home/data/models/product_data.dart';
import 'package:shop_demo/features/shop_home/presentation/bloc/product_bloc/shop_home_bloc.dart';
import 'package:shop_demo/features/shop_home/presentation/widgets/category_list_view.dart';
import 'package:shop_demo/features/shop_home/presentation/widgets/product_grid_view.dart';
import 'package:shop_demo/features/shop_home/presentation/widgets/shop_home_shimmer_view.dart';
import 'package:shop_demo/providers.dart';

import '../../domain/entities/user.dart';

class ShopHomePage extends ConsumerWidget {
  Map<String, dynamic> parameters;
  ShopHomePage({Key? key, required this.parameters}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<ShopHomeBloc, ShopHomeState>(
        bloc: ref.watch<ShopHomeBloc>(productBloc)
          ..add(fetchProductEvent(parameters)),
        builder: (context, state) {
          if (state is ShopHomeFinish) {
            final user = state.data['user'] as User;
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(child: Text(user.name.firstName)),
                  ]),
              body: ListView(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                    child: StatefulBuilder(builder: (context, viewState) {
                      return CategoryListView(
                          categories: state.data['category'] ?? <String>[],
                          selected: parameters['category'] ?? "",
                          onTap: (value) {
                            parameters['category'] = value;
                            viewState(() => parameters['category']);
                            parameters['getAll'] = false;
                            ref
                                .read<ShopHomeBloc>(productBloc)
                                .add(fetchProductEvent(parameters));
                          });
                    }),
                  ),
                  const SizedBox(height: 16.0),
                  ProductGridView(
                    products: state.data['products'] ?? <ProductData>[],
                  )
                ],
              ),
              drawer: Container(),
            );
          }
          return const ShopHomeShimmerView();
        });
  }
}
