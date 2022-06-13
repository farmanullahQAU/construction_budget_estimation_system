import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/models/notification.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/proposal.dart';

class ProposalViewController extends GetxController{
  RxBool isSending=false.obs;

final proposalNoteController =TextEditingController();
RxString? proposalText="".obs;


submittProposal(Proposal prop)async{


  final proposal=NotificationModel(
    
    
    receiverId: prop.proposalUserId,
    proposalId: prop.id, dateSent: DateTime.now(), senderId: Get.find<AppAuthController>().currentLoggedInuser!.value.id, 
  
  
  
  proposalText: proposalNoteController.text);
isSending.value=true;
  await FirestoreServices().sendProposal(proposal);
  isSending.value=false;
}

}