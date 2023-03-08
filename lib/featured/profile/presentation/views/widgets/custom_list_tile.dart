import 'package:flutter/material.dart';

import '../../../../../utils/app_texts.dart';


class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key, required this.leading, required this.title, required this.subtitle,  this.trailing, this.onTap,
  });
  final IconData leading;
  final IconData? trailing;
  final String title;
  final Widget subtitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title,style: style20,),
      subtitle: subtitle,

      leading: Icon(leading),
      trailing: IconButton(
        onPressed: (){onTap!();},
        icon: Icon(trailing),
      ),
    );
  }
}
