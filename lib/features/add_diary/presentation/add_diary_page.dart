import 'package:drift/drift.dart' as drift;
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/core/extensions/index.dart';
import 'package:minimal_diary/core/helpers/index.dart';
import 'package:minimal_diary/features/add_diary/controllers/diary_details_controller.dart';
import 'package:minimal_diary/features/create_relation/presentation/create_relation_page.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list_item.dart';
import 'package:minimal_diary/features/relations_list/presentation/relations_list_page.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:theme_provider/text_styles.dart';
import 'package:theme_provider/theme_provider.dart';

class AddDiaryPage extends StatefulWidget {
  static const String routeName = '/addDiary';

  const AddDiaryPage({this.diary, Key? key}) : super(key: key);

  final DiaryData? diary;

  @override
  State<AddDiaryPage> createState() => _AddDiaryPageState();
}

class _AddDiaryPageState extends State<AddDiaryPage> {
  late DiaryController _diaryController;
  late TextEditingController _titleController;
  late TextEditingController _textController;
  late DiaryDetailsController _diaryDetailsController;
  DiaryData? _diaryData;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _textController = TextEditingController();

    _diaryData = widget.diary;
    _diaryController = Get.find<DiaryController>();

    _initializeDiaryData(_diaryData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildAddDiaryPage(),
    );
  }

  Widget _buildAddDiaryPage() => Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: ThemeProvider.margin16),
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                style: TextStyles.lightTitle.copyWith(fontSize: 22),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: context.localization.hintTitle,
                ),
              ),
              if (isEditMode)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getFormattedDate(_diaryData!.date),
                      style: TextStyles.overline.copyWith(color: Colors.grey),
                    ),
                    SizedBox(height: ThemeProvider.margin08)
                  ],
                ),
              TextField(
                controller: _textController,
                style: TextStyles.body1Light.copyWith(fontSize: 17),
                enabled: true,
                maxLines: null,
                autocorrect: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Note',
                ),
              ),
              if (isEditMode) _buildRelationsWidget(),
            ],
          ),
        ),
      );

  Widget _buildRelationsWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: ThemeProvider.margin08),
          Text('Related Cards'),
          _buildRelationsList(),
        ],
      );

  Future<void> _saveDiary() async {
    DiaryCompanion currentDiary = DiaryCompanion(
      id: _diaryData != null
          ? drift.Value<int>(_diaryData!.id)
          : drift.Value.absent(),
      title: drift.Value<String>(_titleController.value.text),
      diary: drift.Value<String>(_textController.value.text),
      userId: drift.Value<int>(1),
      date: drift.Value<DateTime>(DateTime.now()),
    );
    if (_diaryData != null) {
      await _diaryController.editDiary(currentDiary);
    } else
      await _diaryController.saveDiary(currentDiary);
  }

  void _initializeDiaryData(DiaryData? diaryData) {
    if (_diaryData != null) {
      _diaryDetailsController = Get.put(DiaryDetailsController(_diaryData!),
          tag: _diaryData!.id.toString());
      _titleController.text = _diaryData?.title ?? '';
      _textController.text = _diaryData?.diary ?? '';
    } else if (Get.arguments != null) {
      _textController.text = Get.arguments['content'] ?? '';
    }
  }

  bool get isEditMode => _diaryData != null;

  _buildAppBar() => AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await _saveDiary();
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
          ),
          IconButton(
            onPressed: () async {
              _showSnackBar('Will add a reminder for this card');
            },
            icon: Icon(Icons.add_alert_outlined),
          ),
          if (widget.diary != null)
            IconButton(
              onPressed: () async {
                _showCreateRelationBottomSheet(context);
              },
              icon: Icon(Icons.add_link),
            )
        ],
      );

  Widget _buildRelationsList() => Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: _diaryDetailsController.relations.length,
          itemBuilder: (BuildContext context, int index) => DiaryListItem(
            title: _diaryDetailsController.relations[index].title ?? '',
            date: _diaryDetailsController.relations[index].date,
            onTap: () {
              Get.to(
                AddDiaryPage(
                  diary: _diaryDetailsController.relations[index],
                ),
                preventDuplicates: false,
              );
            },
            onLongPress: () => _showRemoveRelationBottomSheet(
                context, _diaryDetailsController.relations[index]),
          ),
        ),
      );

  void _showRemoveRelationBottomSheet(BuildContext context, DiaryData other) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Unrelate This Card'),
                  onTap: () {
                    _diaryDetailsController.RemoveRelation(other);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showCreateRelationBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,

        builder: (BuildContext context) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Another Card'),
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(CreateRelationPage(diary: widget.diary!));
                  },
                ),
                ListTile(
                  title: Text('Image (coming soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Relate an Image to this card');
                  },
                ),

                ListTile(
                  title: Text('Recording (coming soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Relate a Recording to this card');
                  },
                ),

                ListTile(
                  title: Text('File (coming soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Relate a File to this card');
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
