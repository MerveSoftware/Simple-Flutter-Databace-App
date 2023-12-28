import 'package:flutter/material.dart';
import '../data/dbHelper.dart';
import '../models/product,.dart';

class ProductAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductAddState();
  }
}

class ProductAddState extends State {
  var dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("new product add"),
      ),
      /*Center(
    child: Text("new product adding page"),
    //I used scaffold instead
  );*/
      body: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            buildNameFeild(),
            buildDescriptionfeild(),
            buildUnitPriceFeild(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  buildNameFeild() {
    return TextField(
      decoration: InputDecoration(labelText: "product name"),
      controller: txtName,
    );
  }

  buildDescriptionfeild() {
    return TextField(
      decoration: InputDecoration(labelText: "product decoration"),
      controller: txtDescription,
    );
  }

  buildUnitPriceFeild() {
    return TextField(
      decoration: InputDecoration(labelText: "unit price"),
      controller: txtUnitPrice,
    );
  }

  Widget buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        addProduct();
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromRGBO(244, 12, 236, 1.0),
      ),
      child: Text(
        "add",
        style: TextStyle(color: Colors.white), // Metin rengini beyaz olarak belirliyoruz
      ),
    );
  }

  void addProduct() async {
    var result = await dbHelper.insert(Product(
        txtName.text, txtDescription.text, double.parse(txtUnitPrice.text)));

    Navigator.pop(context, true);
  }
}
