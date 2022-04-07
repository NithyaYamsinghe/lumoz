import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/wishlist_screen.dart';
import '../controllers/wishlist_controller.dart';
import '../models/wishlist.dart';
import 'update_wishlist_items_screen.dart';

class WishlistDetailScreen extends StatefulWidget {
  final Wishlist wishlist;
  const WishlistDetailScreen(
      this.wishlist, {
        Key? key,
      }) : super(key: key);

  @override
  State<WishlistDetailScreen> createState() {
    return _WishlistDetailScreenState();
  }
}

class _WishlistDetailScreenState extends State<WishlistDetailScreen> {
  final WishlistController _wishlistController = Get.put(WishlistController());

  @override
  void initState() {
    super.initState();
    _wishlistController.getWishlist();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Tv Series Details"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Tv Series Wish List',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                const Text(
                    "Tv Series Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(widget.wishlist.name.toString()),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                const Text(
                  "Episode Count",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(widget.wishlist.episodeCount.toString()),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                const Text(
                  "Tv Chanel",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(widget.wishlist.tvChanel.toString()),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                Text(widget.wishlist.description.toString()),
                const SizedBox(
                  height: 20.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextButton.icon(
                        icon: const Icon(Icons.edit,
                                color: Colors.white
                            ), // Your icon here
                            label: const Text(
                              "Edit",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              textStyle:  MaterialStateProperty.all(TextStyle(fontSize: 20)),
                            ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateWishlistItemsScreen(widget.wishlist)));
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3,right: 3),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        icon: const Icon(Icons.delete,
                            color: Colors.white
                        ), // Your icon here
                        label: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          textStyle:  MaterialStateProperty.all(TextStyle(fontSize: 20)),
                        ),
                        onPressed: () {
                          showDialog(context: context, builder:(BuildContext context){
                            return AlertDialog(
                              title: Text("Confirm"),
                              content: Text("Are you sure?"),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text("Ok"),
                                    onPressed: () {
                                      var wishlist = new Wishlist();
                                      // var db = WishlistController();
                                      _wishlistController.deleteWishlist(widget.wishlist);
                                      // Get.back();
                                     // await db.deleteWishlist(wishlist);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context)=>WishlistScreen()));
                                  },
                                ),
                                FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3,right: 3),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        icon: const Icon(Icons.cancel,
                            color: Colors.white
                        ), // Your icon here
                        label: const Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                          textStyle:  MaterialStateProperty.all(TextStyle(fontSize: 20)),
                        ),
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>WishlistScreen()));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}