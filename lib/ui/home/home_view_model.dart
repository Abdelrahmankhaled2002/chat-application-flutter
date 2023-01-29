import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/model/room.dart';

class HomeViewModel extends BaseViewModel{
  List<Room>rooms=[];
  void getRooms() async {
    rooms =await DatabaseUtils.getRoomsFromFireStore();
  }

}