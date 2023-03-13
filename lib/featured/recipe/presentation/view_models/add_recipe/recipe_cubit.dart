
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as Path;

import '../../../../../services/global_functions/show_toast.dart';
import '../../../../../services/locator.dart';
import '../../../../../utils/app_colors.dart';
import '../../../data/models/recipe.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  RecipeCubit() : super(const RecipeInitial());
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var uuid = const Uuid();

  Future uploadImagesAndRecipeData(List<File> images,Recipe recipe) async {
    String recipeId = uuid.v4();
    emit(const RecipeLoading());
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
        emit(const RecipeSuccess());
        customToast(msg: 'Product has been saved', color: black);
      });

    } catch (e) {
      emit(const RecipeFailed());
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
    emit(const RecipeLoading());
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
      emit(const RecipeSuccess());
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
  likeUnlikePost(Recipe recipe)async{
    String userId = getIt.get<GetStorage>().read('id');
    if(recipe.likes.contains(userId)){
      recipe.likes.remove(userId);
     await updateField(fieldValue: recipe.likes, field: 'likes', id: recipe.id.toString());
    }else{
      recipe.likes.add(userId);
      await updateField(fieldValue: recipe.likes, field: 'likes', id: recipe.id.toString());

    }
  }
  Future deleteRecipePictures({required Recipe recipe}) async {
    try {
      for (var url in recipe.images!) {
        Reference photoRef = firebaseStorage.refFromURL(url);
        await photoRef.delete().then((value) {
        });
      }
      await deleteRecipe(id: recipe.id.toString(),);
    } catch (e) {

    }
  }
  updateDetails({required String id ,required String title,required String category,required String description,required String youtubeLink })async{
    emit(const RecipeLoading());
    try{

      await  firebaseFirestore
          .collection('products')
          .doc(id)
          .update({'title': title,'description': description,'category': category,
        'youtubeLink': youtubeLink,}).then((value){

        customToast(
            msg: 'data has been updated', color: black
        );

        emit(const RecipeSuccess());
      });


    }catch(e){
      emit(const RecipeFailed());
      customToast(
          msg: 'Something went wrong ', color: red
      );
    }
  }

  getRecipesByCategory(String category) {
    return firebaseFirestore
        .collection('recipes')
        .where('category', isEqualTo: category)
        .snapshots();
  }
  getRecipes() {
    return firebaseFirestore
        .collection('recipes')
        .snapshots();
  }
  getSavedRecipes() {
    List<String> saved = getIt.get<GetStorage>().read('saved');

    return firebaseFirestore
        .collection('recipes').where('id', whereIn: saved.isEmpty?['']:saved  )
        .snapshots();
  }

  deleteRecipe({required String id}) async {
    try {
      await firebaseFirestore.collection('devices').doc(id).delete().whenComplete((){
      }
      );

    } catch (e) {
    }
  }
}
