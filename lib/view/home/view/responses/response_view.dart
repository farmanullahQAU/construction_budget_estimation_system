import 'package:construction_budget_estimation_system/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../../models/user_model.dart';
import '../../../../services/firestore_services.dart';
import '../../../../services/type_convertor.dart';

class ResponseView extends StatelessWidget {
  const ResponseView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreListView<NotificationModel>(
        
          shrinkWrap: true,
          query: FirestoreServices.proposalResponsesQuery,
          loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
          errorBuilder: (context, error, stackTrace) => Text(error.toString()), 
          
          
        itemBuilder: (context, snapshot) {
           NotificationModel response=snapshot.data();
        
        return Card(
          margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
          child: FutureBuilder(
      
            future: FirestoreServices.getCurrentUser(response.senderId),
            builder:(context,AsyncSnapshot<AppUser> sender){
             return ExpansionTile(
               title: Text("Date Sent"),
    
    subtitle: Text(Convertor.formatDate(response.dateSent)),
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
      Text('Sender',),
      Text("${sender.data?.userName??sender.data?.userEmail??""} ",),
      
      
      
      ],),
      // Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      
      // Text("Area"),
      // Text('${proposal.area} SM',style: titleStyle,)
      // ],)
      
          ],),
    
          SizedBox(height: 20,),
      //     Get.find<AppAuthController>().currentLoggedInuser?.value.userType==landOwner?Container():
      //              FloatingActionButton.extended(
      //   onPressed: () {
    
      //     showDetailsSheet(context,proposal);
      //   },
      //   icon: Icon(Icons.notes_sharp),
      //   label: Text("send Proposal"),
      // ),

      Text(response.proposalText)
        
        ],
      ),
    ),
    
                
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
}