import 'package:construction_budget_estimation_system/services/firestore_services.dart';

import '../constants/firestore_constants.dart';

class Item{
late  String? id;

bool isSelected=false;
late String userId;
   late String itemName;
   late String itemPrice;


  Item({ required this.itemName,required this.itemPrice,required this.userId, this.id});


  Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.itemName:itemName,
    FirestoreConstants.itemPrice:itemPrice,
    FirestoreConstants.userId:userId,
'id':id,



  

    };
  }


  
   Item.fromMap( Map<String, dynamic>  data,itemId) {

     id=itemId;

// userName
//       =(DateTime.fromMicrosecondsSinceEpoch(data[FirestoreConstants.dateFinished].microsecondsSinceEpoch));
 
 
 
 
  // usena=convertPosition(data[FirestoreConstants.position])!;

  itemName=data[FirestoreConstants.itemName];

  itemPrice=data[FirestoreConstants.itemPrice];
  userId=data[FirestoreConstants.userId];


  }

}

enum UserType {vendor,landOwner,builder}