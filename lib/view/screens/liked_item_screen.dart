import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/view/screens/product_details_screen.dart';
import 'package:product_app/view/widgets/liked_list_item.dart';

class LikedItemsScreen extends StatelessWidget {
  const LikedItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liked Items'),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded && state.likedProducts.isNotEmpty) {
            return ListView.builder(
              itemCount: state.likedProducts.length,
              itemBuilder: (context, index) {
                final product = state.likedProducts[index];
                return LikedItem(
                  item: product,
                  onItemTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: BlocProvider.of<ProductBloc>(context),
                          child: ProductDetailsScreen(
                            product: product,
                            tag: '${product.id}',
                          ),
                        ),
                      ),
                    );
                  },
                  onLikeTap: () {
                    context
                        .read<ProductBloc>()
                        .add(ToggleFavoriteStatus(product.id));
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No liked items yet.'),
            );
          }
        },
      ),
    );
  }
}
