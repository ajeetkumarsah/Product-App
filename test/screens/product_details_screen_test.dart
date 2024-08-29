import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/view/screens/product_details_screen.dart';
import 'package:product_app/data/models/product_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_state.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;
  final product = ProductModel(
    id: 1,
    name: 'Product 1',
    price: ' 10.0',
    imageUrl: 'http://example.com/image.png',
    description: '',
  );

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  testWidgets('renders ProductDetailsScreen with product details',
      (tester) async {
    when(() => mockProductBloc.state)
        .thenReturn(ProductLoaded([product], true));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProductBloc,
          child: ProductDetailsScreen(
            product: product,
            tag: '1',
          ),
        ),
      ),
    );

    expect(find.text('Product 1'), findsOneWidget);
    expect(find.text('\$10.0'), findsOneWidget);
  });
}
