
import 'package:construction_budget_estimation_system/view/home/area/add_area_controller.dart';
import 'package:construction_budget_estimation_system/view/home/view/proposals_view_controller.dart';
import 'package:construction_budget_estimation_system/view/signup/signup_controller.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

import 'view/home/home_controller.dart';
import 'view/settings/settings_controller.dart';


class Binder extends Bindings {

  @override
  void dependencies() {
     Get.put(SettingsController());
     Get.lazyPut(()=>SignupController());
     Get.lazyPut(()=>AddAreaViewController());

     Get.lazyPut(()=>ProposalViewController());



     Get.lazyPut(  ()=>HomeController());









  }
}
