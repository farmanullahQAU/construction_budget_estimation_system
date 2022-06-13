import 'package:construction_budget_estimation_system/constants/text_constants.dart';
import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/models/proposal.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:construction_budget_estimation_system/services/type_convertor.dart';
import 'package:construction_budget_estimation_system/view/components/text_field.dart';
import 'package:construction_budget_estimation_system/view/home/view/proposals_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

import '../../../models/item_model.dart';
import '../../../models/user_model.dart';

class ViewAllProposals extends StatelessWidget {
  final controller=Get.find<ProposalViewController>();


   ViewAllProposals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
 final titleStyle= Theme.of(context).textTheme.subtitle1?.copyWith(color: Theme.of(context).primaryColor);

    return Scaffold(
      body: FirestoreListView<Proposal>(
      
        
        query: FirestoreServices.getProposalsQuery,
        loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stackTrace) => Text(error.toString()), 
        
        
      itemBuilder: (context, snapshot) {
         Proposal proposal=snapshot.data();
      
      return Card(
        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        child: FutureBuilder(
    
          future: FirestoreServices.getCurrentUser(proposal.proposalUserId),
          builder:(context,AsyncSnapshot<AppUser> user){
           return ExpansionTile(
             title: Text("Date post"),

subtitle: Text(Convertor.formatDate(proposal.dateAdded!)),
             children: [
Padding(
  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
  child:   Column(
  crossAxisAlignment: CrossAxisAlignment.end,
  
    children: [

      Divider(),
  
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
  
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
    
    children: [
  Text('Estimated cost',),
  Text("${proposal.estimatedCost} PKR",style:titleStyle),
  
  
  
  ],),
  Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  
  Text("Area"),
  Text('${proposal.area} SM',style: titleStyle,)
  ],)
  
      ],),

      SizedBox(height: 20,),
//don't show send proposal button for landownder beacuse he can't send proposal to himself
      Get.find<AppAuthController>().currentLoggedInuser?.value.userType==landOwner?Container():
               FloatingActionButton.extended(
    onPressed: () {

      showDetailsSheet(context,proposal);
    },
    icon: Icon(Icons.notes_sharp),
    label: Text("send Proposal"),
  ),
      
    ],
  ),
),

              //  ListTile(
             
              // title: Text('Estimated cost'),
              // trailing: Text('${proposal.area} SM'),
              
              // subtitle: Text("${proposal.estimatedCost} PKR",style: Theme.of(context).textTheme.headline5,),
                   
              // ),
             ],
           );
          }
        ),
      );
      
        // ...
        },
      
        
        // ...
        ),
    );
  }
  
  Future showDetailsSheet(BuildContext context,Proposal proposal) {


return Get.bottomSheet( 
                  Container(
                    height: Get.height*0.6,
                   color: Theme.of(context).cardColor,
                    child:Column(
                      children: [
                        SizedBox(height: 20,),
SizedBox(
  width: Get.width*0.7,
  child:   TxtField(
    hintTxt: "Explain your what you expect",
    onChanged: (value){

      controller.proposalText?.value=value;
    },
    
    maxLines: 10,
    controller:controller.proposalNoteController ),


  
)         ,
SizedBox(height: 10,),
SizedBox(
  
  width: Get.width*0.7,
  height: 50,
  
  child: 
  
       Obx(()=>
         ElevatedButton.icon(onPressed:
           
           
           
         (){
       


       try{

       
           controller.submittProposal(proposal);
       
       }
       catch(error)
       {
       
         controller.isSending.value=false;
         Get.snackbar("Error", error.toString(),backgroundColor: Colors.red);
       }
       
         }, icon: 
         
         
         controller.isSending.isTrue?CircularProgressIndicator():
         Icon(Icons.send), label: Text("Submitt Proposal")),
       ),
  )        
                      ],
                    )
                  ),
                  // barrierColor: Colors.red[50],
                  isDismissible: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                    // side: BorderSide(
                    //   width: 5,
                    //   color: Colors.black
                    // )
                  ),
                  enableDrag: false,
 
                );

  }
}