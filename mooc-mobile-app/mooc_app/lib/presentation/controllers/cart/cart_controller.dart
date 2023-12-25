import 'package:get/get.dart';
import 'package:mooc_app/app/services/database_helper.dart';
import 'package:mooc_app/domain/entities/cart.dart';
import 'package:mooc_app/domain/entities/course.dart';
import 'package:mooc_app/domain/entities/response_data_array_object.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:mooc_app/domain/usecases/cart_use_case.dart';
import 'package:mooc_app/presentation/controllers/auth/auth_controller.dart';

class CartController extends GetxController {
  CartController(this.cartUseCase);

  final CartUseCase cartUseCase;

  final isLoading = false.obs;
  var listCart = RxList<Cart?>([]);
  var responseData = Rx<ResponseDataArrayObject<Course>?>(null);
  var listCourseInCart = RxList<Course?>([]);

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    fetchCartData();
    super.onInit();
  }

  fetchCartData() async {
    isLoading(true);
    UserSSO? userLogin = authController.userLogin;
    final cartList = await DatabaseHelper.db.getCartLocalList(userLogin == null ? 1 : (userLogin.id ?? 1));
    listCart.value = cartList;
    List<int> idCourses = [];
    if (cartList.isNotEmpty) {
      for (var element in cartList) {
        idCourses.add(element.course_id);
      }
      final response = await cartUseCase.execute(idCourses);
      responseData.value = response;
      listCourseInCart.value = response.data ?? [];
    }
    isLoading(false);
  }

  // double get totalPrice => listCart.fold(0, (sum, item) => sum + (item?.price ?? 0.0));

  int get numCoursesInCart => listCart.length;

  addCourseToCart(Course courseItem) async {
    UserSSO? userLogin = authController.userLogin;
    var cartItem = courseItem.parseCart(id: null, user_id: userLogin?.id ?? 1);
    await DatabaseHelper.db.insertCart(cartItem).then((id) {
      cartItem = courseItem.parseCart(id: id, user_id: userLogin?.id ?? 1);
      listCart.insert(0, cartItem);
    });
  }

  deleteCourseInCart(Course cartDelete) async {
    UserSSO? userLogin = authController.userLogin;
    final indexExist = listCart.indexWhere((element) => element?.course_id == cartDelete.id && element?.user_id == (userLogin?.id ?? 1));
    if (indexExist >= 0) {
      var result = await DatabaseHelper.db.deleteCart(listCart[indexExist]?.id ?? 0);
      if (result == 1) {
        listCart.remove(listCart[indexExist]);
      } else {
        await DatabaseHelper.db.deleteCart(listCart[indexExist]?.id ?? 0);
      }
    }
  }

  deleteCoursesInCart(List<Course> cartListDelete) async {
    UserSSO? userLogin = authController.userLogin;
    for (var cartDelete in cartListDelete) {
      final indexExist = listCart.indexWhere((element) => element?.course_id == cartDelete.id && element?.user_id == (userLogin?.id ?? 1));
      if (indexExist >= 0) {
        var result = await DatabaseHelper.db.deleteCart(listCart[indexExist]?.id ?? 0);
        if (result == 1) {
          listCart.remove(listCart[indexExist]);
        } else {
          await DatabaseHelper.db.deleteCart(listCart[indexExist]?.id ?? 0);
        }
      }
    }
  }

  resetCart() async {
    for (var cart in listCart) {
      var result = await DatabaseHelper.db.deleteCart(cart?.id ?? 0);
      if (result == 1) {
        listCart.remove(cart);
      } else {
        await DatabaseHelper.db.deleteCart(cart?.id ?? 0);
      }
    }
  }

}
