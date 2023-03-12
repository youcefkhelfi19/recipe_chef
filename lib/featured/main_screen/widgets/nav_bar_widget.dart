import 'package:awesome_bottom_bar/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/featured/profile/presentation/views/profile_screen.dart';

import '../../categories/presentation/views/categories_screen.dart';
import '../../recipe/presentation/views/kitchen_screen.dart';
import '../../recipe/presentation/views/add_recipe_screen.dart';
import '../../saved/presentation/views/saved_screen.dart';

const List<TabItem> items = [
  TabItem(
    icon: Ionicons.book_outline,
    title: 'Kitchen',
  ),
  TabItem(
    icon: Ionicons.albums_outline,
    title: 'Categories',
  ),
  TabItem(
    icon: Ionicons.add,
    title: 'Add Recipe',
  ),
  TabItem(
    icon: Ionicons.bookmark_outline,
    title: 'Saved',
  ),
  TabItem(
    icon: Ionicons.person_outline,
    title: 'profile',
  ),
];
const List<Widget> screens = [
  KitchenScreen(),
  CategoriesScreen(),
  AddRecipe(),
  SavedScreen(),
  ProfileScreen(),
];
