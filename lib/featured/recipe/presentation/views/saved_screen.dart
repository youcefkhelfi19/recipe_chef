import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/recipe.dart';
import '../view_models/add_recipe/recipe_cubit.dart';
import 'wigets/post_card.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: StreamBuilder<QuerySnapshot>(
           stream: context.read<RecipeCubit>().getSavedRecipes(),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return const Center(child: CircularProgressIndicator());
             } else if (snapshot.connectionState ==
                 ConnectionState.active) {
               if (snapshot.data!.docs.isNotEmpty) {
                 return ListView.builder(
                     padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
                     itemCount:snapshot.data!.docs.length,
                     itemBuilder: (context,index){
                       Map<String, dynamic>? data = snapshot.data!.docs[index].data() as Map<String, dynamic>? ;
                       Recipe recipe = Recipe.fromJson(data!);
                       return  RecipePost(recipe: recipe,);
                     });
               } else {
                 return const Center(child: Text('No data'),);
               }
             }
             return const Center(
                 child:  Text(
                   'something_went_wrong',
                   style: TextStyle(
                       fontWeight: FontWeight.bold, fontSize: 30),
                 ));
           },
         ),
    );
  }
}
