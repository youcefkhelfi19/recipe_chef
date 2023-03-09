import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/aseets_paths.dart';
import 'update_image.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: black,
            child:imageUrl.isEmpty?const CircleAvatar(
              radius: 52,
              backgroundImage: AssetImage(user),
            ):  CircleAvatar(
              backgroundColor: mainColor,
              radius: 52,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: InkWell(
              onTap: (){
               showDialog(context: context, builder: (context){
                 return const UpdateImage();
               });
              },
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: black
                  ),
                  child:const Icon(Ionicons.camera_outline,color: mainColor,size: 15,)),
            ),

          )
        ],
      ),
    );
  }
}
