part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {
  final bool isLoading;

  const AddCategoryState(this.isLoading);
}

class AddCategoryInitial extends AddCategoryState {
  const AddCategoryInitial(): super(false);

}
class AddCategoryLoading extends AddCategoryState {
  const AddCategoryLoading(): super(true);
}
class AddCategorySuccess extends AddCategoryState {
  const AddCategorySuccess(): super(false);
}
class AddCategoryFailed extends AddCategoryState {
  const AddCategoryFailed(): super(false);
}
