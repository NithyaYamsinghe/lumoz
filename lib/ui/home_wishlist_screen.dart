import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/wishlist_details_screen.dart';
import '../controllers/wishlist_controller.dart';
import '../models/wishlist.dart';

class HomeWishlistScreen extends StatelessWidget {
  const HomeWishlistScreen({Key? key}) : super(key: key);

  @override
  void initState() {
    final WishlistController _wishlistController = Get.put(WishlistController());
    _wishlistController.getWishlist();
  }

  @override
  Widget build(BuildContext context) {
    var db = WishlistController();
    return Padding(
      padding: EdgeInsets.all(10),
      child: FutureBuilder<List>(
        future: db.getWishlist(),
        builder: (context, AsyncSnapshot<List> snapshot){
          if(snapshot.hasData){
            return ListView.builder(
               itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  Wishlist wishlist = Wishlist.fromJson(snapshot.data![index]);
                return Card(
                  color: Colors.white70,
                  child: ListTile(
                    title: Text(wishlist.name.toString(),
                    style: const TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                    subtitle: Text(wishlist.episodeCount.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => WishlistDetailScreen(wishlist)));
                    },
                  ),
                );
                });
           }else{
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
