import 'package:get/get.dart';
import 'package:lumoz/database/database_helper.dart';
import 'package:lumoz/models/comment.dart';

class CommentController extends GetxController{
  @override
  void onReady(){
    super.onReady();
  }

  var commentList = <Comment>[].obs;

  // add new comment and save in database
  Future <int> addComment({Comment? comment}) async{
    return await DatabaseHelper.createComment(comment);
  }

  // get all comments from database
  void getComments() async{
    List <Map<String, dynamic>> comments = await DatabaseHelper.queryComments();
    commentList.assignAll(comments.map((data) => new Comment.fromJson(data)).toList());
  }

  // delete a comment from database
  void deleteComment(Comment comment){
    var response = DatabaseHelper.deleteComment(comment);
    getComments();
    print(response);
  }

  // update comment based on id on database
  void updateComment(int id, String comment) async {
    await DatabaseHelper.updateComment(id, comment);
    getComments();
  }
}