import 'package:data_demo/data/dbHelper.dart';
import 'package:flutter/material.dart';

import '../models/product,.dart';


enum Options { delete, update }

class ProductDetail extends StatefulWidget {
  final Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

class _ProductDetailState extends State<ProductDetail> {
  late Product _currentProduct;
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  bool isEditable = false;

  _ProductDetailState(Product product) {
    _currentProduct = product;
    txtName.text = _currentProduct.name;
    txtDescription.text = _currentProduct.description;
    txtUnitPrice.text = _currentProduct.unitPrice.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product detail: ${_currentProduct.name}"),
        actions: [
          PopupMenuButton<Options>(
            onSelected: selectProcess,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                value: Options.delete,
                child: Text("Delete"),
              ),
              PopupMenuItem<Options>(
                value: Options.update,
                child: Text("Update now"),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: isEditable ? saveProduct : null,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameField(),
            buildDescriptionField(),
            buildUnitPriceField(),
          ],
        ),
      ),
    );
  }

  Widget buildNameField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product name",
      ),
      controller: txtName,
      enabled: isEditable,
    );
  }

  Widget buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Product description",
      ),
      controller: txtDescription,
      enabled: isEditable,
    );
  }

  Widget buildUnitPriceField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Unit price",
      ),
      controller: txtUnitPrice,
      enabled: isEditable,
    );
  }

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(_currentProduct.id!);
        Navigator.pop(context, true);
        break;
      case Options.update:
        setState(() {
          isEditable = true;
        });
        break;
      default:
    }
  }

  void saveProduct() async {
    _currentProduct.name = txtName.text;
    _currentProduct.description = txtDescription.text;
    _currentProduct.unitPrice = double.parse(txtUnitPrice.text);

    await dbHelper.update(_currentProduct);

    setState(() {
      isEditable = false;
      Navigator.pop(context);
    });
  }
}
