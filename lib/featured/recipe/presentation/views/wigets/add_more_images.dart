import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../../data/models/recipe.dart';
import '../../view_models/add_recipe/recipe_cubit.dart';

class AddMoreImages extends StatefulWidget {
  const AddMoreImages({super.key,required this.recipe});
  final Recipe recipe;
  @override
  State<AddMoreImages> createState() => _AddMoreImagesState();
}

class _AddMoreImagesState extends State<AddMoreImages> {
  List<File> imagesList = [];
  List<Asset> assetsImages = [];
  List<String> imagesLinks = [];
  late String id ;
  @override
  void initState() {
    imagesLinks = widget.recipe.images!.cast<String>();
    id = widget.recipe.id.toString();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(imagesLinks);
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Text(
            'Add images',
            style: style20,
          )),
      content: Container(
        height: 250,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: white,
        ),
        child: GridView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: imagesList.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            if (index == imagesList.length) {
              return Container(
                width: 80,
                margin: const EdgeInsets.all(3),
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(12),
                  color: black,
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        pickImages();
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        size: 40,
                        color: black,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                height: 80,
                width: 80,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: FileImage(
                          imagesList[index],
                        ),
                        fit: BoxFit.fill)),
              );
            }
          },
        ),
      ),
      actions: [
        BlocConsumer<RecipeCubit, RecipeState>(
          listener: (context, state) {
            if(state is RecipeSuccess){
              if (mounted) Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return state.isLoading?const CircularProgressIndicator(
              color: mainColor,
              backgroundColor: green,
            ): MaterialButton(
              height: 40,
              minWidth: 50,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: black,
              onPressed: () async {
                if(imagesList.isNotEmpty){
                  context.read<RecipeCubit>().updateImages(imagesLinks: imagesLinks, images: imagesList, id: id);
                }
              },
              child: Text(
                'Save',
                style: style20.copyWith(
                    color: mainColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 16),
              ),
            );
          },
        )
      ],
    );
  }
  Future<void> pickImages() async {
    List<Asset> result = <Asset>[];
    try {
      result = await MultiImagePicker.pickImages(
        maxImages: 1000,
        enableCamera: true,
        selectedAssets: assetsImages,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#424242",
          actionBarTitle: "Select Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
    }
    if (!mounted) return;


    uploadImages(result);
  }
  Future<void> uploadImages(List<Asset> images) async {
    List<File> fileList = [];
    for (var i = 0; i < images.length; i++) {
      ByteData byteData = await images[i].getByteData();
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/image$i.jpg';
      File tempFile = File(tempPath);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      fileList.add(tempFile);
    }
    setState(() {
      imagesList= fileList ;
    });
    // Upload the files
  }

}
