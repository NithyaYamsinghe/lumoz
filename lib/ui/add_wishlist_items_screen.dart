import 'package:flutter/material.dart';
import 'package:lumoz/ui/wishlist_screen.dart';
import '../controllers/wishlist_controller.dart';
import '../models/wishlist.dart';

class AddWishlistItemsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  AddWishlistItemsScreenState();
  }
}
class AddWishlistItemsScreenState extends State< AddWishlistItemsScreen> {
  var textEditingControllerName = TextEditingController();
  var textEditingControllerEpisodeCount = TextEditingController();
  var textEditingControllerTvChanel = TextEditingController();
  var textEditingControllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Tv Series"),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
           
              child: Form(
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
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: textEditingControllerName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Series',
                        labelText: 'Series',
                      )
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: textEditingControllerEpisodeCount,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Episode Count',
                        labelText: 'Episode Count',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: textEditingControllerTvChanel,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Tv Channel',
                        labelText: 'Tv Channel',
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextField(
                      controller: textEditingControllerDescription,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Description',
                        labelText: 'Description',
                      ),
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextButton.icon(
                            icon: const Icon(Icons.save,
                                color: Colors.white
                            ), // Your icon here
                            label: const Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors
                                  .green),
                              textStyle: MaterialStateProperty.all(const TextStyle(
                                  fontSize: 20)),
                            ),
                            onPressed: () {
                              if(textEditingControllerName.value.text.length == 0){
                                    showDialog(context: context, builder:(BuildContext context){
                                    return AlertDialog(
                                      title: Text("Alert !!!"),
                                      content: Text("Series Name Feild Can\'t Be Empty."),
                                      actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ok"),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        ),
                                       ],
                                      );
                                     });
                                 }else {
                                var wishlist = Wishlist(
                                  name: textEditingControllerName.text,
                                  episodeCount: textEditingControllerEpisodeCount
                                      .text,
                                  tvChanel: textEditingControllerTvChanel.text,
                                  description: textEditingControllerDescription
                                      .text,
                                );
                                var db = WishlistController();
                                db.addWishlist(wishlist: wishlist);
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WishlistScreen()));
                              }
                              },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
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
                              backgroundColor: MaterialStateProperty.all(Colors
                                  .red),
                              textStyle: MaterialStateProperty.all(const TextStyle(
                                  fontSize: 20)),
                            ),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => WishlistScreen()));
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
        ),
      );
  }
}