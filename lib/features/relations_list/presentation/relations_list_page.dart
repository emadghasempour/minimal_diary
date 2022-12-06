import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/features/add_diary/presentation/add_diary_page.dart';
import 'package:minimal_diary/features/create_relation/presentation/create_relation_page.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list_item.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';

class RelationsList extends StatefulWidget {
  const RelationsList({required this.diary, Key? key}) : super(key: key);

  final DiaryData diary;

  @override
  State<RelationsList> createState() => _RelationsListState();
}

class _RelationsListState extends State<RelationsList> {
  late DiaryController _diaryController;
  late DiaryData _diary;
  @override
  void initState() {
    super.initState();
    _diaryController = Get.find<DiaryController>();
    _diary = widget.diary;
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
      body: _diary.relation != null
          ? FutureBuilder(
              future:
                  _diaryController.getDiaryListById(_diary.relation!.relations),
              builder: (context, AsyncSnapshot<List<DiaryData>> snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return DiaryListItem(
                      title: snapshot.data?[index].title ?? '',
                      date: snapshot.data?[index].date,
                      onTap: () {
                        Get.to(
                          AddDiaryPage(
                            diary: snapshot.data?[index],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            )
          : SizedBox.shrink(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            CreateRelationPage(
              diary: _diary,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
