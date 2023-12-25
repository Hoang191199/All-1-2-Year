import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/presentation/controllers/infomation/infomation_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_binding.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/child_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/list_student/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/manager/manager_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/splash/splash_controller.dart';
import 'package:mobiedu_kids/presentation/pages/chose/chose_class.dart';
import 'package:mobiedu_kids/presentation/pages/chose/chose_school.dart';
import 'package:mobiedu_kids/presentation/pages/manager/parents/list/student_data_page.dart';
import 'package:mobiedu_kids/presentation/pages/manager/widget/class_manager.dart';
import 'package:mobiedu_kids/presentation/widgets/avatar_error.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ManagerPage extends StatelessWidget {
  ManagerPage({super.key});

  final store = Get.find<LocalStorageService>();
  final infoUser = Get.find<SplashScreenController>();
  final managerController = Get.put(ManagerController());
  final informationController = Get.find<InformationController>();
  final childController = Get.find<ChildController>();
  final imageChildController = Get.put(ImageChildController());

  @override
  Widget build(BuildContext context) {
    return infoUser.responseManagerData.value?.data?.classes?.isNotEmpty ?? false ? 
    CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        padding: const EdgeInsetsDirectional.only(top: 12.0, start: 25.0),
        middle: GestureDetector(
          onTap: () {
            Get.to(() => ChoseClass());
          },
          child: Text(store.getGrouptitle,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: AppColors.primary,
                fontSize: 22.0,
                fontWeight: FontWeight.w700,
              ),
            )
          ),
        ),
        backgroundColor: Colors.white,
        border: const Border(),
        leading: GestureDetector(
          onTap: () {
            Get.off(() => ChoseSchool());
          },
          child: Icon(
            CupertinoIcons.home,
            color: AppColors.primary,
            size: 22.0,
          ),
        ),
      ),
      child: SizedBox(
        height: double.infinity,
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          childAspectRatio: 1.0,
          physics: const AlwaysScrollableScrollPhysics(),
          children: List.generate(
            listItemService.length,
            (index) => ClassManager(
              item: listItemService[index],
            ),
          )
        ),
      ),
    ) : 
    GetX(
      init: childController,
      initState: (state) {

      },
      builder: (_) => Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child:  Container(
            margin: const EdgeInsets.only(top: 12.0),
            child: CupertinoPageScaffold(
              resizeToAvoidBottomInset: false,
              navigationBar: CupertinoNavigationBar(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 28.0),
                leading: GestureDetector(
                  onTap: () {
                    ChildBinding().dependencies();
                    Get.to(() => DetailStudentPage(child_parent_id:store.getChild?.child_parent_id ?? ""));
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Bé ',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: '${store.getChild?.child_name} \n',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Lớp ${store.getChild?.group_title} \n',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        TextSpan(
                          text: 'Trường ${store.getChild?.page_title}',
                          style: GoogleFonts.raleway(
                            textStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ]
                    )
                  )
                ),
                trailing: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: const Text('Lựa chọn tùy chỉnh trẻ'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              showModalBottomSheet(
                                backgroundColor:Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: ((builder) => GetBuilder<ImageChildController>(
                                  builder: ((_) => imageChildController.reloading.value ?
                                   WillPopScope(
                                    onWillPop: () async {return false;} , 
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.transparent
                                      ),
                                      child: const Center(
                                        child: CircularLoadingIndicator()
                                      )
                                    )
                                  ) : 
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white),                
                                    height: 120.0,
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Chọn ảnh",
                                          style: GoogleFonts.raleway(
                                            textStyle: TextStyle(
                                              color: AppColors.black, 
                                              fontSize: 20.0, 
                                              fontWeight: FontWeight.w700
                                            )
                                          ),
                                        ),
                                        const SizedBox(height: 20.0),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: <Widget>[
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.camera,
                                                color: AppColors.pink,
                                              ),
                                              onPressed: () async {
                                                imageChildController.reloading.value = true;
                                                imageChildController.update(); 
                                                imageChildController.imageFile = XFile("");
                                                await imageChildController.capturecamera(store.getPagename);
                                                if(imageChildController.imageFile?.path != "" && imageChildController.imageFile?.path != null){
                                                  final file = await imageChildController.imageFile!.readAsBytes();
                                                  await childController.upload(store.getChild?.child_parent_id ?? "", file);
                                                  imageChildController.resetImageFile();
                                                  infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture = store.getChild?.child_picture;
                                                }
                                                imageChildController.update(); 
                                                imageChildController.reloading.value = false;
                                                imageChildController.update();  
                                                Navigator.pop(context); 
                                                Navigator.pop(context);
                                              },
                                              label: Text(
                                                "camera".tr,
                                                style:TextStyle(
                                                  color:AppColors.pink,
                                                ),
                                              ),
                                            ),
                                            TextButton.icon(
                                              icon: Icon(
                                                Icons.image,
                                                color: AppColors.pink,
                                              ),
                                              onPressed: () async {
                                                imageChildController.reloading.value = true;
                                                imageChildController.update();
                                                imageChildController.imageFile = XFile("");
                                                await imageChildController.capturegallery(store.getPagename);
                                                if(imageChildController.imageFile?.path != "" && imageChildController.imageFile?.path != null){
                                                  final file = await imageChildController.imageFile!.readAsBytes();
                                                  await childController.upload(store.getChild?.child_parent_id ?? "", file);
                                                  imageChildController.resetImageFile();
                                                  infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture = store.getChild?.child_picture;
                                                }
                                                imageChildController.update(); 
                                                imageChildController.reloading.value = false;
                                                imageChildController.update();    
                                                Navigator.pop(context); 
                                                Navigator.pop(context);
                                              },
                                              label: Text(
                                                "gallery".tr,
                                                style: TextStyle(
                                                  color: AppColors.pink),
                                              ),
                                            ),
                                          ]
                                        )
                                      ],
                                    ),
                                  )
                                ),
                              )
                            )
                          );
                        },
                        child: const Text('Thay ảnh đại diện'),
                      ),
                    ],
                  ),
                );
              },
              child: childController.reloading.value ? 
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                  width: 46.0,
                  height: 46.0,
                  child: CircularLoadingIndicator())]) : 
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 46.0,
                        height: 46.0,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: ClipOval(
                          child: infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture == null || (infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture?.isEmpty ?? false)
                        ? Image.asset(
                            'assets/images/avatar-mac-dinh.png',
                            fit: BoxFit.cover
                          )
                        : CachedNetworkImage(
                            imageUrl:'${infoUser.responseManagerData.value?.data?.children?[informationController.indexChild.value].child_picture}',
                            progressIndicatorBuilder: (context,url, downloadProgress) =>Container(),
                            errorWidget:(context, url, error) =>const AvatarError(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                )
              ),
              backgroundColor: Colors.white,
              border: const Border(),
              ),
              child: SizedBox(
                height: double.infinity,
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: 1.0,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: List.generate(
                    listItemParentService.length,
                    (index) => ClassManager(item: listItemParentService[index]),
                  )
                ),
              )
            )
          )
        )
      )
    );
  }
}

List<ListItemService> listItemService = [
  ListItemService(
      title: 'Điểm danh',
      icon: 'assets/images/people.png',
      typeTitle: 'diem-danh'),
  ListItemService(
      title: 'Thực đơn',
      icon: 'assets/images/restaurant.png',
      typeTitle: 'thuc-don'),
  ListItemService(
      title: 'Lịch học',
      icon: 'assets/images/calendar.png',
      typeTitle: 'lich-hoc'),
  ListItemService(
      title: 'Nhận xét',
      icon: 'assets/images/remark.png',
      typeTitle: 'nhan-xet'),
  ListItemService(
      title: 'Ngủ', icon: 'assets/images/ngu.png', typeTitle: 'ngu'),
  ListItemService(
      title: 'Vệ sinh',
      icon: 'assets/images/ve_sinh.png',
      typeTitle: 've-sinh'),
  ListItemService(
      title: 'Đón muộn', icon: 'assets/images/time.png', typeTitle: 'don-muon'),
  ListItemService(
      title: 'Đơn thuốc',
      icon: 'assets/images/pill.png',
      typeTitle: 'don-thuoc'),
  ListItemService(
      title: 'Học phí', icon: 'assets/images/dolar.png', typeTitle: 'hoc-phi'),
  ListItemService(
      title: 'Thông báo',
      icon: 'assets/images/bell.png',
      typeTitle: 'thong-bao'),
  ListItemService(
      title: 'Dịch vụ', icon: 'assets/images/bus.png', typeTitle: 'dich-vu'),
  ListItemService(
      title: 'Nhật ký',
      icon: 'assets/images/clipboard.png',
      typeTitle: 'nhat-ky'),
  ListItemService(
      title: 'Chỉ số sức khỏe',
      icon: 'assets/images/health.png',
      typeTitle: 'chi-so-suc-khoe'),
  ListItemService(
      title: 'Danh sách học sinh',
      icon: 'assets/images/list.png',
      typeTitle: 'danh-sach-hoc-sinh'),
  // ListItemService(
  //     title: 'Đánh giá định kỳ',
  //     icon: 'assets/images/appreciate.png',
  //     typeTitle: 'danh-gia-dinh-ky'),
  // ListItemService(title: 'Sổ liên lạc', icon: 'assets/images/contact-book.png'),
  ListItemService(
      title: 'Nhóm lớp', icon: 'assets/images/rss.png', typeTitle: 'nhom-lop'),
];

List<ListItemService> listItemParentService = [
  ListItemService(
      title: 'Thông báo',
      icon: 'assets/images/bell.png',
      typeTitle: 'thong-bao-parent'),
  ListItemService(
      title: 'Góp ý', icon: 'assets/images/remark.png', typeTitle: 'gop-y'),
  ListItemService(
      title: 'Xin nghỉ',
      icon: 'assets/images/student.png',
      typeTitle: 'xin-nghi'),
  ListItemService(
      title: 'Đơn thuốc',
      icon: 'assets/images/pill.png',
      typeTitle: 'don-thuoc-parent'),
  ListItemService(
      title: 'Thực đơn',
      icon: 'assets/images/restaurant.png',
      typeTitle: 'thuc-don-parent'),
  ListItemService(
      title: 'Lịch học',
      icon: 'assets/images/calendar.png',
      typeTitle: 'lich-hoc-parent'),
  ListItemService(
      title: 'Học phí',
      icon: 'assets/images/dolar.png',
      typeTitle: 'hoc-phi-parent'),
  ListItemService(
      title: 'Dịch vụ',
      icon: 'assets/images/bus.png',
      typeTitle: 'dich-vu-parent'),
  ListItemService(
      title: 'Nhóm lớp', icon: 'assets/images/rss.png', typeTitle: 'nhom-lop'),
  ListItemService(
      title: 'Nhật ký',
      icon: 'assets/images/clipboard.png',
      typeTitle: 'nhat-ky-parent'),
  ListItemService(
      title: 'Chỉ số sức khỏe',
      icon: 'assets/images/health.png',
      typeTitle: 'chi-so-suc-khoe-parent'),
  ListItemService(
    title: 'Liên hệ', 
    icon: 'assets/images/list.png', 
    typeTitle: 'lien-he'
  ),
];

class ListItemService {
  String title;
  String icon;
  String typeTitle;
  ListItemService({required this.title, required this.icon, required this.typeTitle});
}
