import 'package:flutter/material.dart';
import 'package:minimal_diary/core/helpers/index.dart';
import 'package:theme_provider/text_styles.dart';
import 'package:theme_provider/theme_provider.dart';

class DiaryListItem extends StatelessWidget {
  const DiaryListItem({
    required this.title,
    this.date,
    this.onTap,
    this.onLongPress,
    Key? key,
  }) : super(key: key);

  final String title;

  final DateTime? date;

  final void Function()? onTap;
  final void Function()? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: new BorderSide(color: Colors.black26, width: 1.0),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.all(Radius.circular(ThemeProvider.margin04)),
        onLongPress: onLongPress,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ThemeProvider.margin08,
                vertical: ThemeProvider.margin16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(flex: 2, child: Text(title, style: TextStyles.body1.copyWith(fontSize: 17))),
                if (date != null)
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        getFormattedDate(date!),
                        style: TextStyles.overline.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
