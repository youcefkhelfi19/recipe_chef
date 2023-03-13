import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/featured/profile/presentation/view_models/admin_cubit.dart';
import 'package:recipe_chef/utils/app_routes.dart';

import '../../../../../services/locator.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts.dart';
import '../../../data/models/recipe.dart';
import '../../view_models/add_recipe/recipe_cubit.dart';

class RecipePost extends StatelessWidget {
  const RecipePost({Key? key, required this.recipe}) : super(key: key);
  final Recipe recipe ;

  @override
  Widget build(BuildContext context) {
    String userId = getIt.get<GetStorage>().read('id');

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, details,arguments: recipe.id.toString());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(10)

        ),
        child: Column(
          children: [
            Text(recipe.title,style: style20,),
            Container(
              height: 300,
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Swiper(
                itemBuilder: (context, index) {
                  //  final image = product.images![index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 3,right: 3),
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
                  );
                }, itemCount: recipe.images!.length,
                // pagination: const SwiperPagination(),
                control:  const SwiperControl(
                    color: black,disableColor: mainColor
                ),

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Column(
                    children: [
                      const Icon(Icons.add,color: Colors.transparent,size: 10,),
                      Text(recipe.datetime,style: style20.copyWith(fontSize: 12,color: green),),
                    ],
                  ),
                  const Spacer(),
                  SaveBtn(id: recipe.id.toString(),),
                  const SizedBox(width: 10,),
                  Column(
                    children: [
                      InkWell(
                          onTap: (){
                            context.read<RecipeCubit>().likeUnlikePost(recipe);
                          },
                          child:  Icon(recipe.likes.contains(userId)?Ionicons.heart:Ionicons.heart_outline,color: red,)),
                      Text(recipe.likes.length.toString(),style: style20.copyWith(fontSize: 10,color: red),)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
class SaveBtn extends StatefulWidget {
  const SaveBtn({Key? key, required this.id}) : super(key: key);
   final String id ;
  @override
  State<SaveBtn> createState() => _SaveBtnState();
}

class _SaveBtnState extends State<SaveBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          context.read<AdminCubit>().saveRecipe(postId: widget.id);
          setState(() {
          });
        },
        child:  Icon(context.read<AdminCubit>().admin.saved.contains(widget.id)?Ionicons.bookmark:Ionicons.bookmark_outline,color: red,));
  }
}
