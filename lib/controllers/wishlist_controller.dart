import 'package:get/get.dart';

import '../database/database_helper.dart';
import '../models/wishlist.dart';

class WishlistController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }
  var wishlistList = <Wishlist>[].obs;
  // add new wishlist and save in database
  Future <int> addWishlist({Wishlist? wishlist}) async{
    print("HI");
    print(wishlist!.name.toString());
    return await DatabaseHelper.createWishlist(wishlist);
  }
// view wishlist from database
  Future<List> getWishlist() async{
    Future<List> wishlist = DatabaseHelper.queryWishlist();
          return wishlist;
  }
  // delete a wishlist from database
  void deleteWishlist(Wishlist wishlist){
    var response = DatabaseHelper.deleteWishlist(wishlist);
    getWishlist();
    print(response);
  }
  // update a wishlist from database
  updateWishlist(Wishlist wishlist){
    var response = DatabaseHelper.updateWishlist(wishlist);
    getWishlist();
    print(response);
  }

}