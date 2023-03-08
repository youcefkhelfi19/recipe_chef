import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:recipe_chef/utils/app_routes.dart';
import 'package:recipe_chef/utils/app_texts.dart';

import '../../../../services/global_functions/show_toast.dart';
import '../view_models/auth_cubit.dart';


class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if(state is AuthLoading){
        }else if(state is AuthSuccess){
          Navigator.pushReplacementNamed(context, mainRoute);
          customToast(msg: 'Welcome', color: black);

        }else if(state is AuthFailed){
          customToast(msg: state.errMsg, color: red);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Sign In', style: style24.copyWith(
                      fontSize: 26
                  ),),
                  const SizedBox(height: 10,),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Continue with', style: style20.copyWith(color: green),)),
                  const SizedBox(height: 100,),
                  SizedBox(
                    width: 150,
                    child: MaterialButton(
                      color: Colors.white,
                      height: 50,
                      minWidth: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).
                        googleSingIn();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/gg.png', width: 20, height: 20,),
                          const Text('Google', style: style20,)
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: 150,
                    child: MaterialButton(
                      color: blue,
                      height: 50,
                      minWidth: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).
                        facebookSingIn();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset(
                            'assets/images/fb.png', width: 20, height: 20,),
                          Text('Facebook',
                            style: style20.copyWith(color: Colors.white),)
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            state.isLoading? Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black12,
              alignment: Alignment.center,
              child: Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                 color: black,
                  borderRadius: BorderRadius.circular(10)

                ),
                child: const CircularProgressIndicator(
                  backgroundColor: mainColor,
                  color: green,
                )
              ),
            ):const SizedBox(),
          ],
        );
      },
    );
  }
}
