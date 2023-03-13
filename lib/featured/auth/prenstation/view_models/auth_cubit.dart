import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../../services/locator.dart';
import '../../data/models/admin.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FacebookAuth faceBookAuth = FacebookAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late Stream<User?> _authStateChange;
  AuthCubit() : super(const AuthInitial());
  Future googleSingIn()async{
    emit(const AuthLoading());
    try{
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await auth.signInWithCredential(credential).then((value) {
        Admin admin = Admin(username: value.user!.displayName!, email: value.user!.email!, phoneNumber: '', id: value.user!.uid,
            facebookLink: '',
            tiktokLink: '',
            instagramLink: '',
            youtubeLink: '',
            imageLink: value.user!.photoURL.toString(),
            saved: []
        );
        getIt.get<GetStorage>().read('id')==null? uploadAdminData(admin):null;
      });
    }catch(e){
      emit(AuthFailed(errMsg: e.toString()));
    }
  }
  Future uploadAdminData(Admin admin) async {
    emit(const AuthLoading());
    try {
      await firebaseFirestore
          .collection('admins')
          .doc(admin.id)
          .set(admin.toJson())
          .whenComplete(() async {
        emit(const AuthSuccess());
      });
      getIt.get<GetStorage>().write('id', admin.id);
      saveToken();
    } catch (e) {
      emit(AuthFailed(errMsg: e.toString()));
    }
  }
  Future facebookSingIn()async{
    emit(const AuthLoading());

    try{
      final LoginResult loginResult = await faceBookAuth.login();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await auth.signInWithCredential(facebookAuthCredential).then((value){

        Admin admin= Admin(
            username: value.user!.displayName.toString(),
            email: value.user!.email.toString(),
            id: value.user!.uid,
            phoneNumber: value.user!.phoneNumber.toString(),
            facebookLink: '',
            tiktokLink: '',
            instagramLink: '',
            youtubeLink: '',
            imageLink: value.user!.photoURL.toString(),
            saved: []
        );
        getIt.get<GetStorage>().read('id')==null? uploadAdminData(admin):null;
      });


    }catch(e){
      emit(const AuthLoading());


    }
  }
  saveToken()async{
    _authStateChange = auth.authStateChanges();
    _authStateChange.listen((user)async {
      if(user != null){
        var token = await user.getIdToken();
        getIt.get<GetStorage>().write('token', token);
      }
    });
  }
  logoutSession()async{
    try{
      await auth.signOut().then((value){
        getIt.get<GetStorage>().remove('token');
      });
    }catch(e){
      print(e);
    }
  }
  checkSession(){
    var token = getIt.get<GetStorage>().read('token');
    if(token != null){
    }else{
    }
  }
}
