import 'package:flutter/material.dart';
import 'package:theme_provider/text_styles.dart';

class FootprintAppBar extends StatelessWidget {
  const FootprintAppBar({
    this.title,
    this.showBackButton = false,
    Key? key,
  }) : super(key: key);

  final Widget? title;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.grey),
      backgroundColor: Colors.white,
      elevation: 0,
      title: title != null ? title : null,
      centerTitle: true,
      titleTextStyle: TextStyles.lightTitle.copyWith(color: Colors.grey),
      leading: showBackButton
          ? IconButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_sharp),
            )
          : null,
    );
  }
}
