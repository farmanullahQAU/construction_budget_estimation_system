import 'dart:async';
import 'dart:isolate';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/view/home/area/add_area_controller.dart';
import 'package:construction_budget_estimation_system/view/home/view/proposals_view_controller.dart';
import 'package:construction_budget_estimation_system/view/home/view/responses/response_view.dart';
import 'package:construction_budget_estimation_system/view/home/view/view_proposals.dart';
import 'package:construction_budget_estimation_system/view/home/widgets/add_item.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import '../../assets_path.dart';
import '../../constants/text_constants.dart';
import '../components/text_field.dart';
import 'area/add_area.dart';
import 'home_controller.dart';
import 'view/view_items.dart';
import 'widgets/app_drawer.dart';
import 'widgets/image_avatar.dart';

class HomeView extends GetView<HomeController> {

   HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtitle1TextStyle=Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold,letterSpacing: 0.8);

final subtitle2TextStyle=Theme.of(Get.context!).textTheme.subtitle2?.copyWith(letterSpacing: 0.8);

    return Scaffold(

      resizeToAvoidBottomInset: false,
        drawer: AppDrawer(),
        // key: controller.homeScaffoldKey,
        appBar: AppBar(
          title: Text(Get.find<AppAuthController>().currentLoggedInuser?.value.userEmail??""),

      
         
          elevation: 0.0,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(

        
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageAvatar(imagePath: logo),

            Text(Get.find<AppAuthController>().currentLoggedInuser?.value.userType?.capitalizeFirst??""),

    Get.find<AppAuthController>().currentLoggedInuser?.value.userType==landOwner?       _addLandOwnerView():

     Get.find<AppAuthController>().currentLoggedInuser?.value.userType==builder?
               

_addBuilderView():

_addVendorView()


              ],
            ),
          ),
        ));
  }

  Widget _addHomeCard(Widget icon, String title, String subtitle,
      {double? imageWidth, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              icon,
                Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.subtitle1),

                //this will be made dynamic
                Text(
                  subtitle,
                  style: Theme.of(Get.context!).textTheme.subtitle2,
                )
              ]),
        ),
      ),
    );
  }


//   _getHistoryFromFirestore(){

//     return Expanded(
//       child: FirestoreListView<FeedModel>(

        
//         query: FirestoreServices.history,
//   loadingBuilder: (context) => Center(child: CircularProgressIndicator()),
//   errorBuilder: (context, error, stackTrace) => Text(error.toString()), 
  
  
// itemBuilder: (BuildContext, QueryDocumentSnapshot<FeedModel> snapshot) {
   

//       return Card(
        
//         elevation: 0.0,
//         child: _builCardContents(snapshot.data()));

//     // ...
//   },

  
//   // ...
//     ));
//   }


Widget _addItemFieldsDialogue(){

  return Column(
      
      children: [
  
        TxtField(
          
          prefixIcon: Icon(Icons.carpenter),
          controller:controller.itemNameTxtEditingController! ,
          hintTxt:itemName.tr,),
        const SizedBox(height: 20,),
        TxtField(
          textInputType:TextInputType.number,
  
          prefixIcon: Icon(Icons.money),
          controller: controller.itemPriceTxtEditingController!,
          hintTxt:itemPrice.tr,),
        const SizedBox(height: 20,),
   
  
  
  
      ],
    );
}

  _addVendorView() {


    return Column(children: [

       SizedBox(
                  height: 20,
                ),

//top row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(
                              Icon(Icons.mail), "Add Item", "",
                              onTap: () {

                                Get.defaultDialog(

                                
                                  title: "Add item",
middleText: "",
                                  barrierDismissible: false,

                                  
                                  
                                  onConfirm: () async {

                                    await controller.addItemToFirestore();
                                    Get.back();

                                  },
                                  onCancel: (){

                                    controller.initFields();
                                  },
                                  actions: [SizedBox(
                                  
                                  width:Get.width*0.8,
                                  child: _addItemFieldsDialogue())]);
                              },
                                    
                                  
                                  ))),
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(
                              Icon(Icons.message), "Message", "")),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          // height: Get.width * 0.3,
                          child: _addHomeCard(
                            
                              Icon(Icons.list,size: 50,), "View", "",

                              onTap: (){

                                Get.to(()=>AllItems());
                              }
                              )),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.person,size: 50,), "Profile", "",
                              imageWidth: 40)),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.notifications,size: 50,), "Alerts", "",
                              imageWidth: 40, onTap: () async {
                          })),
                    )
                  ],
                ),
                
                SizedBox(
                  height: 20,
                ),
    ],);
  }

  _addLandOwnerView() {


    return Column(children: [

       SizedBox(
                  height: 20,
                ),

//top row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(
                              Icon(Icons.area_chart), "Add Area", "",
                              onTap: () {
Get.to(()=>AddArea(),binding:  BindingsBuilder.put(() => AddAreaViewController()),);
                             
                              },
                                    
                                  
                                  ))),
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(

                            
                              Icon(Icons.notifications_active_rounded), "Response", "",onTap: (){

                                Get.to(()=>ResponseView());
                              }),),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          // height: Get.width * 0.3,
                          child: _addHomeCard(
                            
                              Icon(Icons.list,size: 50,), "Submitted", "",

                              onTap: (){

                                                          Get.to(()=>ViewAllProposals(),binding: BindingsBuilder.put(()=>ProposalViewController()));

                              }
                              )),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.person,size: 50,), "Profile", "",
                              imageWidth: 40)),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.notifications,size: 50,), "Alerts", "",
                              imageWidth: 40, onTap: () async {
                          })),
                    )
                  ],
                ),
                
                SizedBox(
                  height: 20,
                ),
    ],);
  }
_addBuilderView() {


    return Column(children: [

       SizedBox(
                  height: 20,
                ),

//top row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(
                              Icon(Icons.notes), "Bid Proposal", "",
                              onTap: () {
                                Get.to(()=>ViewAllProposals(),binding: BindingsBuilder.put(()=>ProposalViewController()));

                             
                              },
                                    
                                  
                                  ))),
                    Flexible(
                      child: SizedBox(
                          width: Get.width * 0.5,
                          child: _addHomeCard(
                              Icon(Icons.message), "Message", "")),
                    )
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          // height: Get.width * 0.3,
                          child: _addHomeCard(
                            
                              Icon(Icons.list,size: 50,), "Proposals", "",

                              onTap: (){

                                Get.to(()=>ViewAllProposals(),binding: BindingsBuilder.put(()=>ProposalViewController()));
                              }
                              )),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.person,size: 50,), "Profile", "",
                              imageWidth: 40)),
                    ),
                    Flexible(
                      child: SizedBox(
                          width: double.infinity,
                          child: _addHomeCard(
                              Icon(Icons.notifications,size: 50,), "Alerts", "",
                              imageWidth: 40, onTap: () async {
                          })),
                    )
                  ],
                ),
                
                SizedBox(
                  height: 20,
                ),
    ],);
  }
}
