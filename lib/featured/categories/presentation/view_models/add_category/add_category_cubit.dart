import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:uuid/uuid.dart';

import '../../../../../services/global_functions/show_toast.dart';
import '../../../data/models/category_model.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(const AddCategoryInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  List<CategoryModel> categories  = [];
  var uuid = const Uuid();
  Future addCategory(CategoryModel category) async {
    emit( const AddCategoryLoading());
    try {
      await firebaseFirestore
          .collection('categories')
          .doc(category.categoryId)
          .set(category.toJson())
          .whenComplete(() async {
        emit( const AddCategorySuccess());
      });
    } catch (e) {
      emit(const AddCategoryFailed());
    }
  }

  uploadCategory({required File image, required String categoryTitle})async{
    String categoryId = uuid.v4();
    emit( const AddCategoryLoading());
    customToast(
        msg: 'uploading category', color: black
    );
    try{
      final ref =  firebaseStorage
          .ref()
          .child('categories')
          .child(categoryId.toString());
      await ref.putFile(image).whenComplete(() async {
        await ref.getDownloadURL().then((value){
          CategoryModel category = CategoryModel(imageLink: value, title: categoryTitle.trim(), categoryId: categoryId);
          addCategory(category);
        });
      });
    }catch(e){
      emit( const AddCategoryFailed());
      customToast(
          msg: 'Something went wrong ', color: black
      );
    }
  }
  getAllCategories() {
    var snapshot = firebaseFirestore.collection('categories').snapshots();
    return snapshot;
  }
}
