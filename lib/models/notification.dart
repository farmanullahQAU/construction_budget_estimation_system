
import '../constants/firestore_constants.dart';
import 'item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
late final String id;

//submittedBy
 late String proposalId;
 late String senderId;
 late String proposalText;

  late DateTime dateSent;
  //id of the person who has posted
  late String receiverId;


  NotificationModel({required this.proposalId,
  required this.dateSent,
  required this.senderId,
  
  required,required this.proposalText,required this.receiverId});


  Map<String, dynamic> toMap() {

    return {
    'proposal_id':proposalId,
    'receiver_id':receiverId,
'sender_id':senderId,
'proposal_text':proposalText,
    'date_sent':Timestamp.fromDate(DateTime.now()),








  

    };
  }


  
 NotificationModel.fromMap( Map<String, dynamic>  data,String proposalNotifId) {
id=proposalNotifId;

// userName
//       =(DateTime.fromMicrosecondsSinceEpoch(data[FirestoreConstants.dateFinished].microsecondsSinceEpoch));
  
  //  usena=convertPosition(data[FirestoreConstants.position])!;

  proposalId=data["proposal_id"];

  senderId=data["sender_id"];
  receiverId=data['receiver_id'];
  proposalText=data["proposal_text"];
  dateSent=
DateTime.fromMicrosecondsSinceEpoch(data["date_sent"].microsecondsSinceEpoch);

  }

}
