import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bootpay/model/item.dart';
import 'package:delivery/pages/address/AddressChange.dart';

class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Item newItem = Item();
            newItem.name = "새 아이템";
            newItem.qty = 2;
            newItem.id = "NEW_ITEM_CODE";
            newItem.price = 200;

            //Provider.of<ItemListNotifier>(context, listen: false).addItem(newItem);
          },
          child: Text('Add Item'),
        ),
      ),
    );
  }
}
