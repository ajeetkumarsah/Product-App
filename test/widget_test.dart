// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/data/models/product_model.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/data/repositories/product_repository.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('ProductBloc', () {
    late ProductBloc productBloc;
    late MockProductRepository mockProductRepository;

    setUp(() {
      mockProductRepository = MockProductRepository();
      productBloc = ProductBloc(productRepository: mockProductRepository);
    });

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when FetchProducts is added',
      build: () {
        when(mockProductRepository.getProducts(0, 10)).thenAnswer(
          (_) async => [
            ProductModel(
                id: 1,
                name: 'Test',
                description: 'Test',
                price: '10',
                imageUrl: '')
          ],
        );
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts(0, limit: 10)),
      expect: () => [ProductLoading(), isA<ProductLoaded>()],
    );
  });
}
