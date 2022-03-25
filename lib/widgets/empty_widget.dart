import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.remove_shopping_cart,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 12.0),
            Text(
              'No Item',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                letterSpacing: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
