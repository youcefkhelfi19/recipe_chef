import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:recipe_chef/utils/app_colors.dart';

import '../../../../utils/app_texts.dart';
import '../../../../utils/aseets_paths.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/settings_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool value = true;

    return Scaffold(
       body: ListView(
         padding: const EdgeInsets.symmetric(horizontal: 8),
         children: [
           Align(
             alignment: Alignment.center,
             child: Stack(
               children: [
                 CircleAvatar(
                   radius: 55,
                   backgroundColor: black,
                   child:value?const CircleAvatar(
                     radius: 52,
                     backgroundImage: AssetImage(user),
                   ): const CircleAvatar(
                     backgroundColor: mainColor,
                     radius: 52,
                     backgroundImage: NetworkImage('state.admin.image'),
                   ),
                 ),
                 Positioned(
                   bottom: 5,
                   right: 5,
                   child: InkWell(
                     onTap: (){
                       //imageAlertDialog(context:context,
                         //  openCamera: (){_pickImageFromCamera();},
                          // openGallery: (){_pickImageFromGallery();}
                       //);
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
           ),
           const Align(
               alignment: Alignment.center,
               child: Text('username',style: style24,)),
           const SizedBox(height: 20,),
           const Text('Social Media'),
           const SizedBox(height: 10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: const [

              SocialMediaBtn(
                image: youtube,

              ),
              SocialMediaBtn(
                image: instagram,

              ),
              SocialMediaBtn(
                image: facebook,

              ),
               SocialMediaBtn(
                image: tiktok,

              ),
             ],
           ),
           const SizedBox(height: 10,),

           const Text('User Info',style: style24,),

           Card(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)
             ),
             color: const Color(0xFFFAF7F0),
             child:Column(
               children:  [
                  CustomListTile(
                   title: 'Email',
                   subtitle: Text('state.admin.email',style: style20.copyWith(color: Colors.grey),),
                   leading: Ionicons.mail_outline,
                 ) ,
                 CustomListTile(
                   title: 'Phone',
                   subtitle:  Text('state.admin.phone',style: style20.copyWith(color: Colors.grey),),
                   leading: Ionicons.call_outline,
                   trailing: Icons.edit_outlined,
                   onTap: (){
                  //   updateFieldAlert(context: context, title: 'Update Phone number', hint: 'phone number',  fieldName: 'phone');
                   },
                 ),

               ],
             ),
           ),
           const SizedBox(height: 10,),
           const Text('Settings',style: style24,),
           Card(
             shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(10)
             ),
             child: Column(
               children:  [
                 const SettingListTile(
                   title: 'Change Language',
                   trailing:Padding(
                     padding: EdgeInsets.symmetric(horizontal: 15),
                     child: Text('EN'),
                   ),
                 ),
                 SettingListTile(
                   title: 'logout',
                   trailing:IconButton(onPressed: (){

                   }, icon: const Icon(Ionicons.log_out_outline),
                   ),
                 )
               ],
             ),
           )
         ],
       ),
    );
  }
}

class SocialMediaBtn extends StatelessWidget {
  const SocialMediaBtn({
    super.key,
    required this.image,
  });
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        height: 50,
        width: 50,
        padding: const EdgeInsets.all(8),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: black
        ),
        child: Image.asset(image),
      ),
    );
  }
}
