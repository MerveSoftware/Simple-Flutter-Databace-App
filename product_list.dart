import 'package:data_demo/data/dbHelper.dart';
import 'package:data_demo/screens/product_add.dart';
import 'package:data_demo/screens/product_detail.dart';
import 'package:flutter/material.dart';
import '../models/product,.dart';

class ProductList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _ProductListState();
    //throw UnimplementedError();
  }
}

class _ProductListState extends State {
  var dbHelper = DbHelper();

  //Let the state on this page begin
  late List<Product>products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    // var productsFuture=dbHelper.getProducts();
    //  productsFuture.then((data){
    //  this.products=data!;
    //  });
    /*super.initState();
    The super statement is used to call and use another function of a class...
     super exdends are based on the given class *(State class)*/
  }


  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of products"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        backgroundColor: Color.fromRGBO(244, 12, 78, 1.0),
        child: Icon(
          Icons.add,//+
          color: Colors.white, // change icon colors
        ),
        tooltip: "add new product",

      ),
    );
    //  throw UnimplementedError(); dead code
  }

  ListView? buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Color.fromRGBO(255, 64, 129, 0.27058823529411763),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("P"),
              ),
              title: Text(this.products[position].name),
              subtitle: Text(this.products[position].description),
              onTap: () {
                gotoDetail(this.products[position]);
                /*Shows product details when clicked*/
              },
            ),
          );
        }
    );
  }

  void goToProductAdd() async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProductAdd()),
    );
    if (result != null && result) {
      getProducts();
    }
  }


  void getProducts() async {
    var productsFuture=dbHelper.getProducts();
    productsFuture.then((data){

      setState(() {
        this.products=data!;
        productCount=data.length;
      });
     this.products=data!;
     productCount=data.length;
    });
    super.initState();
  }

  void gotoDetail(Product product) async {
    bool reseult=await Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product)));
    if(reseult!=null){
      if(reseult==true){
        getProducts();
      }
    }
  }
}

