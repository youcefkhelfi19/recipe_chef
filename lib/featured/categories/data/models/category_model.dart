import 'package:equatable/equatable.dart';
class CategoryModel extends Equatable {
 final String imageLink;
 final String title;
 final String categoryId;
  const CategoryModel( {required this.imageLink,required this.categoryId, required this.title});
  @override
  // TODO: implement props
  List<Object?> get props => [imageLink,title];


 Map<String, dynamic> toJson() => {
  'title': title,
  'categoryId':categoryId,
  'image':imageLink,
 };

 static CategoryModel fromJson(Map<String, dynamic> json) {
  return CategoryModel(
   imageLink: json['image'],
   categoryId: json['categoryId'],
   title: json['title'],
  );
 }
}