import 'package:construction_budget_estimation_system/constants/text_constants.dart';
import 'package:construction_budget_estimation_system/models/user_model.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:construction_budget_estimation_system/services/type_convertor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../../controllers/auth_controller.dart';


class SignupController extends GetxController{

  final RxInt _radioValue=1.obs;
  final List<String> userTypes=[vendor,landOwner,builder,];
  int get radioValue=>_radioValue.value;
  set radioValue(int val)=>_radioValue.value=val;
  RxBool isLoading=false.obs;

  final registerKey=GlobalKey<FormState>();

  late final TextEditingController emailTextEditingController;
  late final TextEditingController passwordTextEditingController;
  late final TextEditingController userNameTextEditingController;



  @override
  void onInit() {


    emailTextEditingController=TextEditingController();
    passwordTextEditingController=TextEditingController();
    userNameTextEditingController=TextEditingController();


    super.onInit();
  }


signUp() async {



try {
                              isLoading.value=true;

  
//   final UserCredential credential=await FirestoreServices().registerWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text);
// final UserModel user=UserModel(userName: userNameTextEditingController.text,email: emailTextEditingController.text);

// await FirestoreServices().addUserToFirestore(user,credential.user!.uid).catchError((error){
//                               isLoading.value=false;



// Text(error.toString());
// });
//                               isLoading.value=false;

  
} 
on FirebaseAuthException catch (e) {

                              isLoading.value=false;

  if (e.code == 'weak-password') {

      return showErrorDialogue("weak password");
  } else if (e.code == 'email-already-in-use') {

      return showErrorDialogue("Email already exists");

   

   
  }
  else{

      return showErrorDialogue(e.code);

  }
} catch (e) {
        return showErrorDialogue(e.toString());

}



  }

    showErrorDialogue(String error) async {


    return await Get.defaultDialog(
onCancel: (){},
      barrierDismissible: false,
      
      radius: 5.0,
      content: Text(error),
      title: "Error ❎");
  }
addUserFirestore(SignedIn signedInUser){

  final user = AppUser( userEmail: signedInUser.user!.email!,userType: userTypes[radioValue]);
FirestoreServices().register(user,Get.find<AppAuthController>().firebaseUser.value!.uid);


}
}