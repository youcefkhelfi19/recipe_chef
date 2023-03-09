import 'package:flutter/material.dart';
import 'package:recipe_chef/utils/app_colors.dart';

import 'add_category.dart';

class AddCategoryBtn extends StatelessWidget {
  const AddCategoryBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: (){
       showDialog(context: context, builder: (context){
         return const AddCategory();
       });
    }, icon:const Icon(Icons.add_circle,color: black,));
  }
}
