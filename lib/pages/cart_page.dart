

import 'package:coffee_shop/components/cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/my_button.dart';
import '../model/coffee.dart';
import '../model/coffee_item.dart';
import 'coffee_order_page.dart';

class CartPage extends StatefulWidget {
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalQuantity = 0;
  double totalPrice = 0;

  void goToCoffeePage(Coffee coffee) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CoffeeOrderPage(coffee: coffee)));
  }

  double calculateTotalPrice(List<Coffee> coffeeList) {
    double total = 0;
    for (var coffee in coffeeList) {
      total += coffee.price * coffee.quantity;
    }
    return total;
  }

   int calculateTotalQuantity(List<Coffee> coffeeList) {
    int total = 0;
    for (var coffee in coffeeList) {
      total +=coffee.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CoffeeItem>(
      builder: (context, value, child) {
        totalQuantity = calculateTotalQuantity(value.userCart);
        totalPrice = calculateTotalPrice(value.userCart);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: Text(
                "Your Cart",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: value.userCart.length,
                itemBuilder: (context, index) {
                  Coffee eachCoffee = value.userCart[index];
                  return CartTile(
                    coffee: eachCoffee,
                    onPressed: () {
                      Provider.of<CoffeeItem>(context, listen: false).removeFromCart(eachCoffee);
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Quantity",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "${totalQuantity}",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            MyButton(
              text: 'Pay Now',
              onTap: () {},
            ),
          ],
        );
      },
    );
  }
}
