import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../../../profile/presentation/views/widgets/input_field.dart';
import '../../view_models/add_category/add_category_cubit.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  late File image = File('');
  late TextEditingController categoryController;
  @override
  void initState() {
    categoryController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    categoryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.only(top: 0,left: 0,right: 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
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
          child:   const Text('Add Category',style: style20,)),
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                    _pickImageFromGallery();
              },
              child: Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.all(3),
                decoration:   BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: image.path.isEmpty?null:DecorationImage(
                        image: FileImage(image)
                    )
                ),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  color: black,
                  child:  Align(
                    alignment: Alignment.center,
                    child: image.path.isNotEmpty?null:const Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 40,
                      color: black,
                    ),
                  ),
                ),
              ),
            ),
            CustomInputField(
                hintText: 'Category', textEditingController: categoryController, validator:(value){
              return value;
            }),

          ],
        ),
      ),
      actions: [BlocConsumer<AddCategoryCubit, AddCategoryState>(
        listener:(context, state){
          if(state is AddCategorySuccess){
            setState(() {
              image = File('');
              categoryController.clear();
            });
          }
        },
        builder: (context, state) {
          return state.isLoading?const CircularProgressIndicator(color: green,backgroundColor: mainColor,):
          MaterialButton(
            height: 40,
            minWidth: 50,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            color: black,
            onPressed: () async{
              if(image.path.isEmpty || categoryController.text.isNotEmpty){
                await context.read<AddCategoryCubit>().uploadCategory(image: image, categoryTitle: categoryController.text);
              }
            },
            child: Text('Add',style: style20.copyWith(fontSize: 16,color: mainColor),),
          );
        },
      ),],
    );
  }
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(mounted){
      setState(() {
        image = File(pickedFile!.path);
        Navigator.pop(context);

      });

    }

  }
}