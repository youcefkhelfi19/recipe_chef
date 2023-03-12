import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:recipe_chef/featured/recipe/data/models/recipe.dart';

import '../../../../../services/locator.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../../../profile/presentation/views/widgets/input_field.dart';
import '../../view_models/add_recipe/recipe_cubit.dart';
import '../../view_models/get_recipe/get_recipe_cubit.dart';

class EditeDetails extends StatefulWidget {
  final Recipe recipe;
  const EditeDetails({super.key, required this.recipe});

  @override
  State<EditeDetails> createState() => _EditeDetailsState();
}

class _EditeDetailsState extends State<EditeDetails> {
  late TextEditingController titleTextController;
  late TextEditingController categoryTextController;
  late TextEditingController descriptionTextController;
  late TextEditingController youtubeLinkTextController;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    titleTextController = TextEditingController(text: widget.recipe.title);
    categoryTextController =  TextEditingController(text: widget.recipe.category);
    descriptionTextController = TextEditingController(text: widget.recipe.description) ;
    youtubeLinkTextController = TextEditingController(text: widget.recipe.youtubeLink);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController fieldController = TextEditingController();
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      title: Container(

          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Text(
            'Update Details',
            style: style20,
          )),
      content: SizedBox(
        height: 300,
        width: MediaQuery.of(context).size.width*0.8,
        child: Form(
          key: formKey,
          child: Column(
            children: [
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
                            hintText: 'Category', label: Text('Category')),
                        suggestions: getIt.get<GetStorage>().read('names'),
                        suggestionTextStyle: style20,
                        onChanged: (value) => print('onChanged value: $value'),
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
                textEditingController: youtubeLinkTextController,
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
            ],
          ),
        ),
      ),
      actions: [
        MaterialButton(
            color: black,
            height: 50,
            minWidth: 150,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Save',
              style: style20.copyWith(color: white),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
               await context.read<RecipeCubit>().updateDetails(
                    id: widget.recipe.id.toString(),
                    title: titleTextController.text,
                    category: categoryTextController.text,
                    description: descriptionTextController.text,
                    youtubeLink: youtubeLinkTextController.text.trim());
               if(mounted){
                 context.read<GetRecipeCubit>().getRecipe(id: widget.recipe.id.toString());
                 Navigator.pop(context);
               }

              }
            })
      ],
    );
  }
}
