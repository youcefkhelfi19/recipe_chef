import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:uuid/uuid.dart';

import '../../../../../services/global_functions/show_toast.dart';
import '../../../../../services/locator.dart';
import '../../../data/models/category_model.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  AddCategoryCubit() : super(const AddCategoryInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  var uuid = const Uuid();
  List<CategoryModel> categories = [];

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
    snapshot.forEach((element) {
      if(categories.length != element.docs.length){
        categories = [];
        for(var e in element.docs ){
          //print(e.data());
          categories.add(CategoryModel.fromJson(e.data()));
        }
        getIt.get<GetStorage>().write('categories',categories);
      }else{
      }
    });
    return snapshot;
  }
}
