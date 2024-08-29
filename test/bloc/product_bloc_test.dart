import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/bloc/product_state.dart';
import 'package:product_app/data/models/product_model.dart';
import 'package:product_app/data/repositories/product_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late ProductBloc productBloc;
  late MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    productBloc = ProductBloc(productRepository: mockProductRepository);
  });

  group('ProductBloc', () {
    final product = ProductModel(
      id: 1,
      name: 'Product 1',
      price: '10.0',
      imageUrl: 'http://example.com/image.png',
      description: '',
    );

    test('initial state is ProductInitial', () {
      expect(productBloc.state, equals(ProductInitial()));
    });

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoading, ProductLoaded] when FetchProducts is added',
      build: () {
        when(() => mockProductRepository.getProducts(0, 20))
            .thenAnswer((_) async => [product]);
        return productBloc;
      },
      act: (bloc) => bloc.add(FetchProducts(0, limit: 20)),
      expect: () => [
        ProductLoading(),
        ProductLoaded([product], true, likedProducts: const []),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [ProductLoaded] with updated likedProducts when ToggleFavoriteStatus is added',
      build: () {
        productBloc
            .emit(ProductLoaded([product], true, likedProducts: const []));
        return productBloc;
      },
      act: (bloc) => bloc.add(ToggleFavoriteStatus(1)),
      expect: () => [
        ProductLoaded(
          [product.copyWith(isFavorite: true)],
          true,
          likedProducts: [product.copyWith(isFavorite: true)],
        ),
      ],
    );
  });
}
