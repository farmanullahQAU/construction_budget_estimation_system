import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/view/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(Get.find<AppAuthController>().currentLoggedInuser?.value.userEmail??""),
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
Get.back();

Get.to(()=>SettingsView());
              },
            ),
            ListTile(
              title: const Text('BB'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
  }
}