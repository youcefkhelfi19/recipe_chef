import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:recipe_chef/utils/aseets_paths.dart';

import '../../../../utils/app_texts.dart';
import '../../data/models/recipe.dart';
import '../view_models/add_recipe/recipe_cubit.dart';
import '../view_models/get_recipe/get_recipe_cubit.dart';
import 'wigets/add_more_images.dart';
import 'wigets/edit_details.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({Key? key, required this.recipeId}) : super(key: key);
 final  String recipeId;

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  @override
  void initState() {
    context.read<GetRecipeCubit>().getRecipe(id: widget.recipeId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRecipeCubit, GetRecipeState>(
      builder: (context, state) {
        if(state is GetRecipeSuccess){
          Recipe recipe = state.recipe;
          return RefreshIndicator(
            onRefresh: () async{
              await context.read<GetRecipeCubit>().getRecipe(id: widget.recipeId);
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title:  Text(recipe.title),
                elevation: 0.0,
                actions: [
                  IconButton(onPressed: (){
                   showDialog(context: context, builder: (context){
                     return EditeDetails(recipe: recipe,);
                   });
                  },
                      icon:const Icon(Icons.edit_outlined,color: black,))
                ],
              ),

              body: ListView(
                children: [
                  Container(
                      height: 350,
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Stack(
                        children: [
                          Swiper(
                            itemBuilder: (context, index) {
                              final image = recipe.images![index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 3,right: 3),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        //  cacheManager: customCacheManager,
                                        key: UniqueKey(),
                                        imageUrl:recipe.images![index],
                                        height: 400,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        maxHeightDiskCache: 800,
                                        placeholder: (context,url) {
                                          return  Container(
                                              padding: const EdgeInsets.all(30),
                                              height: 100,
                                              width: 100,
                                              child: Image.asset(
                                                'assets/images/loading.gif',

                                              )
                                          );
                                        },
                                        errorWidget: (context,url,error) => const Icon(Ionicons.alert_circle_outline),
                                      ),
                                    ),
                                    Positioned(
                                        right:5,
                                        top:5,
                                        child: Container(
                                          padding:const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              color: Colors.white38,
                                              shape: BoxShape.circle
                                          ),

                                          child: InkWell(
                                            child: const Icon(Ionicons.remove_circle_outline),
                                            onTap: () async{
                                              await context.read<RecipeCubit>().deleteImage(url: image, imagesLinks: recipe.images!.cast<String>(),
                                                  id: recipe.id.toString());

                                            },
                                          ),
                                        ))

                                  ],
                                ),
                              );
                            },
                            indicatorLayout: PageIndicatorLayout.SCALE,
                            autoplay: false,
                            itemCount: recipe.images!.length,
                            pagination: const SwiperPagination(

                            ),

                          ),
                          Positioned(
                              right:10,
                              bottom:20,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white38,
                                    shape: BoxShape.circle
                                ),
                                child: IconButton(

                                  icon: const Icon(Icons.add_a_photo_outlined),
                                  onPressed: () {
                                    showDialog(context: context, builder: (context){
                                      return  AddMoreImages(recipe: recipe,);
                                    });
                                  },
                                ),
                              ))

                        ],
                      )
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Description:',style:style20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      recipe.description,
                      style: TextStyle(fontSize: 16,color: Colors.grey.shade700),

                    ),
                  ),
                ],
              ),
              bottomSheet: Container(
                padding: EdgeInsets.all(10),
                color: mainColor,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Watch video on Youtube',style: style20,),
                    MaterialButton(
                      color: red,
                      minWidth: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: (){

                      },
                      child: Image.asset(youtube)
                    ),
                  ],
                ),
              ),
            ),
          );

        }else if(state is GetRecipeFailed){

        }
        return const Scaffold(
          body: Center (child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
