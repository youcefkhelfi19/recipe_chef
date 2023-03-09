import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../view_models/admin_cubit.dart';
import 'input_field.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({Key? key, required this.fieldName, required this.hintText,  this.isNumber = false}) : super(key: key);
  final String fieldName;
  final String hintText;
 final  bool isNumber;
  @override
  Widget build(BuildContext context) {
    TextEditingController fieldController =TextEditingController();
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(10)
      ),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
              )
          ),
          child:   Text('Update $hintText',style: style20,)),
      content: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width*0.8,
        child: CustomInputField(
          isNumber: isNumber,
          validator: (value){

            return null;
          },

          textEditingController: fieldController,
          hintText: hintText,
        ),
      ),
      actions: [
        MaterialButton(
          height: 40,
          minWidth: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          color: black,
          onPressed: () async{
            if(fieldController.text.isNotEmpty){
                 context.read<AdminCubit>().updateField(fieldValue: fieldController.text, field: fieldName);
                fieldController.clear();
                Navigator.pop(context);
            }

          },
          child:  Text('Save',style: style20.copyWith(color: mainColor),),
        ),
      ],
    );
  }
}
