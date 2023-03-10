import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../utils/app_colors.dart';
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
              padding: const EdgeInsets.only(top: 10),
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
              flex: 7,
              child: TabBarView(
                controller: tabController,
                children: widget.categories.map((CategoryModel category) {
                  return SizedBox();
                }).toList(),))
        ],
      ),
    ),

    );
  }
}
