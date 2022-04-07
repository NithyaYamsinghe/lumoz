import 'package:get/get.dart';
import 'package:lumoz/models/channel.dart';
import 'package:lumoz/database/database_helper.dart';

class ChannelController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var channelList = <Channel>[].obs;

  // add new channel and save in database
  Future<int> addChannel({Channel? channel}) async {
    return await DatabaseHelper.createChannel(channel);
  }

  // get all channel from database
  void getChannels() async {
    List<Map<String, dynamic>> channels = await DatabaseHelper.queryChannel();
    channelList
        .assignAll(channels.map((data) => Channel.fromJson(data)).toList());
  }

  // delete a channel from database
  void deleteChannel(Channel channel) {
    var response = DatabaseHelper.deleteChannel(channel);
    getChannels();
    print(response);
  }

  // update channel on database
  void updateChannelRecord(Channel channel) async {
    await DatabaseHelper.updateChannelRecord(channel);
    getChannels();
  }
}
