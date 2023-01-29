import 'package:chat/model/message.dart';
import 'package:chat/model/my_user.dart';
import 'package:chat/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils{
  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectioName).
  withConverter(fromFirestore: (snapshot,_)=>MyUser.fromJson(snapshot.data()!), toFirestore:(user,_)=>user.toJson());
}

  static CollectionReference<Room> getRoomsCollection(){
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
        fromFirestore: (snapshot, _) => Room.fomJson(snapshot.data()!),
        toFirestore: (room, _) => room.toJson());
  }

  static CollectionReference<Message>getMessagesCollection(String roomId){
    return getRoomsCollection().
    doc(roomId).
    collection(Message.collectionName).
    withConverter(
        fromFirestore: (snapshot,_)=>Message.fromFireStore(snapshot.data()!),
        toFirestore: (message,_)=>message.toFireStore()
    );
  }

  static Future<void> creatDatabaseUser(MyUser user)async{
 return getUsersCollection().
 doc(user.id).
 set(user);

}

  static Future<MyUser?> readUser(String userId)async{
     var userDocSnapshot=await getUsersCollection().doc(userId).get();
     return userDocSnapshot.data();
}

  static Future<void> createRoom(String title,String desc,String catId){
    var roomsCollection =  getRoomsCollection();
    var docRef = roomsCollection.doc();
    Room room = Room(id: docRef.id
        , title: title, desc: desc, catId: catId);
    return docRef.set(room);

  }

  static Future<List<Room>> getRoomsFromFireStore()async{
    var qSnapshot=await getRoomsCollection().get();
    return qSnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<void> insertMessageToRoom(Message message)async{
    var roomMessages=getMessagesCollection(message.roomId);
    var docRef=roomMessages.doc();
    message.id=docRef.id;
    return docRef.set(message);

  }

  static Stream <QuerySnapshot<Message>>getMessagesStream(String roomId){
    return getMessagesCollection(roomId).orderBy('dateTime').snapshots();
  }

}