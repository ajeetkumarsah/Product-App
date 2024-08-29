import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/bloc/product_bloc.dart';
import 'package:product_app/bloc/product_event.dart';
import 'package:product_app/data/api/api_service.dart';
import 'package:product_app/data/repositories/product_repository.dart';
import 'package:product_app/view/screens/product_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(
            productRepository: ProductRepository(apiService: ApiService()),
          )..add(FetchProducts(0, limit: 20)),
        ),
      ],
      child: MaterialApp(
        title: 'Product App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ProductListScreen(),
        },
      ),
    );
  }
}
