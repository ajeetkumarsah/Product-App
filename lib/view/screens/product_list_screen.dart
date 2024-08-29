// presentation/screens/product_list_screen.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/utils/app_colors.dart';
import 'package:product_app/utils/png_files.dart';
import 'package:product_app/view/screens/liked_item_screen.dart';
import 'package:product_app/view/screens/product_details_screen.dart';
import 'package:product_app/view/widgets/product_list_item.dart';
import 'package:product_app/view/widgets/title_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    _scrollController.addListener(_onScroll);
    context.read<ProductBloc>().add(FetchProducts(0, limit: 20));
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = context.read<ProductBloc>().state;
      if (state is ProductLoaded && state.hasMoreProducts && !_isLoadingMore) {
        setState(() {
          _isLoadingMore = true;
        });

        // Calculate the next offset
        final nextOffset = state.products.length;

        context.read<ProductBloc>().add(FetchProducts(nextOffset, limit: 20));
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Text('Products'),
        actions: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.heart),
                    onPressed: () {
                      // Navigate to the liked items page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LikedItemsScreen(),
                        ),
                      );
                    },
                  ),
                  if (state is ProductLoaded && state.likedProducts.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${state.likedProducts.length}',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            final filteredProducts = state.products
                .where((product) =>
                    product.name?.toLowerCase().contains(_searchQuery) ?? false)
                .toList();
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 6),
                    child: Text(
                      'We make online \nSelling superbly easy.',
                      style: GoogleFonts.acme(
                        fontSize: 22,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            // height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.lightGrey,
                            ),
                            child: CupertinoTextFormFieldRow(
                              placeholder: 'Search',
                              controller: _searchController,
                              prefix: const Icon(
                                CupertinoIcons.search,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.lightGrey,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            PngFiles.filter,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TitleWidget(title: 'Top Products', viewAll: true),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      children: [
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            child: Text(
                              'Found \n${state.products.length} Results',
                              style: GoogleFonts.actor(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ...filteredProducts.map(
                          (product) => StaggeredGridTile.count(
                            crossAxisCellCount: 2,
                            mainAxisCellCount: 3,
                            child: ProductListItem(
                              product: product,
                              tag: '${product.id}',
                              onProductTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value:
                                          BlocProvider.of<ProductBloc>(context),
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No Products'));
        },
      ),
    );
  }
}
