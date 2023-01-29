import 'package:chat/model/message.dart';
import 'package:chat/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageWidget extends StatelessWidget {
  Message message;
  MessageWidget(this.message);
  @override
  Widget build(BuildContext context) {
    var userProvider=Provider.of<UserProvider>(context);
    return userProvider.user?.id==message.senderId?SentMessage(message):RecievedMessage(message);
  }

}

class SentMessage extends StatelessWidget {
  Message message;
  SentMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(12),
                  topLeft:Radius.circular(12),
                  bottomLeft:Radius.circular(12)
              ),
              color: Colors.blue
            ),
            child: Text(message.content,style: TextStyle(color:Colors.white)),

          ),
          Text(message.dateTime.toString()),

        ],
      ),
    );
  }
}

class RecievedMessage extends StatelessWidget {
  Message message;
  RecievedMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message.dateTime.toString()),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(12),
                    topLeft:Radius.circular(12),
                    bottomRight:Radius.circular(12)
                ),
                color: Colors.grey.shade300
            ),
            child: Text(message.content,style: TextStyle(color:Colors.black)),
          ),
          Text(message.dateTime.toString()),
        ],
      ),
    );
  }
}
