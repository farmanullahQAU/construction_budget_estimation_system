import 'package:construction_budget_estimation_system/models/item_model.dart';
import 'package:construction_budget_estimation_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';

import '../../../services/firestore_services.dart';

class AllItems extends StatelessWidget {
  const AllItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Container(
    child: FirestoreListView<Item>(
    
      
      query: FirestoreServices.getItemQuery,
      loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error, stackTrace) => Text(error.toString()), 
      
      
    itemBuilder: (context, snapshot) {
       Item item=snapshot.data();
    
    return Card(
      margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
      child: FutureBuilder(

        future: FirestoreServices.getCurrentUser(item.userId),
        builder:(context,AsyncSnapshot<AppUser> user){
         return ListTile(
          leading: CircleAvatar(
            radius: 25,
            child: Text(user.data?.userEmail[0]??"",style: TextStyle(fontSize: 30),)),
          title: Text(item.itemName ),
          trailing: Text(user.data?.userEmail??""),
          
          subtitle: Text(item.itemPrice),
      
          );
        }
      ),
    );
    
      // ...
      },
    
      
      // ...
      )
    
        
      ),
    );
  }


  
}