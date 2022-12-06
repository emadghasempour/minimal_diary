import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list_item.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:minimal_diary_logic/database/model/diary/relation.dart';
import 'package:theme_provider/theme_provider.dart';

class CreateRelationPage extends StatefulWidget {
  const CreateRelationPage({required this.diary, Key? key}) : super(key: key);

  final DiaryData diary;

  @override
  State<CreateRelationPage> createState() => _CreateRelationPageState();
}

class _CreateRelationPageState extends State<CreateRelationPage> {
  late DiaryController _diaryController;

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
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: _buildDiaryList(),
    );
  }

  Widget _buildDiaryList() => Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeProvider.margin16),
        child: Obx(
          () => ListView.builder(
            itemCount: _diaryController.diaries.length,
            itemBuilder: (BuildContext context, int index) => DiaryListItem(
              title: _diaryController.diaries[index].title ?? '',
              date: _diaryController.diaries[index].date,
              onTap: () {
                late DiaryData source;
                late DiaryData dest;
                if(widget.diary.relation!=null){
                  widget.diary.relation!.relations.add(_diaryController.diaries[index].id);
                  dest = widget.diary;
                }else{
                  dest = widget.diary.copyWith(relation: Relation([_diaryController.diaries[index].id]));
                }
                _diaryController.editDiary(dest.toCompanion(true));


                if(_diaryController.diaries[index].relation!=null){
                _diaryController.diaries[index].relation!.relations.add(widget.diary.id);
                source = _diaryController.diaries[index];
                }else{
                  source = _diaryController.diaries[index].copyWith(relation: Relation([widget.diary.id]));
                }
                _diaryController.editDiary(source.toCompanion(true));

                Get.back();
              },
            ),
          ),
        ),
      );
}
