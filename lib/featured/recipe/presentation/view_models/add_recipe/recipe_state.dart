part of 'recipe_cubit.dart';

@immutable
abstract class RecipeState {
  final bool isLoading;

  const RecipeState(this.isLoading);
}

class RecipeInitial extends RecipeState {
  const RecipeInitial() : super(false);
}
class RecipeFailed extends RecipeState {
  const RecipeFailed() : super(false);
}
class RecipeSuccess extends RecipeState {
   const RecipeSuccess() : super(false);
}
class RecipeLoading extends RecipeState {

  const RecipeLoading() : super(true);
}
