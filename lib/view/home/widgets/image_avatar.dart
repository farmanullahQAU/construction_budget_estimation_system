import 'package:flutter/material.dart';

class ImageAvatar extends StatelessWidget {

  final String imagePath;

  
  const ImageAvatar({Key? key,required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
child: Stack(
  alignment: Alignment.bottomRight,
  children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            
    
    
      radius: 70,
      
      backgroundImage: AssetImage(imagePath)),
        ),

    Container(

      child: IconButton(icon:Icon(Icons.camera),onPressed: (){},),
      
      width: 50,height: 50,decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      
      borderRadius: BorderRadius.circular(50)),)
  ],
),


    );
  }
}