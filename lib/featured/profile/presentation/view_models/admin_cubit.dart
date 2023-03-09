import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

import '../../../../services/global_functions/show_toast.dart';
import '../../../../services/locator.dart';
import '../../../../utils/app_colors.dart';
import '../../../auth/data/models/admin.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  @override
  void onChange(Change<AdminState> change) {
    super.onChange(change);
  }
  Future fetchAdminData({required String id , bool showLoading = false})async{
    showLoading?emit(AdminLoading()):null;
    Admin admin;
    try{
      var snapshot =  firebaseFirestore.collection('admins').doc(id);
      snapshot.get().then((value){
        Map<String, dynamic>? data = value.data();
        admin = Admin.fromJson(data!);
        emit(AdminSuccess(
            admin: admin
        ));
      });
    }catch(e){
      emit(AdminFailed(errMsg: e.toString()));
    }
  }
  Future updateField({required String fieldValue, required String field}) async {

    try{
      await  firebaseFirestore
          .collection('admins')
          .doc(getIt.get<GetStorage>().read('id'))
          .update({field: fieldValue}).then((value){
        fetchAdminData(id: getIt.get<GetStorage>().read('id'));
      });

    }catch(e){
      customToast(
          msg: 'Something went wrong ', color: red
      );
    }

  }
  uploadImage(File image)async{
    customToast(
        msg: 'uploading image', color:black
    );
    try{
      final ref =  firebaseStorage
          .ref()
          .child('admins')
          .child(getIt.get<GetStorage>().read('id'));
      await ref.putFile(image).whenComplete(() async {
        await ref.getDownloadURL().then((value) => {
          updateField(fieldValue: value, field: 'imageLink')
        });

      });
    }catch(e){

      customToast(
          msg: 'Something went wrong ', color:red
      );
    }
  }
}
