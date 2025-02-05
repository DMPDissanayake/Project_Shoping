import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_cart/Models/cart.dart';
import 'package:shoping_cart/Provider/cart_provider.dart';

class ProductCartPage extends StatelessWidget {
  const ProductCartPage({super.key});

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
          "Product Cart",
          style: TextStyle(
            fontSize: 20,
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final CartItem cartItem =
                        cartProvider.items.values.toList()[index];
                    return Card(
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(
                          cartItem.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("\$${cartItem.price}   ${cartItem.quantity}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingelItem(cartItem.id);
                              },
                              icon: Icon(
                                Icons.remove,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(cartItem.id);
                              },
                              icon: Icon(
                                Icons.remove_shopping_cart,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Text(
                  "Totale : \$${cartProvider.calculateTheTotale.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.allclean();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepOrange, // Change button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Optional: Rounded corners
                    ),
                  ),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
