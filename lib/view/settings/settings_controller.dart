
  
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingsController extends GetxController{


  final _isDark=false.obs;

  set isDark(bool val)=>_isDark.value=val;
  bool get isDark=>_isDark.value;

  changeTheme(){

     _isDark.toggle();
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      
    } else {
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  


}