import '../constants/firestore_constants.dart';

class AppUser{
late final String id;
  String? userName;
 late String userEmail;
  String? userPhone;
  String? userType ; 


  AppUser({ this.userName,required this.userEmail, this.userPhone,this.userType});


  Map<String, dynamic> toMap() {

    return {
    FirestoreConstants.userName:userName,
    FirestoreConstants.userEmail:userEmail,
    FirestoreConstants.userType:userType,



  

    };
  }


  
   AppUser.fromMap( Map<String, dynamic>  data,userId) {

     id=userId;

// userName
//       =(DateTime.fromMicrosecondsSinceEpoch(data[FirestoreConstants.dateFinished].microsecondsSinceEpoch));
 
 
 
 
  // usena=convertPosition(data[FirestoreConstants.position])!;

  userName=data[FirestoreConstants.userName];

  userEmail=data[FirestoreConstants.userEmail];

  userType=data[FirestoreConstants.userType];

  }

}

enum UserType {vendor,landOwner,builder}