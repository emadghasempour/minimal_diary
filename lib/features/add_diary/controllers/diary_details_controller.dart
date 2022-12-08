import 'package:get/get.dart';
import 'package:minimal_diary/core/diary/controller/diary_controller.dart';
import 'package:minimal_diary_logic/database/model/diary/diary_model.dart';
import 'package:minimal_diary_logic/database/model/diary/relation.dart';

class DiaryDetailsController extends GetxController with StateMixin<DiaryData> {
  DiaryDetailsController(this.currentDiary);
  final DiaryData currentDiary;

  late Rx<DiaryData> diary;
  RxList<DiaryData> relations = <DiaryData>[].obs;

  late DiaryController _diaryController;
  @override
  void onInit() async {
    super.onInit();
    diary = currentDiary.obs;

    _diaryController = Get.find<DiaryController>();
    if (diary.value.relation != null) {
      relations.value = await getRelations();
    }
  }

  Future<void> createRelation(DiaryData other) async {
    if (diary.value.relation != null) {
      diary.value.relation!.relations.add(other.id);
    } else {
      diary.value = diary.value.copyWith(relation: Relation([other.id]));
    }
    _diaryController.editDiary(diary.value.toCompanion(true));

    if (other.relation != null) {
      other.relation!.relations.add(diary.value.id);
    } else {
      other = other.copyWith(relation: Relation([diary.value.id]));
    }
    _diaryController.editDiary(other.toCompanion(true));

    relations.value = await getRelations();
  }

  Future<void> RemoveRelation(DiaryData other) async {
    diary.value.relation!.relations.remove(other.id);
    _diaryController.editDiary(diary.value.toCompanion(true));

    other.relation!.relations.remove(diary.value.id);
    _diaryController.editDiary(other.toCompanion(true));

    relations.value = await getRelations();
  }

  Future<List<DiaryData>> getRelations() async {
    return await _diaryController
        .getDiaryListById(diary.value.relation!.relations);
  }
}
