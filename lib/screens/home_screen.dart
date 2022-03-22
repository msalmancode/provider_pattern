import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_pattern/provider/data_model.dart';
import 'package:provider_pattern/widgets/confirm_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late var providerData;

  @override
  Widget build(BuildContext context) {
    providerData = context.watch<DataModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider'),
        actions: [
          IconButton(
            onPressed: () => {deleteAllButton()},
            icon: Icon(Icons.delete),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          providerData.add('Mac Book ${providerData.items.length + 1}');
        },
        child: Icon(Icons.add),
      ),
      body: providerData.items.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.hourglass_empty),
                  SizedBox(height: 5.0),
                  Text('No data found'),
                ],
              ),
            )
          : Container(
              margin: EdgeInsets.all(16.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: providerData.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Icon(Icons.account_circle_sharp),
                    title: Text('${providerData.items[index]}'),
                    trailing: IconButton(
                        onPressed: () => providerData.removeByIndex(index),
                        icon: Icon(Icons.delete_forever)),
                  );
                },
              ),
            ),
    );
  }

  void deleteAllButton() {
    providerData.items.length == 0
        ? showSnackBar()
        : showDialog(
            context: context,
            builder: (ctx) => ConfirmDialog(
                  onConfirm: () => {providerData.removeAll()},
                ));
  }

  showSnackBar() {
    final snackBar = SnackBar(
      content: const Text('No Item'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
