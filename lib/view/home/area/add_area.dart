import 'package:construction_budget_estimation_system/constants/text_constants.dart';
import 'package:construction_budget_estimation_system/view/components/text_field.dart';
import 'package:construction_budget_estimation_system/view/home/area/add_area_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';

import '../../../models/item_model.dart';
import '../../../models/user_model.dart';
import '../../../services/firestore_services.dart';



class AddArea extends GetView<AddAreaViewController> {
  const AddArea({Key? key}) : super(key: key);




  

  




  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      floatingActionButton: 
                  //if no item is selected the don't show the pdf button else show
      Obx(()=>
        AnimatedSwitcher(

             duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            
          child: controller.selectedItemList.isEmpty?Container():
                FloatingActionButton(onPressed: () async {
          

await controller.submittProposal();

Get.snackbar("Submitted", "Proposal uploaded successfully",backgroundColor: Theme.of(context).snackBarTheme.backgroundColor);
                  


                },child: const Icon(Icons.share),),
        ),
      ),
      
      appBar: AppBar(),
      body: SizedBox(
height: Get.height,
child: SingleChildScrollView(
  child:   Stack(

    alignment: Alignment.topCenter,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10,vertical: 50),
            child: Row(
              children: [
                
                Flexible(
                  child: TxtField(
      
                    onChanged: (w){
      
          controller.width=double.parse(w);
                    },
                    hintTxt: "width",
                    
                    textInputType: TextInputType.number,
                    controller:controller.widthTxtController )),
      
              SizedBox(width: 20,),
                Flexible(
      
                  
                  child: TxtField(
      
                    onChanged: (h){
      
controller.height=double.parse(h);

                    },
                    hintTxt: "height",
                    textInputType: TextInputType.number,
                    
                    controller:controller.heightTxtController )),
      
              ],
            ),
          ),
      
          SizedBox(height: 30,),
      
          // FloatingActionButton(
            
          //   onPressed: (){
      
          //   setState(() {
          //     width=double.parse(widthTxtController.text);
          //     height=double.parse(heightTxtController.text);
      
      
          //   });
          // }, child: Icon(Icons.calculate_rounded)),
              _drawArea(),
              _fetchAndAddItems()

              // _fetchAndAddItems(),

              // Container(
              //   height: 200,
                
              //   child: AllItems())
        ],
      ),
    
            AnimatedSwitcher(

                  duration: const Duration(milliseconds: 1500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
              child: Obx(()=>
                controller.extimatedCost.value!=0.0?
                 SizedBox(
                  key: Key("1"),
                  child: Card(color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${controller.extimatedCost.toString()} PKR"),
                  ),
                  
                  ),
                ):Container(
              
              key: Key("2"),
              ),
            )),

    ],
  ),
),

    ));
  }

  Widget _drawArea() {
    return Obx(()=>
      Container(
      
              decoration: BoxDecoration(
      
                border: Border.all(width: 3.0,color: Colors.cyan)
              ),
              width: controller.width,
              height: controller.height,
            ),
    );
  }


Widget _fetchAndAddItems(){

return FirestoreQueryBuilder<Item>(
      query: FirestoreServices.getItemQuery,
      builder: (context, snapshot, _) {
    
      return 
      
      
      
      ListView.builder(
        itemCount: snapshot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
   final item = snapshot.docs[index].data();
      controller.addToList=item;
         return 
           FutureBuilder(

             future: FirestoreServices.getCurrentUser(item.userId),
             builder:(context,AsyncSnapshot<AppUser> user){

return Obx(()=>




SizedBox(

  child:   Card(
    margin: EdgeInsets.only(top: 20),
  
  child: Container(
     padding: EdgeInsets.symmetric(vertical: 10,horizontal: 6),
    child:   Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          
          
          
          Checkbox(
           
                             
                              
                               
                                 checkColor: Colors.white,
                                 value: controller.items[index].isSelected,
                                 onChanged: (bool? value) {
                                   //select/deselect
                               item.isSelected=!item.isSelected;
                               //update the list
                               controller.items[index]=item;
                                
                               //add to list which only contains selected items
                                     controller.addToSelectedItemsList=item;
           
           
                                     controller.calculatedEstimatedCost(item);
                                 },
                               ),
          
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(itemPrice),
          
                                  Text(item.itemPrice)
                                ],
                              ), 
    SizedBox(width: 10,),
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("User"),
          
                                  Text(user.data?.userName??user.data?.userEmail??"")
                                ],
                              ),
          
                               
          
          
          ],),

           controller.items[index].isSelected?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                  color: Colors.cyan[800],
                    onPressed: (){
                
                
                  print("preeeee");
                  controller.extimatedCost.value=controller.extimatedCost.value+double.parse(item.itemPrice);
                
                    },
                  
                  
                     icon: Icon(Icons.add_circle)),
              
              //                FloatingActionButton.extended(
              //   onPressed: () {},
              //   // icon: Icon(Icons.save),
              //   label: Icon(Icons.remove),
              // ),
              
              SizedBox(width: 10,),
                  IconButton(
                    onPressed:
                  
                    //prevent negative when decrement quantity
                    controller.extimatedCost.value==double.parse(item.itemPrice)?null: (){
                  controller.extimatedCost.value=controller.extimatedCost.value-double.parse(item.itemPrice);
                
                
                
                    }, icon: Icon(Icons.remove_circle_outline,color: Colors.red,)),
                    
                ],
              ):Container(),
        ],
      ),
    ),
  ),
  
  ),
),

//     ListTile(
//       // trailing: Text(user.data?.userName??user.data?.userEmail??""),
  
//       trailing: 
    
//       controller.items[index].isSelected?
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             FloatingActionButton(
//             backgroundColor: Colors.cyan[800],
//               onPressed: (){
  
  
//     print("preeeee");
//     controller.extimatedCost.value=controller.extimatedCost.value+double.parse(item.itemPrice);
  
//               },
            
            
//                child: Icon(Icons.add)),

// //                FloatingActionButton.extended(
// //   onPressed: () {},
// //   // icon: Icon(Icons.save),
// //   label: Icon(Icons.remove),
// // ),

// SizedBox(width: 10,),
//             IconButton(
//               onPressed:
            
//               //prevent negative when decrement quantity
//               controller.extimatedCost.value==double.parse(item.itemPrice)?null: (){
//     controller.extimatedCost.value=controller.extimatedCost.value-double.parse(item.itemPrice);
  
  
  
//               }, icon: Icon(Icons.remove_circle_outline,color: Colors.red,)),
      
//           ],
//         ):null,
//       title: Text(item.itemName),
  
//       subtitle: Text(user.data?.userEmail??""),
//                    leading: Obx(()=>
//                      Checkbox(
  
                    
                     
                      
//                           checkColor: Colors.white,
//                           value: controller.items[index].isSelected,
//                           onChanged: (bool? value) {
//                             //select/deselect
//                         item.isSelected=!item.isSelected;
//                         //update the list
//                         controller.items[index]=item;
                       
//                         //add to list which only contains selected items
//                               controller.addToSelectedItemsList=item;
  
  
//                               controller.calculatedEstimatedCost(item);
//                           },
//                         ),
//                    ),
//                  ),
);
               
             }
          );

      });
      
      
      },
    );
}
}

