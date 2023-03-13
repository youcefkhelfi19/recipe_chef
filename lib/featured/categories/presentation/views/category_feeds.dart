import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../utils/app_colors.dart';
import '../../../recipe/data/models/recipe.dart';
import '../../../recipe/presentation/view_models/add_recipe/recipe_cubit.dart';
import '../../../recipe/presentation/views/wigets/post_card.dart';
import '../../data/models/category_model.dart';

class CategoryFeeds extends StatefulWidget {
  const CategoryFeeds({Key? key, required this.index,required this.categories}) : super(key: key);
  final int index ;
  final List<CategoryModel> categories ;
  @override
  State<CategoryFeeds> createState() => _CategoryFeedsState();
}

class _CategoryFeedsState extends State<CategoryFeeds> with TickerProviderStateMixin {
  late TabController tabController ;

  void initState() {
    tabController = TabController(length: widget.categories.length,vsync:this,initialIndex: widget.index );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.categories.length, child:
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Feeds'),
        elevation: 0.0,
        actions: [IconButton(onPressed: (){

        }, icon: const Icon(Ionicons.heart))],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(0),
              alignment: Alignment.topCenter,
              child: ButtonsTabBar(
                controller: tabController,
                backgroundColor: black,
                unselectedBackgroundColor: mainColor,
                unselectedLabelStyle:  const TextStyle(color: black),

                labelStyle:
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: widget.categories.map<Tab>((CategoryModel category) {
                  return Tab(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(category.imageLink)),
                    ),
                    text: category.title,
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
              flex:15,
              child: TabBarView(
                controller: tabController,
                children: widget.categories.map((CategoryModel category) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: context.read<RecipeCubit>().getRecipesByCategory(category.title),
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
                  );
                }).toList(),))
        ],
      ),
    ),

    );
  }
}
