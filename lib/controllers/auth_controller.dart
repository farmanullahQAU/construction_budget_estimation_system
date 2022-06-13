import 'package:construction_budget_estimation_system/models/user_model.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:construction_budget_estimation_system/view/home/home_view.dart';
import 'package:construction_budget_estimation_system/view/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppAuthController extends GetxController {
FirebaseAuth auth = FirebaseAuth.instance;

  late Rx<User?> firebaseUser;

  
 Rx< AppUser>?
  currentLoggedInuser;
  RxBool isload = false.obs;
  RxBool isHidden = false.obs;

  RxBool isLoading = false.obs;

  

  @override
  onInit() async {
    super.onInit();

    firebaseUser =Rx<User?>(auth.currentUser);
      firebaseUser.bindStream(auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);




  }



  

  // _setInitialScreen(User? user) {
  //   if (user == null) {
  //     Get.offAll(() => SignupView());
  //   } else {
  //    Get.to(()=>HomeView());
  //   }
  // }


  void signOut() async {
    await auth.signOut();
  }
  
 Future getCurrentUserDetails() async {

final user= await FirestoreServices.getCurrentUser(firebaseUser.value?.uid);
currentLoggedInuser=user.obs;
print(user.userEmail);



  }
}
