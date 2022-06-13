
import 'package:construction_budget_estimation_system/constants/text_constants.dart';
import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/models/notification.dart';
import 'package:get/get.dart';

import '../constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/item_model.dart';
import '../models/proposal.dart';
import '../models/user_model.dart';
class FirestoreServices{
  static final controller=Get.find<AppAuthController>();
static final firestoreInstance=FirebaseFirestore.instance;
 Future<void> register(AppUser user,String id) async {

DocumentSnapshot documentReference=await firestoreInstance.collection(FirestoreConstants.userCollection).doc(id).get();
if(!documentReference.exists) {
  return  await firestoreInstance.collection(FirestoreConstants.userCollection).doc(id).set(user.toMap());
}
}
 Future addItem(Item item)async{




 DocumentReference documentReference=await firestoreInstance.collection(FirestoreConstants.itemsCollection).add(item.toMap());
 //needs when i add List<Item> as an object for proposal calass
 return await documentReference.update({'id':documentReference.id});
}



static Future addProposalToFirebase(Proposal proposal) async {
return await firestoreInstance.collection("proposals").add(proposal.toMap());
  
}
static final getItemQuery =

//if the current user is vendor then show only those item who has added else show all items
Get.find<AppAuthController>().currentLoggedInuser?.value.userType==vendor?



 firestoreInstance.collection(FirestoreConstants.itemsCollection).where('user_id',isEqualTo:
Get.find<AppAuthController>().firebaseUser.value?.uid

)
  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Item>(
     fromFirestore: (snapshot, _) => Item.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (model, _) => model.toMap(),
   ):
firestoreInstance.collection(FirestoreConstants.itemsCollection

)
  .withConverter<Item>(
     fromFirestore: (snapshot, _) => Item.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (model, _) => model.toMap(),
   );
    

  static Future<AppUser>  getCurrentUser(userId)async{


     return  await firestoreInstance.collection(FirestoreConstants.userCollection).doc(userId).get().then((documentSnapshot) =>  AppUser.fromMap(documentSnapshot.data() as Map<String,dynamic>, documentSnapshot.id));
    
   
    
  }
sendProposal(NotificationModel proposal)
{

  firestoreInstance.collection(FirestoreConstants.proposalNotificationCollectionName).add(proposal.toMap());
}

  static final getProposalsQuery = 
  
  
  
  firestoreInstance.collection(FirestoreConstants.proposalCollectionName)

  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<Proposal>(
     fromFirestore: (snapshot, _) => Proposal.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (model, _) => model.toMap(),
   );

  static final proposalResponsesQuery = 
  
  
  
  firestoreInstance.collection(FirestoreConstants.proposalNotificationCollectionName).where("receiver_id",isEqualTo: controller.currentLoggedInuser?.value.id)

  // .orderBy(FirestoreConstants.dateFinished, descending: true)
  .withConverter<NotificationModel>(
     fromFirestore: (snapshot, _) => NotificationModel.fromMap(snapshot.data()!,snapshot.id),
     toFirestore: (model, _) => model.toMap(),
   );




  }
  