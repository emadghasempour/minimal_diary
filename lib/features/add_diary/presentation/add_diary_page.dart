import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/functions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/core/extensions/index.dart';
import 'package:minimal_diary/core/helpers/index.dart';
import 'package:minimal_diary/features/add_diary/controllers/diary_details_controller.dart';
import 'package:minimal_diary/features/create_relation/presentation/create_relation_page.dart';
import 'package:minimal_diary/features/diary_list/presentation/widgets/diary_list_item.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:theme_provider/text_styles.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  DiaryDetailsController? _diaryDetailsController;
  late DiaryCompanion _diaryCompanion;

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

  Widget _buildAddDiaryPage() => WillPopScope(
        onWillPop: (() async {
          await _saveDiary();
          return true;
        }),
        child: Scaffold(
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
                DetectableTextField(
                  controller: _textController,
                  basicStyle: TextStyles.body1Light.copyWith(fontSize: 17),
                  enabled: true,
                  maxLines: null,
                  autocorrect: false,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Note',
                  ),
                  detectionRegExp: detectionRegExp(
                      url: true, atSign: false, hashtag: false)!,
                  onTap: () {
                    /* List<String> urls = extractDetections(_textController.text, detectionRegExp(atSign: false,hashtag: false)!);
                    if(urls.isNotEmpty){
                      TextSpan span =  _textController.buildTextSpan(context: context, withComposing: true);
                      print('hello');
                      //launchUrlString(urls.first,mode: LaunchMode.externalApplication);
                    } */
                    int selectionIndex = _textController.selection.baseOffset;
                    String txt = _textController.text;
                    List<String> urls = extractDetections(_textController.text,
                        detectionRegExp(atSign: false, hashtag: false)!);
                    urls.forEach((element) {
                      int startIndex = txt.indexOf(element);
                      if (selectionIndex > startIndex &&
                          selectionIndex < (startIndex + element.length - 1)) {
                        _showUrlsBottomSheet(context, element);
                      }
                    });
                  },
                ),
                _buildRelationsWidget(),
              ],
            ),
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
    if (!_titleController.value.text.isNotEmpty &&
        !_textController.value.text.isNotEmpty) {
      _diaryController.removeDiary(_diaryData!);
      return;
    }
    _diaryCompanion.copyWith(
      title: drift.Value<String>(_titleController.value.text),
      diary: drift.Value<String>(_textController.value.text),
      userId: drift.Value<int>(1),
      date: drift.Value<DateTime>(DateTime.now()),
    );

    if (_diaryData != null) {
      await _diaryController.editDiary(_diaryData!.toCompanion(true));
    } else
      await _diaryController.saveDiary(_diaryCompanion);
  }

  Future<void> _initializeDiaryData(DiaryData? diaryData) async {
    _diaryCompanion = DiaryCompanion(
      id: _diaryData != null
          ? drift.Value<int>(_diaryData!.id)
          : drift.Value.absent(),
      userId: drift.Value<int>(1),
      date: drift.Value<DateTime>(DateTime.now()),
    );

    int savedId = await _diaryController.saveDiary(_diaryCompanion);
    _diaryData = (await _diaryController.getDiaryListById([savedId])).first;
    _diaryDetailsController = Get.put(DiaryDetailsController(_diaryData!),
        tag: _diaryData!.id.toString());
    if (_diaryData != null) {
      _titleController.text = _diaryData?.title ?? '';
      _textController.text = _diaryData?.diary ?? '';
    } else {
      if (Get.arguments != null) {
        _textController.text = Get.arguments['content'] ?? '';
      }
    }

    _diaryCompanion = _diaryData!.toCompanion(true);
  }

  bool get isEditMode => _diaryData != null;

  _buildAppBar() => AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            await _saveDiary();
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp),
        ),
        actions: [
          /* IconButton(
            onPressed: () async {
              await _saveDiary();
              Navigator.pop(context);
            },
            icon: Icon(Icons.done),
          ), */

          IconButton(
            onPressed: () async {
              _showShareBottomSheet(context);
            },
            icon: Icon(Icons.share_outlined),
          ),
          IconButton(
            onPressed: () async {
              _showSnackBar('Will add a reminder for this card');
            },
            icon: Icon(Icons.add_alert_outlined),
          ),
          IconButton(
            onPressed: () async {
              _showCreateRelationBottomSheet(context);
            },
            icon: Icon(Icons.add_link),
          ),
        ],
      );

  Widget _buildRelationsList() => _diaryDetailsController == null
      ? SizedBox.shrink()
      : Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _diaryDetailsController?.relations.length,
            itemBuilder: (BuildContext context, int index) => DiaryListItem(
              title: _diaryDetailsController!.relations[index].title,
              content: _diaryDetailsController!.relations[index].diary,
              date: _diaryDetailsController!.relations[index].date,
              onTap: () {
                Get.to(
                  AddDiaryPage(
                    diary: _diaryDetailsController!.relations[index],
                  ),
                  preventDuplicates: false,
                );
              },
              onLongPress: () => _showRemoveRelationBottomSheet(
                  context, _diaryDetailsController!.relations[index]),
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
                    _diaryDetailsController!.RemoveRelation(other);
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
                    Get.to(()=>CreateRelationPage(diary: _diaryData!));
                  },
                ),
                ListTile(
                  title: Text('Image (Soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Relate an Image to this card');
                  },
                ),
                ListTile(
                  title: Text('Recording (Soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Relate a Recording to this card');
                  },
                ),
                ListTile(
                  title: Text('File (Soon)'),
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

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Share With QR Code (Soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Share With QR Code');
                  },
                ),
                ListTile(
                  title: Text('Share As Image (Soon)'),
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar('Will Share As Image To Export');
                  },
                ),
              ],
            ),
          );
        });
  }

  void _showUrlsDialog(BuildContext context, String url) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    title: Text('Open URL'),
                    onTap: () {
                      Navigator.pop(context);
                      launchUrlString(url,
                          mode: LaunchMode.externalApplication);
                    },
                  ),
                  ListTile(
                    title: Text('Edit'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showUrlsBottomSheet(BuildContext context, String url) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text('Open URL'),
                  onTap: () {
                    Navigator.pop(context);
                    launchUrlString(url, mode: LaunchMode.externalApplication);
                  },
                ),
                ListTile(
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(context);
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

  void launchProject() {}
}
