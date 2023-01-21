import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:theme_provider/text_styles.dart';
import 'package:minimal_diary/core/extensions/index.dart';
import 'package:theme_provider/theme_provider.dart';

Future<void> showFootprintAboutDialog(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Center(
                      child: Text(
                    'Footprint',
                    style: TextStyles.lightTitle,
                  )),
                  Center(
                      child: Text(
                    '${context.localization.labelVersion}: ${packageInfo.version}',
                    style: TextStyles.caption,
                  )),
                  SizedBox(height: ThemeProvider.margin16),
                  Center(
                      child: Text(
                    'Thank you for testing ❤✌',
                    style: TextStyles.caption,
                  )),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text(context.localization.labelClose),
                  onPressed: () => Navigator.of(context).pop()),
            ],
          );
        });
  }