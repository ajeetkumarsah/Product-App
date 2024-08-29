import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/view/widgets/product_list_item.dart';
import 'package:product_app/data/models/product_model.dart';

void main() {
  testWidgets('renders ProductListItem widget', (tester) async {
    final product = ProductModel(
      id: 1,
      name: 'Product 1',
      price: '10.0',
      imageUrl: 'http://example.com/image.png',
      description: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductListItem(
            product: product,
            tag: '1',
            onProductTap: () {},
            onLikeTap: () {},
          ),
        ),
      ),
    );

    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text('\u{20B9} 10.0'), findsOneWidget);
  });
}
