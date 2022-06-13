
import '../constants/firestore_constants.dart';
import 'item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Proposal{
late final String id;

//submittedBy
late String proposalUserId;
late double area;
late DateTime? dateAdded;
late List<Item> items;
late double estimatedCost;



  Proposal({required this.proposalUserId,
  required this.area,
  
  required,required this.items,required this.estimatedCost});


  Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.proposalUserId:proposalUserId,
    FirestoreConstants.dateAdded:Timestamp.fromDate(DateTime.now()),
    FirestoreConstants.items:items.map((itm) =>itm.toMap() ).toList(),


    FirestoreConstants.extimatedCost:estimatedCost,
    FirestoreConstants.area:estimatedCost





  

    };
  }


  
   Proposal.fromMap( Map<String, dynamic>  data,itemId) {

     id=itemId;

// userName
//       =(DateTime.fromMicrosecondsSinceEpoch(data[FirestoreConstants.dateFinished].microsecondsSinceEpoch));
 
 
 
 
  // usena=convertPosition(data[FirestoreConstants.position])!;

  proposalUserId=data[FirestoreConstants.proposalUserId];

  dateAdded=DateTime.fromMicrosecondsSinceEpoch(data[FirestoreConstants.dateAdded].microsecondsSinceEpoch);
  
  
  if (data[FirestoreConstants.items] != null) {
      items = [];

      data[FirestoreConstants.items].forEach(( item) {
        items.add(Item.fromMap(item,item['id']));
      });
    }
  
  estimatedCost=data[FirestoreConstants.extimatedCost];
  area=data[FirestoreConstants.area];



  }

}
