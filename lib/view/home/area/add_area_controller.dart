import 'package:construction_budget_estimation_system/controllers/auth_controller.dart';
import 'package:construction_budget_estimation_system/models/proposal.dart';
import 'package:construction_budget_estimation_system/services/firestore_services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/item_model.dart';

class AddAreaViewController extends GetxController{

  

     TextEditingController widthTxtController=TextEditingController();
  TextEditingController heightTxtController=TextEditingController();

RxDouble _width=0.0.obs;
RxDouble _height=0.0.obs;

RxDouble? area;

RxDouble extimatedCost=0.0.obs;

double get width=>_width.value;
double get height=>_height.value;
set width(double width)=>_width.value=width;
set height(double height)=>_height.value=height;


 late final RxList<Item> _items;

  List<Item> get items=>_items;

  

  set addToList(Item item)=>_items.add(item);
  


 late final RxSet<Item> _selectedItemList;

  Set<Item> get selectedItemList=>_selectedItemList;
  @override
  void onInit() {

    _selectedItemList=<Item>{}.obs;
    _items=<Item>[].obs;
    // TODO: implement onInit
    super.onInit();
  }

    set addToSelectedItemsList(Item item){
//if the item is checked then add else remove this from selectedList set
    item.isSelected?_selectedItemList.add(item):_selectedItemList.remove(item);
  }

  calculatedEstimatedCost(Item item){
if(
selectedItemList.contains(item)
)
{

  extimatedCost.value=extimatedCost.value+double.parse(item.itemPrice);


}

else{

  extimatedCost.value=extimatedCost.value-double.parse(item.itemPrice);

}
  }

  submittProposal(){

    final proposal=Proposal(
      area: width*height,
      proposalUserId: Get.find<AppAuthController>().currentLoggedInuser!.value.id, items: items, estimatedCost: extimatedCost.value);


    FirestoreServices.addProposalToFirebase(proposal);
  }
}