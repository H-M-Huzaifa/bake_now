import 'package:bake_now/UI/Screens/Bottom_nav_bar/nav_bar.dart';
import 'package:bake_now/UI/Screens/Product_Description_Screen/product_description.dart';
import 'package:bake_now/UI/Screens/favourites_screen/fav_provider.dart';
import 'package:bake_now/UI/Screens/favourites_screen/fav_screen.dart';
import 'package:bake_now/Utilities/colors.dart';
import 'package:bake_now/Utilities/screen_size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';  // For user ID
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class prod_cate extends StatefulWidget {
  final int index;
  final String name;

  prod_cate({
    super.key,
    required this.index,
    required this.name,
  });

  @override
  State<prod_cate> createState() => _prod_cateState();
}

class _prod_cateState extends State<prod_cate> {
  late CollectionReference itemsRef;
  String? userId;

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid; // Get current user's ID
    itemsRef = FirebaseFirestore.instance
        .collection('allitems')
        .doc(widget.name)
        .collection('items');

    if (userId != null) {
      Provider.of<class_fav_provider>(context, listen: false).fetchUserFavorites(userId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    screen_config size=screen_config(context);
    return Scaffold(
      backgroundColor: myColors.tertiary_color,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Appbar
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => bottom_nav_bar()),
                    );
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: myColors.secondary_color,
                    size: size.h*0.027,
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: 'Bebas',
                    fontSize: size.text*1.2,
                    fontWeight: FontWeight.bold,
                    color: myColors.secondary_color,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => favourite_screen()),
                    );
                  },
                  child: Icon(
                    Icons.favorite_outline,
                    color: myColors.secondary_color,
                    size: size.h*0.027,
                  ),
                ),
              ],
            ),
          ),

          // Fetching and displaying items from Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: itemsRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }

                if (snapshot.hasData) {
                  final items = snapshot.data!.docs;

                  return GridView.builder(
                    itemCount: items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index].data() as Map<String, dynamic>;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => product_description(
                                name: item['name'],
                                image: item['image_url'],
                                description: item['description'],
                                size: item['size'],
                                price: item['price'],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                          child: Container(
                            width: size.w,
                            height: size.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: myColors.textSecondary,
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Image
                                Image.network(
                                  item['image_url'],
                                  width: size.w*0.5,
                                  height: size.h*0.1,
                                  errorBuilder: (context, error, stackTrace) => Icon(Icons.error),
                                ),

                                // Name
                                Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontFamily: "Bebas",
                                    fontSize: size.text*1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['size'],
                                          style: TextStyle(
                                            fontFamily: "Bebas",
                                            color: myColors.textSecondary,
                                            fontSize: size.text*0.9,
                                          ),
                                        ),
                                        Text(
                                          "Rs ${item['price']}/-",
                                          style: TextStyle(
                                            fontSize: size.text*0.9,
                                            fontFamily: "Bebas",
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Favourite Icon
                                    Consumer<class_fav_provider>(
                                      builder: (context, vm, child) {
                                        final isFavourite = vm.favourites.any((fav) => fav['name'] == item['name']);
                                        return InkWell(
                                          onTap: () {
                                            if (userId != null) {
                                              isFavourite
                                                  ? vm.remove_fav_item(userId!, item)
                                                  : vm.add_fav_item(userId!, item);
                                            }
                                          },
                                          child: Icon(
                                            isFavourite ? Icons.favorite : Icons.favorite_outline,
                                            color: isFavourite ? Colors.red : myColors.text_primary,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text("No items available"));
              },
            ),
          ),
        ],
      ),
    );
  }
}
