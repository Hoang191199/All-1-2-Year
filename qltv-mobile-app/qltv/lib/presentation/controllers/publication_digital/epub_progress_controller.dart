import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:qltv/domain/entities/response_no_date.dart';
import 'package:qltv/domain/usecases/bookcase_progress_use_case.dart';

class EpubProgressController extends GetxController {
  EpubProgressController(this.bookcaseProgressUseCase);

  final BookcaseProgressUseCase bookcaseProgressUseCase;

  var responseData = Rx<ResponseNoData?>(null);

  sentProgressRead(int item_id, int progress, String chapter, int words_per_page, String font_family, double font_size_multiplier, int page, int inner_page) async {
    final response = await bookcaseProgressUseCase.execute(Tuple8(item_id, progress, chapter, words_per_page, font_family, font_size_multiplier, page, inner_page));
    responseData.value = response;
  }
}
