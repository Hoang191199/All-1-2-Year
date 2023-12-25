import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/epub/saved_note.dart';
import 'package:qltv/domain/entities/epub/saved_note_range_data.dart';
import 'package:qltv/domain/entities/highlight.dart';
import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/usecases/highlight_add_use_case.dart';
import 'package:qltv/domain/usecases/highlight_delete_use_case.dart';
import 'package:qltv/domain/usecases/highlight_list_use_case.dart';
import 'package:qltv/domain/usecases/highlight_update_use_case.dart';

class EpubHighlightController extends GetxController {
  EpubHighlightController(
    this.highlightListUseCase,
    this.highlightAddUseCase,
    this.highlightUpdateUseCase,
    this.highlightDeleteUseCase,
  );

  final HighlightListUseCase highlightListUseCase;
  final HighlightAddUseCase highlightAddUseCase;
  final HighlightUpdateUseCase highlightUpdateUseCase;
  final HighlightDeleteUseCase highlightDeleteUseCase;

  final isLoading = false.obs;
  final isLoadingAddEdit = false.obs;
  final isLoadingDelete = false.obs;
  var responseData = Rx<ResponseDataArrayObject<Highlight>?>(null);
  var highlightsData = RxList<Highlight?>([]);
  var responseAddEdit = Rx<ResponseNoData?>(null);
  var responseDelete = Rx<ResponseNoData?>(null);
  var savedNotes = RxList<SavedNote>([]);

  late TextEditingController titleInputController;
  late TextEditingController descriptionInputController;

  @override
  void onInit() {
    super.onInit();
    titleInputController = TextEditingController(text: '');
    descriptionInputController = TextEditingController(text: '');
  }

  getListHighlight(int itemId) async {
    isLoading.value = true;
    final response = await highlightListUseCase.execute(itemId);
    responseData.value = response;
    highlightsData.assignAll(response.data?.data ?? []);
    if (!(response.error ?? false)) {
      List<SavedNote> listSavedNote = [];
      for (var element in (response.data?.data ?? [])) {
        SavedNote savedNote = SavedNote(
          id: element?.id ?? 0, 
          highlightedText: element?.metadata?.highlightText ?? '', 
          description: element?.metadata?.description ?? '',
          color: element?.metadata?.color ?? '', 
          page: element?.metadata?.page ?? 0, 
          rangesData: [
            SavedNoteRangeData(
              startNodeIndex: element?.metadata?.startNodeIndex ?? 0, 
              endNodeIndex: element?.metadata?.endNodeIndex ?? 0, 
              startOffset: element?.metadata?.startOffset ?? 0, 
              endOffset: element?.metadata?.endOffset ?? 0
            )
          ]
        );
        listSavedNote.add(savedNote);
      }
      savedNotes.assignAll(listSavedNote);
    }
    isLoading.value = false;
  }

  addHighlight(int itemId, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset) async {
    isLoadingAddEdit.value = true;
    final response = await highlightAddUseCase.execute(Tuple10(itemId, title, highlightText, description, color, page, startNodeIndex, endNodeIndex, startOffset, endOffset));
    responseAddEdit.value = response;
    isLoadingAddEdit.value = false;
  }

  updateHighlight(int id, String title, String highlightText, String description, String color, int page, int startNodeIndex, int endNodeIndex, int startOffset, int endOffset) async {
    isLoadingAddEdit.value = true;
    final response = await highlightUpdateUseCase.execute(Tuple10(id, title, highlightText, description, color, page, startNodeIndex, endNodeIndex, startOffset, endOffset));
    responseAddEdit.value = response;
    isLoadingAddEdit.value = false;
  }

  deleteHighlight(int itemId) async {
    isLoadingDelete.value = true;
    final response = await highlightDeleteUseCase.execute(itemId);
    responseDelete.value = response;
    isLoadingDelete.value = false;
  }
}