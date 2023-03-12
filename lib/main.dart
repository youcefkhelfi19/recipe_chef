import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'featured/auth/prenstation/view_models/auth_cubit.dart';
import 'featured/categories/presentation/view_models/add_category/add_category_cubit.dart';
import 'featured/profile/presentation/view_models/admin_cubit.dart';
import 'featured/recipe/presentation/view_models/add_recipe/recipe_cubit.dart';
import 'featured/recipe/presentation/view_models/get_recipe/get_recipe_cubit.dart';
import 'firebase_options.dart';
import 'services/locator.dart';
import 'utils/app_routes.dart';
import 'utils/app_theme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  await Firebase.initializeApp(  options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();

  runApp( const RecipeChef());
}

class RecipeChef extends StatelessWidget {
  const RecipeChef({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(

      providers: [
        BlocProvider(create:(context) => AuthCubit()),
        BlocProvider<AddCategoryCubit>(create:(context) => AddCategoryCubit()),
        BlocProvider(create:(context) => AdminCubit()),
        BlocProvider(create:(context) => RecipeCubit()),
        BlocProvider(create:(context) => GetRecipeCubit()),
      ],
      child: MaterialApp(

        onGenerateRoute: generateRoutes,
        initialRoute: '/',
        theme: englishTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

