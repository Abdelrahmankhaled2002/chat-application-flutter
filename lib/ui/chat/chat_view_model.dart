import 'package:chat/base.dart';
import 'package:chat/database/database_utils.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator>{
 late Room room;
 late MyUser currentUser;
 late Stream<QuerySnapshot<Message>> messagesStream;

void sendMessage(String messageContent)async{

  if(messageContent.trim().isEmpty){
    return;
  }
  var message=Message(roomId: room.id,
      content: messageContent,
      dateTime: DateTime.now().millisecondsSinceEpoch,
      senderId: currentUser.id,
      senderName: currentUser.userName);
  try{
    var res =await DatabaseUtils.insertMessageToRoom(message);
    navigator?.clearMessageText();
  }
  catch(e){
    navigator?.showMessage(e.toString());
  }
}
void listenForRoomUpdates(){
 messagesStream= DatabaseUtils.getMessagesStream(room.id);

}
@override
  void dispose() {
    super.dispose();
  }
}

//chat navigator
abstract class ChatNavigator extends BaseNavigator{
  void clearMessageText();
}