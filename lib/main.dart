import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/model/catalog_model.dart';
import 'package:provider_pattern/provider/cart_model.dart';
import 'package:provider_pattern/provider/data_model.dart';
import 'package:provider_pattern/screens/catalog_screen.dart';
import 'package:provider_pattern/screens/home_screen.dart';
import 'package:provider_pattern/screens/my_cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
        ChangeNotifierProvider(create: (context) => DataModel())
      ],
      child: MaterialApp(
        title: 'Provider App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/catalog',
        routes: {
          '/catalog': (context) => const CatalogScreen(),
          '/cart': (context) => const MyCartScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
