import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../services/locator.dart';
import '../../../../utils/app_texts.dart';
import '../../../../utils/aseets_paths.dart';
import '../view_models/admin_cubit.dart';
import 'widgets/alert_dialog.dart';
import 'widgets/custom_list_tile.dart';
import 'widgets/profile_image.dart';
import 'widgets/settings_list_tile.dart';
import 'widgets/social_media_btn.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AdminCubit>(
  create: (context) => AdminCubit()..fetchAdminData(id: getIt.get<GetStorage>().read('id')),

  child: Scaffold(
       body: BlocBuilder<AdminCubit, AdminState>(
  builder: (context, state) {
    if(state is AdminSuccess){
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          ProfileImage(imageUrl: state.admin.imageLink,),
          Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Icon(Icons.edit_outlined,color: Colors.transparent,),
                  const SizedBox(width: 5,),
                   Text(state.admin.username,style: style24,),
                  const SizedBox(width: 5,),
                  InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return  const CustomAlertDialog(
                            fieldName: 'username',
                            hintText: 'Username',
                          );
                        });
                      },
                      child: const Icon(Icons.edit_outlined))
                ],
              )),
          const SizedBox(height: 20,),
          const Text('Social Media'),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:  const [
              SocialMediaBtn(
                image: youtube,
                fieldName: 'youtubeLink',
                hintText: 'Youtube chanel Link',

              ),
              SocialMediaBtn(
                image: instagram,
                fieldName:  'instagramLink',
                hintText: 'Instagram Page',


              ),
              SocialMediaBtn(
                image: facebook,
                fieldName: 'facebookLink',
                hintText: 'Facebook Page Link',


              ),
              SocialMediaBtn(
                image: tiktok,
                fieldName: 'tiktokLink',
                hintText: 'TikTok Account Link',
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
                  subtitle: Text(state.admin.email,style: style20.copyWith(color: Colors.grey),),
                  leading: Ionicons.mail_outline,
                ) ,
                CustomListTile(
                  title: 'Phone',
                  subtitle:  Text(state.admin.phoneNumber,style: style20.copyWith(color: Colors.grey),),
                  leading: Ionicons.call_outline,
                  trailing: Icons.edit_outlined,
                  onTap: (){
                    showDialog(context: context, builder: (context){
                      return  const CustomAlertDialog(
                        fieldName: 'phoneNumber',
                        hintText: 'Phone number',
                        isNumber: false,
                      );
                    });
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
      );

    }if(state is AdminFailed){
      return const Center(child: Text('cant load data'),);
    }
    return const Center(child: CircularProgressIndicator());
  },
),
    ),
);
  }
}


