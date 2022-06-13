// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../assets_path.dart';
import '../../constants/text_constants.dart';
import '../home/home_view.dart';
import 'signup_controller.dart';


class SignupView extends GetView<SignupController> {


  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Column(
                children: [
               
                  ClipPath(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    clipper: CustomClipPath(),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.8),
                          Theme.of(context).primaryColor.withOpacity(0.3),
                        ],
                      )),
                      width: Get.width,
                      height: Get.height * 0.3-10,
                      child: Center(child: _addHeadingtext()),
                    ),
                  ),
                  Expanded(
                    child: SignInScreen(
actions: [


  



   AuthStateChangeAction<SignedIn>((context, signedIn) async {
    
                   await Get.find<SignupController>().addUserFirestore(signedIn);
                  await Get.find<AppAuthController>().getCurrentUserDetails();
                   
                    Get.to(()=>HomeView());
                  }),
],
                      
                                    subtitleBuilder: (context, action) {
                                       
                                      
                                      
                                          
                                      
                                     return  Column(
                                        children: [
                                          action == AuthAction.signUp?
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: RadioButtons(),
                                          ):Container(),
                                          
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 8),
                                            child: Text(
                                              action == AuthAction.signIn
                     ? 'Welcome to CBE System! Please sign in to continue.'
                     : 'Welcome to CBE System! Please create an account to continue',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    // footerBuilder: (context, _) {
                                    //   return const Padding(
                                    //     padding: EdgeInsets.only(top: 16),
                                    //     child: Text(
                                    //       'By signing in, you agree to our terms and conditions.',
                                    //       style: TextStyle(color: Colors.grey),
                                    //     ),
                                    //   );
                                    // },
                                    sideBuilder: (context, constraints) {
                                      return Text("kkkk");
                                    },
                                    headerBuilder: (context, constraints, _) {
                                      return Image.asset(logo);
                                    },
                                    providerConfigs: [
                                    EmailProviderConfiguration(),
                                    ]
                                    ),
                  ),

                  SizedBox(height: 50,)
                
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Container(
                  //     height: 100,
                  //     child: Align(
                  //       alignment: Alignment.bottomCenter,
                  //       child: RichText(
                  //         text: TextSpan(
                  //             text: accountExistsText,
                  //             style: Theme.of(context).textTheme.subtitle1,
                  //             children: [
                  //               TextSpan(
                        
                  //                 recognizer:  TapGestureRecognizer()
                  //                   ..onTap = () => Get.to(SigninView(),binding: BindingsBuilder.put(() => LoginController())),
                  //                   text: "Login",
                  //                   style: Theme.of(context).textTheme.subtitle1
                  //                       ?.copyWith(color: Colors.blue))
                  //             ]),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _addHeadingtext() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          signup.toUpperCase(),
          style: Theme.of(Get.context!).textTheme.subtitle1?.copyWith(fontSize: 30),
        ),
        Text(signuptitle.toUpperCase()),
      ],
    );
  }


}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.2, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class RadioButtons extends GetView<SignupController> {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Card(
elevation: 0.0,
         child: SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
               for (int i = 0; i <3; i++)
            SizedBox(
              width: 200,
              height: 70,
              child: ListTile(
                title: Text(
                i==0?vendor.tr.capitalizeFirst!:i==1?landOwner.tr.capitalizeFirst!:builder.capitalizeFirst!,
                  // style: Theme.of(context).textTheme.subtitle1.copyWith(color: i == 5 ? Colors.black38 : Colors.black),
                ),
                leading: Radio(
                  value: i,
                  groupValue: controller.radioValue,
                  // activeColor: Color(0xFF6200EE),
                  onChanged : (int? value) {
                    
                      controller.radioValue = value!;
                      

                    }
                ),
              ),
            ),
               ],
             ),
         ),
       ),
    );
  }
}
   


