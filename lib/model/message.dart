class Message{
  static const String collectionName='messages';
  String id;
  String roomId;
  String content;
  int dateTime;
  String senderId;
  String senderName;
  Message({this.id='',
  required this.roomId,
    required this.content,
    required this.dateTime,
    required this.senderId,
    required this.senderName,
  });
  Message.fromFireStore(Map<String,dynamic>json):
        this(
    id: json['id'] as String,
    roomId:  json['roomId'],
    content :json['content'],
    dateTime: json['dateTime'],
    senderId: json['senderId'],
    senderName: json['senderName'],
  );
  Map<String,dynamic>toFireStore(){
    return{
      'id': id,
      'roomId': roomId,
      'content' :content,
      'dateTime': dateTime,
     'senderId': senderId,
      'senderName': senderName,
    };
  }
}