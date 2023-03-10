import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_chef/featured/categories/data/models/category_model.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:recipe_chef/utils/app_texts.dart';

import '../../../../utils/app_routes.dart';
import '../view_models/add_category/add_category_cubit.dart';
List<String> cats = [];
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body:StreamBuilder<QuerySnapshot>(
             stream: context.read<AddCategoryCubit>().getAllCategories(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return const Center(child: CircularProgressIndicator());
               } else if (snapshot.connectionState ==
                   ConnectionState.active) {

                 if (snapshot.data!.docs.isNotEmpty) {
                   return GridView.builder(
                       padding: const EdgeInsets.only(top: 10,left: 10,right: 10),

                       itemCount:snapshot.data!.docs.length,
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 2,
                           childAspectRatio: 1.5),
                       itemBuilder: (context,index){
                         Map<String, dynamic>? data = snapshot.data!.docs[index].data() as Map<String, dynamic>? ;
                         CategoryModel category = CategoryModel.fromJson(data!);
                         return  InkWell(
                             onTap: (){
                               Navigator.pushNamed(
                                   context, categoryFeeds, arguments: index);
                             },
                             child: CategoryCard(category: category,));
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

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key, required this.category,
  });
 final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child:Container(
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image:  DecorationImage(
              image: NetworkImage(category.imageLink,),
              fit: BoxFit.fill
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              height: 50,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black,
                      Colors.black45,
                      Colors.black12.withOpacity(0.0),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)
                  )
              ),
              child: Text(category.title,style: style24.copyWith(color: mainColor),),
            )
          ],
        ),
      ) ,
    );
  }
}
