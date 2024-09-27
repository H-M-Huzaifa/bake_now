import 'package:bake_now/UI/Screens/Bottom_nav_bar/nav_bar.dart';
import 'package:bake_now/UI/Screens/Cart/Cart_screen.dart';
import 'package:bake_now/UI/Screens/Cart/cart_provider.dart';
import 'package:bake_now/UI/Screens/Checkout_Screen/checkout_provider.dart';
import 'package:bake_now/UI/Screens/home_screen/home_screen.dart';
import 'package:bake_now/UI/Screens/user_profile_screen/user_profile_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class checkout extends StatefulWidget {
  const checkout({super.key});

  @override
  State<checkout> createState() => _checkoutState();
}

class _checkoutState extends State<checkout> {
  bool isLoading = false; // State to track loading
  bool? isSelectedCheckbox = false; //To show Progress indicator at button
  @override
  void initState() {
    super.initState();
    final checkoutProvider = Provider.of<class_checkout_provider>(
        context, listen: false);
    final userProfileProvider = Provider.of<class_user_profile_provider>(
        context, listen: false);

    // Fetch user profile info and set it in the checkout form
    checkoutProvider.fetchDeliveryInfo(
      name: userProfileProvider.nameController.text,
      address: userProfileProvider.addressController.text,
      contact: userProfileProvider.contactController.text,
    );
  }

  @override
  Widget build(BuildContext context) {

    final checkoutProvider = Provider.of<class_checkout_provider>(context);
    final cartProvider = Provider.of<class_cart_provider>(context);

    return Scaffold(
      backgroundColor: Color(0xffFFF7DE),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {},
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => cart(),
                                ));
                          },
                          child: Icon(
                              color: Color(0xff8D3F00),
                              Icons.arrow_back_ios_new))),
                  Text(
                    "Checkout",
                    style: TextStyle(
                        fontFamily: 'Bebas',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff8D3F00)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => bottom_nav_bar(),
                          ));
                    },
                    child: Icon(
                      Icons.home,
                      color: Color(0xff8D3F00),
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),

            //Checkout Image
            Image(
              height: 300,
              width: 300,
              image: AssetImage('assets/images/checkout.png'),
            ),

            //Name
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: checkoutProvider.nameController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff8D3F00),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide:
                            BorderSide(width: 2, color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          prefixIcon: Icon(
                            Icons.drive_file_rename_outline,
                            color: Color(0xffFFC107),
                          ),
                          hintText: 'Daniel Ritchie',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Name',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),

                  //Contact number
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: checkoutProvider.addressController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff8D3F00),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide:
                            BorderSide(width: 2, color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          prefixIcon: Icon(
                            Icons.location_on,
                            color: Color(0xffFFC107),
                          ),
                          hintText: 'Anywhere North St 123',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Address',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),

                  //Phone
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      controller: checkoutProvider.contactController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xff8D3F00),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide:
                            BorderSide(width: 2, color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: Color(0xffFFC107),
                          ),
                          hintText: '0321-1234567',
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: 'Contact Number',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),

                  //Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isSelectedCheckbox,
                        onChanged: (value) async {
                          setState(() {
                            isSelectedCheckbox = value;
                          });

                          if (value == true) {
                            // Update Firestore with user info when checkbox is selected
                            User? currentUser = FirebaseAuth.instance.currentUser;
                            if (currentUser != null) {
                              String userId = currentUser.uid;
                              // Save user's profile info to Firestore for future use
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId)
                                  .update({
                                'name': checkoutProvider.nameController.text,
                                'address': checkoutProvider.addressController.text,
                                'contact': checkoutProvider.contactController.text,
                              });
                            }
                          }
                        },
                      ),
                      Text(
                        "Save this information for future",
                        style: TextStyle(color: Color(0xff8D3F00), fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            //Total
            Consumer<class_cart_provider>(builder: (context, vm, child) {
              int Delivery_Charges = 200;
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Total"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text(
                                vm.totalprice.toStringAsFixed(0) + "/-"),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text("Standard Delivery Charges"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Text("200/-",
                              style: TextStyle(fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Subtotal",
                            style: TextStyle(
                                color: Color(0xff8D3F00),
                                fontFamily: "Bebas",
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "Rs " + (vm.totalprice + Delivery_Charges)
                                .toStringAsFixed(0) + "/-",
                            style: TextStyle(
                                color: Color(0xff8D3F00),
                                fontFamily: "Bebas",
                                fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
            ),

            //Order Now
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: InkWell(
                  onTap: () async {
                    // Show a progress indicator while placing the order
                    showDialog(
                      context: context,
                      barrierDismissible: false, // Prevent user from closing the dialog
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(color: Color(0xffFFC107),),
                        );
                      },
                    );

                    // Place the order and hide the progress indicator
                    await checkoutProvider.placeOrder(
                      cartItems: cartProvider.cart_items,
                      totalPrice: cartProvider.totalprice,
                    );
                    Navigator.pop(context); // Hide the progress indicator dialog

                    cartProvider.clearCart();

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(backgroundColor: Color(0xffFFF7DE),
                          icon: Lottie.asset(
                              "assets/animations/checkout_animation.json"),
                          title: Text("Order Confirmed", style: TextStyle(fontFamily: 'Bebas', fontSize: 25),),
                          content: Text("Your order has been placed successfully.", style: TextStyle(color: Colors.grey,fontFamily: 'Bebas',fontSize: 20)),
                          actions: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => bottom_nav_bar(),));
                              },
                              child: Center(
                                child: Container(
                                  width: 200,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0xff7D7D7D),
                                        spreadRadius: -1,
                                        blurRadius: 7,
                                        offset: Offset(0, 10),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xffFFC107),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "ok",
                                      style: TextStyle(
                                        fontFamily: "Bebas",
                                        fontSize: 20,
                                        color: Color(0xff8D3F00),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff7D7D7D),
                          spreadRadius: -1,
                          blurRadius: 7,
                          offset: Offset(0, 10),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xffFFC107),
                    ),
                    child: Center(
                      child: Text(
                        "order now",
                        style: TextStyle(
                          fontFamily: "Bebas",
                          fontSize: 25,
                          color: Color(0xff8D3F00),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
