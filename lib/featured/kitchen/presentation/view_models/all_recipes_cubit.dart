import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'all_recipes_state.dart';

class AllRecipesCubit extends Cubit<AllRecipesState> {
  AllRecipesCubit() : super(AllRecipesInitial());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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

}
