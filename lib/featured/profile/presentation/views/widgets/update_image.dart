import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../view_models/admin_cubit.dart';

class UpdateImage extends StatefulWidget {
  const UpdateImage({Key? key}) : super(key: key);

  @override
  State<UpdateImage> createState() => _UpdateImageState();
}

class _UpdateImageState extends State<UpdateImage> {
  late File _image ;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          child:  const Text('Upload Picture',style: style20,)),
      content: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                 _pickImageFromGallery();
                }, icon:  const Icon(Ionicons.albums_outline,size: 40,color: black,)),
                 Text('From Gallery',style: style20.copyWith(fontSize: 16),)
              ],
            ),
            Column(
              children: [
                IconButton(onPressed: (){
                 _pickImageFromCamera();
                }, icon: const Icon(Ionicons.camera_outline,size: 40,)),
                 Text('From Camera',style: style20.copyWith(fontSize: 16),)
              ],
            )
          ],),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {
        _image = File(pickedFile!.path);
      });
      context.read<AdminCubit>().uploadImage(_image);
      Navigator.pop(context);

    }


  }

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (mounted) {
      setState(() {
        _image = File(pickedFile!.path);
      });
      context.read<AdminCubit>().uploadImage(_image);
      Navigator.pop(context);

    }


  }
}
