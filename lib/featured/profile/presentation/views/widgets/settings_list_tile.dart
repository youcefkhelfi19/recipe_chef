import 'package:flutter/material.dart';

import '../../../../../utils/app_texts.dart';

class SettingListTile extends StatelessWidget {
  const SettingListTile({
    super.key, required this.title, required this.trailing,
  });
  final String title;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: style20,),
      trailing: trailing,
    );
  }
}
