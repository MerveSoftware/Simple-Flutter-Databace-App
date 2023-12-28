import 'package:sqflite/sqlite_api.dart';

class Product {
  int? id; //id using databace
  late String name;
  late String description;
  late double unitPrice;

  Product(this.name, this.description, this.unitPrice);
  Product.withId(this.id, this.name, this.description,
      this.unitPrice); //use id for databace
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Product.fromObject(dynamic o) {
    // We converted a map into an object
    //this.id=int.tryParse(o["id"])!;
    this.id = int.parse(o['id'].toString());
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString())!;
  }
}
