import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/models/item_model.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {

 TextEditingController? itemPriceTxtEditingController;
 TextEditingController? itemNameTxtEditingController;


  // late final GlobalKey<ScaffoldState> _homeScaffoldKey;
  @override
  Future<void> onInit() async {

initFields();
    // _homeScaffoldKey = GlobalKey<ScaffoldState>();

    super.onInit();
  }

  // GlobalKey<ScaffoldState> get homeScaffoldKey => _homeScaffoldKey;

  // void controlHomeMenu() {
  //   if (!homeScaffoldKey.currentState!.isDrawerOpen) {
  //     homeScaffoldKey.currentState!.openDrawer();
  //   }
  // }

  initFields(){

    itemNameTxtEditingController=TextEditingController();
    itemPriceTxtEditingController=TextEditingController();

  }

  addItemToFirestore()async{
    final item=Item(
      userId:FirebaseAuth.instance.currentUser!.uid,
      
      itemName: itemNameTxtEditingController!.text, itemPrice: itemPriceTxtEditingController!.text);
 
 
 await FirestoreServices().addItem(item);
 
  }

}
