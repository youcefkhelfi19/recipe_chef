import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/utils/app_texts.dart';

import '../../../../utils/app_colors.dart';

class KitchenScreen extends StatelessWidget {
  const KitchenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SizedBox(
         height: 800,
         child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
             itemCount: 10,
             itemBuilder: (context,index){
            return Container(
            margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(10)

              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Recipe title',style: style20,),
                  ),
                  Image.network('https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=449&q=80',height: 300,width: double.infinity,fit: BoxFit.fill,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Container(
                          child: Column(
                            children: [
                               const Icon(Icons.add,color: Colors.transparent,size: 10,),
                              Text('12.2.2023|12:23',style: style20.copyWith(fontSize: 12,color: green),),
                            ],
                          ),
                        ),
                        const Spacer(),
                        const Icon(Ionicons.bookmark_outline,color: red,),
                        const SizedBox(width: 10,),
                        Column(
                          children: [
                            const Icon(Ionicons.heart_outline,color: red,),
                            Text('200',style: style20.copyWith(fontSize: 10,color: red),)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
         }),
       ),
    );
  }
}
