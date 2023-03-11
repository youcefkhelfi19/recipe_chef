import 'package:flutter/material.dart';

import '../app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
