import 'package:get/get.dart';
import 'package:qltv/domain/entities/page.dart';
import 'package:qltv/domain/entities/publication.dart';
// import 'package:qltv/domain/entities/response_data_array_object.dart';
import 'package:qltv/domain/entities/response_data_object.dart';
import 'package:qltv/domain/usecases/book_detail_user_case.dart';
import 'package:qltv/domain/usecases/home_use_case.dart';

class HomeController extends GetxController {
  HomeController(this.homeUseCase, this.publicationDetail);

  final HomeUseCase homeUseCase;
  final BookDetailUseCase publicationDetail;

  final isLoading = false.obs;
  final isLoadingDetail = false.obs;
  var responseData = Rx<ResponseDataObject<Page>?>(null);
  var homeData = Rx<Page?>(null);
  var responseDetail = Rx<ResponseDataObject<Publication>?>(null);

  final indexModelFocus = 0.obs;

  fetchData() async {
    isLoading(true);
    final responseHome = await homeUseCase.execute();
    responseData.value = responseHome;
    homeData.value = responseHome.data;
    isLoading(false);
  }

  fetchPublicationDetail(int id) async {
    isLoadingDetail(true);
    await Future.delayed(const Duration(milliseconds: 200));
    final dataDetailResponse = await publicationDetail.execute(id);
    responseDetail.value = dataDetailResponse;
    isLoadingDetail(false);
  }

  changeIndexModelFocus(int index) {
    indexModelFocus.value = index;
  }
}
