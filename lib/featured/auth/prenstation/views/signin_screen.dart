import 'package:flutter/material.dart';
import 'package:recipe_chef/utils/app_colors.dart';
import 'package:recipe_chef/utils/app_texts.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
           Text('Sign In',style: style24.copyWith(
            fontSize: 26
          ),),
          const SizedBox(height: 10,),
          Align(
              alignment: Alignment.center,
              child: Text('Continue with',style: style20.copyWith(color: green),)),
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
                onPressed: (){
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/gg.png',width: 20,height: 20,),
                    const Text('Google',style: style20,)
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
                onPressed: (){
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/fb.png',width: 20,height: 20,),
                     Text('Facebook',style: style20.copyWith(color: Colors.white),)
                  ],
                ),
                ),
          ),

        ],
      ),
    );
  }
}
