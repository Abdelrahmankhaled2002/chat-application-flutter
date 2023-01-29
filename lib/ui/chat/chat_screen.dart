import 'package:chat/base.dart';
import 'package:chat/model/message.dart';
import 'package:chat/model/room.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:chat/ui/chat/chat_view_model.dart';
import 'package:chat/ui/chat/message_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  static String route_name='chat screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends BaseState<ChatScreen,ChatViewModel>implements ChatNavigator {

  @override
  ChatViewModel initViewModel() => ChatViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.navigator=this;
    print('initialized');

  }
  @override
  void clearMessageText() {
    textController.clear();
  }
  String messageContent='';
  var textController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Room room=ModalRoute.of(context)?.settings.arguments as Room;
    var userProvider=Provider.of<UserProvider>(context);
    viewModel.room=room;
   viewModel.currentUser=userProvider.user!;
    viewModel.listenForRoomUpdates();
    return ChangeNotifierProvider(
        create: (_)=>viewModel,
      child: Stack(
        children: [
          Positioned.fill(
              child: Container(
                color: Colors.white,
              )
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              child: Image.asset(
                'assets/images/background.png',
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(title: Text(room.title),centerTitle: true,backgroundColor: Colors.transparent,elevation:0),
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 12,vertical: 32),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0,3)
                    )
                  ]
              ),
              child: Column(
                children: [
                  Expanded(child:
                  StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.messagesStream,
                    builder: (_,snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: CircularProgressIndicator());
                      }
                      else if (snapshot.hasError){
                        return Center(child: Text(snapshot.error.toString()));
                      }
                      var messages=snapshot.data?.docs.map((doc) => doc.data()).toList();
                      return ListView.builder(itemBuilder: (_,index){
                        return MessageWidget(messages!.elementAt(index));
                      },
                        itemCount: messages?.length??0,
                      );
                    },
                  )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller:textController,
                          onChanged: (text){
                            messageContent=text;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(4),
                            hintText: 'Your message here',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12),
                              ),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 0.5
                              )
                            )
                          ),
                        ),
                      ),
                      SizedBox(width: 8,),
                      ElevatedButton(onPressed: (){
                        viewModel.sendMessage(messageContent);
                      },
                        child:Row(
                        children: [
                          Text('Send'),
                          SizedBox(width: 8,),
                          Icon(Icons.send)
                        ],
                      ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
