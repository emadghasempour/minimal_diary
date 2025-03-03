import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/features/add_diary/controllers/diary_details_controller.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list_item.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:minimal_diary_logic/database/model/diary/relation.dart';
import 'package:theme_provider/text_styles.dart';
import 'package:theme_provider/theme_provider.dart';

class CreateRelationPage extends StatefulWidget {
  const CreateRelationPage({required this.diary, Key? key}) : super(key: key);

  final DiaryData diary;

  @override
  State<CreateRelationPage> createState() => _CreateRelationPageState();
}

class _CreateRelationPageState extends State<CreateRelationPage> {
  late DiaryController _diaryController;
  late DiaryDetailsController _diaryDetailsController;

  @override
  void initState() {
    super.initState();
    _diaryController = Get.find<DiaryController>();
    _diaryDetailsController = Get.find<DiaryDetailsController>(tag: widget.diary.id.toString());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ThemeProvider.margin16),
        child: _buildDiaryList()
      ),
    );
  }

  Widget _buildDiaryList() => ListView.builder(
            itemCount: _diaryController.diaries.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => DiaryListItem(
              title: _diaryController.diaries[index].title,
              content: _diaryController.diaries[index].diary,
              date: _diaryController.diaries[index].date,
              onTap: () async{
                /* late DiaryData source;
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
                _diaryController.editDiary(source.toCompanion(true)); */
                
                await _diaryDetailsController.createRelation(_diaryController.diaries[index]);
                Get.back();
              },
            ),
        );
}
