import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart/Data/product_data.dart';
import 'package:shoping_cart/Models/product.dart';
import 'package:shoping_cart/Pages/product_cart_page.dart';
import 'package:shoping_cart/Pages/product_fave_page.dart';
import 'package:shoping_cart/Provider/cart_provider.dart';
import 'package:shoping_cart/Provider/fave_provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shoping Items",
          style: TextStyle(
            fontSize: 30,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductFavePage()));
            },
            child: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProductCartPage()));
            },
            child: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            color: Colors.amberAccent,
            child: Consumer2<CartProvider, FavoProvider>(
              builder: (BuildContext context, CartProvider cartProvider,
                  FavoProvider favoProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : "0",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey),
                      ),
                    ],
                  ),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          favoProvider.toggleFavorites(product.id);
                        },
                        icon: Icon(
                          favoProvider.isFavorites(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoProvider.isFavorites(product.id)
                              ? Colors.pinkAccent
                              : Colors.grey,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.addItems(
                            product.id,
                            product.price,
                            product.title,
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepOrange
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
