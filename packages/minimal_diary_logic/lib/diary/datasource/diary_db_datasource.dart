import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:minimal_diary_logic/diary/datasource/base_diary_datasource.dart';

class DiaryDbDataSource extends BaseDiaryDatasource {
  @override
  Future<List<DiaryData>> fetchDiaryList({List<int>? ids}) => ids == null
      ? MyDatabase.instance.fetchCanvasList
      : MyDatabase.instance.getDiaryListById(ids);

  @override
  Future<DiaryData> fetchSingleDiary(int id) async {
    return await MyDatabase.instance.getSingleDiaryById(id);
  }

  @override
  Future<int> storeDiary(DiaryCompanion diaryCompanion) async {
    return await MyDatabase.instance.insertDiary(diaryCompanion);
  }

  @override
  Future<bool> updateDiary(DiaryCompanion diaryCompanion) async {
    return await MyDatabase.instance.updateDiary(diaryCompanion);
  }

  @override
  Future<List<DiaryData>> queryDiaries(String queryString) async {
    return await MyDatabase.instance.searchQuery(queryString);
  }

  @override
  Future<int> deleteDiary(DiaryData diaryData) async {
    return await MyDatabase.instance.deleteDiary(diaryData);
  }
}
