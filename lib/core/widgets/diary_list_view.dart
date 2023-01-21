import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/core/footprint_appbar.dart';
import 'package:minimal_diary/features/add_diary/controllers/diary_details_controller.dart';
import 'package:minimal_diary/features/add_diary/presentation/add_diary_page.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:theme_provider/text_styles.dart';

class DiaryListView extends StatefulWidget {
  const DiaryListView({this.items,Key? key}) : super(key: key);

  final List<DiaryData>? items;

  @override
  State<DiaryListView> createState() => _DiaryListViewState();
}

class _DiaryListViewState extends State<DiaryListView> {

  late DiaryController _diaryController;
  late DiaryDetailsController _diaryDetailsController;

   @override
  void initState() {
    super.initState();
    _diaryController = Get.find<DiaryController>();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('All Cards'),
        centerTitle: true,
        titleTextStyle: TextStyles.lightTitle.copyWith(color: Colors.grey),
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
      ),

      body: DiaryList(
        items: widget.items ?? [],
        onTap: (diary) {
          Get.to(()=> AddDiaryPage(diary: diary,));
        },
      ),
    );
  }
}