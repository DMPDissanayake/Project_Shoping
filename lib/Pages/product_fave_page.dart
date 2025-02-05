import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart/Data/product_data.dart';
import 'package:shoping_cart/Models/product.dart';
import 'package:shoping_cart/Provider/fave_provider.dart';

class ProductFavePage extends StatelessWidget {
  const ProductFavePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.deepOrange,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Product Favourote",
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<FavoProvider>(
        builder:
            (BuildContext context, FavoProvider favaProvider, Widget? child) {
          final favoItems = favaProvider.favorites.entries
              .where((test) => test.value)
              .map((toElement) => toElement.key)
              .toList();
          if (favoItems.isEmpty) {
            return Center(
              child: Text(
                "No Favorites added yet..!",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: favoItems.length,
            itemBuilder: (context, index) {
              final productId = favoItems[index];
              final Product product = ProductData()
                  .products
                  .firstWhere((product) => product.id == productId);

              return Card(
                color: Colors.amberAccent,
                child: ListTile(
                  title: Text(
                    product.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("\$${product.price}"),
                  trailing: IconButton(
                      onPressed: () {
                        favaProvider.toggleFavorites(product.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.grey,
                      )),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
