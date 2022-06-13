


import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/view/home/view/intro_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app_theme.dart';
import 'binder.dart';
import 'firebase_options.dart';
import 'view/signup/signup_view.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    // await AndroidAlarmManager.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
Get.put(AppAuthController());
  runApp( MyApp());

}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      home:
      
      
      IntroScreen(),
   themeMode: ThemeMode.system,

    //  darkTheme: ThemeData.dark(),
//we need some custom changes in default dark theme so we use AppTheme.darkTheme
    darkTheme: AppTheme().darkTheme,
     theme: AppTheme().primaryTheme,

        title:"CBES",
        initialBinding: Binder(),


      
        
        
        
        
        );
  }
}
