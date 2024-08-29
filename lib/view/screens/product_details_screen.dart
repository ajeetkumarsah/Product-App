// presentation/screens/product_details_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/data/models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  final String tag;

  const ProductDetailsScreen(
      {super.key, required this.product, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Details',
          style: GoogleFonts.acme(),
        ),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              final isLiked = state is ProductLoaded &&
                  state.likedProducts.any((p) => p.id == product.id);
              return IconButton(
                icon: Icon(
                  isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: isLiked ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  context
                      .read<ProductBloc>()
                      .add(ToggleFavoriteStatus(product.id));
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(tag: tag, child: Image.network(product.imageUrl ?? '')),
              const SizedBox(height: 16.0),
              Text(
                product.name ?? '',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text('\$${product.price}',
                  style: const TextStyle(fontSize: 20, color: Colors.green)),
              const SizedBox(height: 16.0),
              Text(product.description ?? ''),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
