import 'package:flutter/material.dart';

import '../../../../../utils/app_colors.dart';
import 'alert_dialog.dart';

class SocialMediaBtn extends StatelessWidget {
  const SocialMediaBtn({
    super.key,
    required this.image,
    required this.fieldName, required this.hintText
  });
  final String image;
  final String fieldName;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(context: context, builder: (context){
          return  CustomAlertDialog(
            fieldName: fieldName,
            hintText: hintText,
          );
        });
      },
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: black
        ),
        child: Image.asset(image),
      ),
    );
  }
}
