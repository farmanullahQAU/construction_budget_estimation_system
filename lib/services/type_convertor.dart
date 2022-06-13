import 'dart:ffi';

import 'package:construction_budget_estimation_system/constants/text_constants.dart';
import 'package:construction_budget_estimation_system/models/user_model.dart';
import 'package:intl/intl.dart';

class Convertor{


  static  String? convertTo(UserType? type)

{

  switch(type){
    case UserType.builder:
    
    return builder;
    
    case UserType.vendor:
    return 
    vendor;
    

    case UserType.landOwner:
return landOwner;
case null:
return null;


    
  }
  
}

static UserType? convertFrom(String? type){
switch(type){
case vendor:

return 
UserType.vendor;
case landOwner:

return UserType.landOwner;
case builder:
return UserType.builder;


}
return null;

}
static String formatDate(DateTime date){

return DateFormat().add_MEd().format(date);
}

}