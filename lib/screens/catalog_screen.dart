import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/model/catalog_model.dart';
import 'package:provider_pattern/provider/cart_model.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalog', style: Theme.of(context).textTheme.headline5),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ],
      ),
      body: _MyListItem(),
    );
  }
}

class _MyListItem extends StatelessWidget {
  const _MyListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = context.select<CatalogModel, List<Item>>(
      (catalog) => catalog.getItemsList(),
    );
    // var items = context.watch<CatalogModel>().getItemsList();

    var textTheme = Theme.of(context).textTheme.headline6;

    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LimitedBox(
            maxHeight: 48,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: items[index].color,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(items[index].name, style: textTheme),
                ),
                const SizedBox(width: 24),
                _AddButton(item: items[index]),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isInCart = context.select<CartModel, bool>(
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? () {
              var cart = context.read<CartModel>();
              cart.remove(item);
            }
          : () {
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null;
        }),
      ),
      child: isInCart
          ? const Icon(
              Icons.check,
              semanticLabel: 'ADDED',
            )
          : const Text('ADD'),
    );
  }
}
