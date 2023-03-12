part of 'get_recipe_cubit.dart';

@immutable
abstract class GetRecipeState {}

class GetRecipeInitial extends GetRecipeState {}
class GetRecipeLoading extends GetRecipeState {}
class GetRecipeSuccess extends GetRecipeState {
  final Recipe recipe;

  GetRecipeSuccess({required this.recipe});
}
class GetRecipeFailed extends GetRecipeState {
  final String errMsg;

  GetRecipeFailed({required this.errMsg});
}