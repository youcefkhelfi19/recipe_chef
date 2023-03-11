import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/featured/recipe/presentation/views/add_recipe_screen.dart';
import 'package:recipe_chef/utils/app_texts.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../../../services/locator.dart';
import '../../../../utils/app_colors.dart';
import '../../../recipe/data/models/recipe.dart';
import '../../../recipe/presentation/view_models/add_recipe/recipe_cubit.dart';
import '../../../recipe/presentation/views/wigets/post_card.dart';
import '../view_models/all_recipes_cubit.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: context.read<AllRecipesCubit>().getRecipes(),
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

