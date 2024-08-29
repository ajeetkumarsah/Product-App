import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/view/screens/product_list_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/data/models/product_model.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  testWidgets('renders ProductListScreen and shows loading indicator',
      (tester) async {
    when(() => mockProductBloc.state).thenReturn(ProductLoading());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProductBloc,
          child: const ProductListScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders ProductListScreen and shows products', (tester) async {
    final product = ProductModel(
      id: 1,
      name: 'Product 1',
      price: '10.0',
      imageUrl: 'http://example.com/image.png',
      description: '',
    );

    when(() => mockProductBloc.state)
        .thenReturn(ProductLoaded([product], true));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockProductBloc,
          child: const ProductListScreen(),
        ),
      ),
    );

    expect(find.text('Product 1'), findsOneWidget);
  });
}
