import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/models/recipe.dart';

part 'get_recipe_state.dart';

class GetRecipeCubit extends Cubit<GetRecipeState> {
  GetRecipeCubit() : super(GetRecipeInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future getRecipe({required String id})async{
    emit( GetRecipeLoading());

    Recipe recipe;
    try{
      var snapshot =   firebaseFirestore.collection('recipes').doc(id);
      snapshot.get().then((value){
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        recipe = Recipe.fromJson(data);
        emit(GetRecipeSuccess(
            recipe: recipe
        ));
      });
    }catch(e){
      emit(GetRecipeFailed(errMsg: e.toString()));
    }
  }

}
