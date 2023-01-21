import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary/core/helpers/dialog_helper.dart';
import 'package:minimal_diary/core/widgets/diary_list_view.dart';
import 'package:minimal_diary/features/add_diary/presentation/add_diary_page.dart';
import 'package:minimal_diary/features/diary_list/presentation/diary_list_page.dart';
import 'package:minimal_diary/features/search_page/widgets/search_edit_text.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:theme_provider/text_styles.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchEditTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Colors.white,
        elevation: 0,
        title: GestureDetector(
          child: Text('Footprint'),
          onTap: () async => await showFootprintAboutDialog(context),
        ),
        titleTextStyle: TextStyles.lightTitle.copyWith(color: Colors.grey),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchEditText(
                textEditingController: _searchEditTextController,
                onSubmitted: (query) async {
                  doSearchAndShowList(query);
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          doSearchAndShowList(_searchEditTextController.text);
                        },
                        child: Text('Search')),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                        onPressed: () {
                          showAllList();
                        },
                        child: Text('Show All Cards')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AddDiaryPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> doSearchAndShowList(String query) async {
    List<DiaryData> result =
        await Get.find<DiaryController>().searchDiaries(query);
    Get.to(DiaryListView(items: result));
  }

  Future<void> showAllList() async {
    List<DiaryData> result = await Get.find<DiaryController>().diaries;
    Get.to(DiaryListView(items: result,));
  }
}
