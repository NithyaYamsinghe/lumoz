import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumoz/ui/add_comment_screen.dart';
import 'package:lumoz/ui/theme.dart';
import 'package:lumoz/ui/widgets/comment_tile.dart';
import 'package:lumoz/ui/widgets/main_button.dart';
import '../controllers/comment_controller.dart';
import '../models/tv_show.dart';
import 'package:lumoz/models/comment.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CommentScreen extends StatefulWidget {
  final TvShow tvShow;
  const CommentScreen({Key? key, required this.tvShow}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final CommentController _commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    _commentController.getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children:[
          _addCommentBar(),
          SizedBox(height: 10,),
          _showComments()
        ],
      ),
    );
  }

  _showComments(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
            itemCount: _commentController.commentList.length,
            itemBuilder: (_, index){
              Comment comment = _commentController.commentList[index];
              print(comment.toJson());
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomOptions(context, comment);
                            },
                            child: CommentTile(comment),
                          )
                        ],
                      ),
                    ),
                  ));
            });
      }),
    );
  }

  _showBottomOptions(BuildContext context, Comment comment){
    Get.bottomSheet(
        Container(
          padding: const EdgeInsets.only(top: 4),
          height:  MediaQuery.of(context).size.height*0.45,
          color: Get.isDarkMode?blackColor:Colors.white,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode?Colors.grey[600]:Colors.grey[300]
                ),
              ),
              const Spacer(),
              _bottomOptionsButton(
                  buttonLabel: "Delete Comment",
                  onTap: (){
                    _commentController.deleteComment(comment);
                    Get.back();
                  },
                  color: Colors.red[300]!,
                  context:context
              ),
              const SizedBox(
                height: 10,
              ),
              _bottomOptionsButton(
                  buttonLabel: "Update Comment",
                  onTap: (){
                    // Get.to(()=>AddCommentScreen(tvShow: tvShow,));
                  },
                  color: greyColor,
                  isClosed: true,
                  context:context
              ),
              const SizedBox(
                height: 10,
              ),
              _bottomOptionsButton(
                  buttonLabel: "Close",
                  onTap: (){
                    Get.back();
                  },
                  color: Colors.white,
                  isClosed: true,
                  context:context
              ),
              const SizedBox(
                height: 20,
              ),

            ],
          ),
        )
    );
  }

  _bottomOptionsButton({
    required String buttonLabel,
    required Function()? onTap,
    required Color color,
    bool isClosed=false,
    required BuildContext context

  }){

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width:MediaQuery.of(context).size.width*0.9,
        decoration: BoxDecoration(
          border: Border.all(width: 2,
              color: isClosed==true? Get.isDarkMode?Colors.grey[600]!: Colors.grey[300]!:color),
          borderRadius: BorderRadius.circular(20),
          color: isClosed==true? Colors.transparent:color,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: isClosed?inputLabelStyles:inputLabelStyles.copyWith(color: Colors.white),
          ),
        ),
      ),

    );
  }

  _addCommentBar(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Lumoz", style: headingStyles,)
              ],
            ),
          ),
          MainButton(label: "Add New Comment", onTap: () async {
            await Get.to(() => AddCommentScreen(tvShow: widget.tvShow ));
            _commentController.getComments();
          })
        ],
      ),
    );
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap:(){
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios_new_outlined,
            size: 20,
            color: Get.isDarkMode? Colors.white : Colors.black),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage(
              "images/profile.jpg"
          ),
        ),
        SizedBox(width: 20,)
      ],
    );
  }
}
