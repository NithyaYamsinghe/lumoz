import 'package:get/get.dart';
import 'package:lumoz/models/tv_show.dart';
import 'package:lumoz/database/database_helper.dart';

class TvShowController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var tvShowList = <TvShow>[].obs;
  var selectedTvShowList = <TvShow>[].obs;

  // add new tv show and save in database
  Future<int> addTvShow({TvShow? tvShow}) async {
    return await DatabaseHelper.createTvShow(tvShow);
  }

  // get all tv shows from database
  void getTvShows() async {
    List<Map<String, dynamic>> tvShows = await DatabaseHelper.queryTvShow();
    tvShowList.assignAll(tvShows.map((data) => TvShow.fromJson(data)).toList());
  }

  // get channel specific tv shows from database
  void getSelectedTvShows(String channel) async {
    List<Map<String, dynamic>> tvShows =
        await DatabaseHelper.querySelectedTvShow(channel);
    selectedTvShowList
        .assignAll(tvShows.map((data) => TvShow.fromJson(data)).toList());
  }

  // delete a tv show from database
  void deleteTvShow(TvShow tvShow) {
    var response = DatabaseHelper.deleteTvShow(tvShow);
    getTvShows();
    print(response);
  }

  // update tv show completed status on database
  void updateTvShow(int id) async {
    await DatabaseHelper.updateTvShow(id);
    getTvShows();
  }

  // update tv show  on database
  void updateTvShowRecord(TvShow tvShow) async {
    await DatabaseHelper.updateTvShowRecord(tvShow);
    getTvShows();
  }
}
