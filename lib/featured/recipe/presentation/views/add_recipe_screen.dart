import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_chef/featured/categories/presentation/view_models/add_category/add_category_cubit.dart';
import 'package:recipe_chef/utils/app_colors.dart';

import '../../../../services/locator.dart';
import '../../../../utils/app_texts.dart';
import '../../../../utils/global_widgits/loading_widget.dart';
import '../../../profile/presentation/views/widgets/input_field.dart';
import '../../data/models/recipe.dart';
import '../view_models/add_recipe/recipe_cubit.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  List<File> imagesList = [];
  List<Asset> assetsImages = [];
  GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController titleTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController categoryTextController;
  late TextEditingController youtubeLinkController;
  @override
  void initState() {
    titleTextController = TextEditingController();
    descriptionTextController = TextEditingController();
    categoryTextController = TextEditingController();
    youtubeLinkController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listener: (context, state) {
        if (state is RecipeSuccess) {
          cleatForm();
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Images',
                          style: style20.copyWith(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: white,
                          ),
                          child: ListView.builder(
                              itemCount: imagesList.length + 1,
                              scrollDirection: Axis.horizontal,
                              reverse: true,
                              itemBuilder: (context, index) {
                                if (index == imagesList.length ||
                                    imagesList.isEmpty) {
                                  return Container(
                                    width: 80,
                                    margin: const EdgeInsets.all(3),
                                    child: DottedBorder(
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(10),
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
                                  return Stack(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 90,
                                        margin: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                                image: FileImage(
                                                    imagesList[index]),
                                                fit: BoxFit.fill)),
                                      ),
                                      Positioned(
                                          top: 7,
                                          right: 7,
                                          child: Container(
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white54),
                                            child: InkWell(
                                                onTap: () {
                                                  imagesList.removeAt(index);
                                                  setState(() {});
                                                },
                                                child: const Icon(
                                                  Icons.remove_circle_outline,
                                                  color: black,
                                                  size: 17,
                                                )),
                                          ))
                                    ],
                                  );
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Recipe details',
                            style: style20.copyWith(fontSize: 16),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: CustomInputField(
                                  hintText: 'Recipe Name',
                                  textEditingController: titleTextController,
                                  //label: 'Product Name',
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Add title';
                                    }
                                    return null;
                                  },
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                flex: 2,
                                child: EasyAutocomplete(
                                  controller: categoryTextController,
                                  decoration: const InputDecoration(
                                      hintText: 'Category',
                                      label: Text('Category')),
                                  suggestions:getIt.get<GetStorage>().read('names'),
                                  onChanged: (value) =>
                                      print('onChanged value: $value'),
                                  onSubmitted: (value) =>
                                      print('onSubmitted value: $value'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Add Category';
                                    }
                                    return null;
                                  },
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomInputField(
                          hintText: 'Youtube video link',
                          textEditingController: youtubeLinkController,
                          //label: 'Product Name',
                          validator: (value) {
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            controller: descriptionTextController,
                            minLines: 5,
                            maxLines: 5,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Add Description';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Recipe Description or Ingredients',
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                              color: black,
                              height: 50,
                              minWidth: 150,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Save',
                                style: style20.copyWith(color: white),
                              ),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (imagesList.isNotEmpty) {
                                    Recipe recipe = Recipe(
                                        title: titleTextController.text,
                                        category: categoryTextController.text,
                                        description: descriptionTextController.text,
                                        youtubeLink: youtubeLinkController.text.isEmpty?'':youtubeLinkController.text,
                                        likes: [],
                                        datetime: DateTime.now().toString());
                                    context
                                        .read<RecipeCubit>()
                                        .uploadImagesAndRecipeData(
                                            imagesList, recipe);
                                  }
                                }
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            state.isLoading ? const LoadingWidget() : const SizedBox(),
          ],
        );
      },
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
    } on Exception catch (e) {}
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
      imagesList = fileList;
    });
    // Upload the files
  }

  cleatForm() {
    setState(() {
      titleTextController.clear();
      descriptionTextController.clear();
      categoryTextController.clear();

      imagesList = [];
      assetsImages = [];
    });
  }
}
