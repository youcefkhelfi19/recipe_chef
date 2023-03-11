
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

import '../../../../../services/global_functions/show_toast.dart';
import '../../../../../utils/app_colors.dart';
import '../../../data/models/recipe.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(RecipeInitial());
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  Future uploadImagesAndRecipeData(List<File> images,Recipe recipe) async {
    String recipeId = uuid.v4();
    emit(RecipeLoading());
    List<String> imagesLinks = [];
    try {
      for (int i = 0; i < images.length; i++) {
        final ref =  firebaseStorage
            .ref()
            .child('products')
            .child(recipeId)
            .child(Path.basename(DateTime.now().toString()));
        await ref.putFile(images[i]).whenComplete(() async {
          await ref.getDownloadURL().then((value) => {
            imagesLinks.add(value),
          });

        });
      }
      recipe.id = recipeId;
      recipe.images = imagesLinks;
      await addRecipeData(recipe);
    } catch (e) {
      customToast(msg: 'something went wrong ', color: red);

    }
  }

  Future addRecipeData(Recipe recipe) async {
    try {
      await firebaseFirestore
          .collection('recipes')
          .doc(recipe.id)
          .set(recipe.toJson())
          .whenComplete(() async {
        emit(RecipeSuccess());
        customToast(msg: 'Product has been saved', color: black);
      });

    } catch (e) {
      emit(RecipeFailed());
    }
  }
  Future updateField({required dynamic fieldValue, required String field, required String id }) async {

    try{
      await  firebaseFirestore
          .collection('recipes')
          .doc(id)
          .update({field: fieldValue}).then((value){
        customToast(
            msg: '$field has been updated', color: black
        );
      });


    }catch(e){
      customToast(
          msg: 'Something went wrong ', color: red
      );
    }

  }
  updateImages({required List<String> imagesLinks,required List<File> images, required String id})async{
    emit(RecipeLoading());
    try {
      for (int i = 0; i < images.length; i++) {
        final ref =  firebaseStorage
            .ref()
            .child('products')
            .child(id)
            .child(Path.basename(DateTime.now().toString()));
        await ref.putFile(images[i]).whenComplete(() async {
          await ref.getDownloadURL().then((value) => {
            imagesLinks.add(value),
          });

        });
      }
      await updateField(fieldValue: imagesLinks, field: 'images', id: id);
      emit(RecipeSuccess());
    } catch (e) {
      customToast(msg: 'something went wrong ', color: red);

    }
  }
  Future deleteImage({required String url,required List<String> imagesLinks,required String id}) async {
    try {
      Reference photoRef = firebaseStorage.refFromURL(url);
      await photoRef.delete().then((value) {
        imagesLinks.remove(url);
        updateField(fieldValue: imagesLinks, field: 'images', id: id);
      });

    } catch (e) {
      return false;
    }
  }
  Future deleteProductPictures({required Recipe recipe}) async {
    try {
      for (var url in recipe.images!) {
        Reference photoRef = firebaseStorage.refFromURL(url);
        await photoRef.delete().then((value) {
        });
      }
      await deleteProduct(id: recipe.id.toString(),);
    } catch (e) {

    }
  }

  deleteProduct({required String id}) async {
    try {
      await firebaseFirestore.collection('devices').doc(id).delete().whenComplete((){
      }
      );

    } catch (e) {
    }
  }
}
