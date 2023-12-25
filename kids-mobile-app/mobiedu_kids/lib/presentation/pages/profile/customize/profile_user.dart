import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobiedu_kids/app/config/app_colors.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/city.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/image_controller.dart';
import 'package:mobiedu_kids/presentation/controllers/profile/profile_controller.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/customize_page.dart';
import 'package:mobiedu_kids/presentation/pages/profile/customize/widget/item_profile_user.dart';
import 'package:mobiedu_kids/presentation/widgets/circular_loading_indicator.dart';

class ProfileUser extends StatelessWidget {
  ProfileUser({super.key});

  final store = Get.find<LocalStorageService>();
  final profileController = Get.find<ProfileController>();
  final image = Get.put(ImageController());
  final List<City> city = [
    City(
      city_id: '0',
      city_name: 'Không xác định',
    ),
    City(city_id: '1', city_name: 'Hà Nội'),
    City(city_id: '2', city_name: 'TP. Hồ Chí Minh'),
    City(city_id: '3', city_name: 'An Giang'),
    City(city_id: '4', city_name: 'Bà Rịa - Vũng Tàu'),
    City(city_id: '5', city_name: 'Bắc Giang'),
    City(city_id: '6', city_name: 'Bắc Kạn'),
    City(city_id: '7', city_name: 'Bạc Liêu'),
    City(city_id: '8', city_name: 'Bắc Ninh'),
    City(city_id: '9', city_name: 'Bến Tre'),
    City(city_id: '10', city_name: 'Bình Định'),
    City(city_id: '11', city_name: 'Bình Dương'),
    City(city_id: '12', city_name: 'Bình Phước'),
    City(city_id: '13', city_name: 'Bình Thuận'),
    City(city_id: '14', city_name: 'Cà Mau'),
    City(city_id: '15', city_name: 'Cần Thơ'),
    City(city_id: '16', city_name: 'Cao Bằng'),
    City(city_id: '17', city_name: 'Đà Nẵng'),
    City(city_id: '18', city_name: 'Đắk Lắk'),
    City(city_id: '19', city_name: 'Đắk Nông'),
    City(city_id: '20', city_name: 'Điện Biên'),
    City(city_id: '21', city_name: 'Đồng Nai'),
    City(city_id: '22', city_name: 'Đồng Tháp'),
    City(city_id: '23', city_name: 'Gia Lai'),
    City(city_id: '24', city_name: 'Hà Giang'),
    City(city_id: '25', city_name: 'Hà Nam'),
    City(city_id: '26', city_name: 'Hà Tĩnh'),
    City(city_id: '27', city_name: 'Hải Dương'),
    City(city_id: '28', city_name: 'Hải Phòng'),
    City(city_id: '29', city_name: 'Hậu Giang'),
    City(city_id: '30', city_name: 'Hòa Bình'),
    City(city_id: '31', city_name: 'Hưng Yên'),
    City(city_id: '32', city_name: 'Khánh Hòa'),
    City(city_id: '33', city_name: 'Kiên Giang'),
    City(city_id: '34', city_name: 'Kon Tum'),
    City(city_id: '35', city_name: 'Lai Châu'),
    City(city_id: '36', city_name: 'Lâm Đồng'),
    City(city_id: '37', city_name: 'Lạng Sơn'),
    City(city_id: '38', city_name: 'Lào Cai'),
    City(city_id: '39', city_name: 'Long An'),
    City(city_id: '40', city_name: 'Nam Định'),
    City(city_id: '41', city_name: 'Nghệ An'),
    City(city_id: '42', city_name: 'Ninh Bình'),
    City(city_id: '43', city_name: 'Ninh Thuận'),
    City(city_id: '44', city_name: 'Phú Thọ'),
    City(city_id: '45', city_name: 'Phú Yên'),
    City(city_id: '46', city_name: 'Quảng Bình'),
    City(city_id: '47', city_name: 'Quảng Nam'),
    City(city_id: '48', city_name: 'Quảng Ngãi'),
    City(city_id: '49', city_name: 'Quảng Ninh'),
    City(city_id: '50', city_name: 'Quảng Trị'),
    City(city_id: '51', city_name: 'Sóc Trăng'),
    City(city_id: '52', city_name: 'Sơn La'),
    City(city_id: '53', city_name: 'Tây Ninh'),
    City(city_id: '54', city_name: 'Thái Bình'),
    City(city_id: '55', city_name: 'Thái Nguyên'),
    City(city_id: '56', city_name: 'Thanh Hóa'),
    City(city_id: '57', city_name: 'Thừa Thiên Huế'),
    City(city_id: '58', city_name: 'Tiền Giang'),
    City(city_id: '59', city_name: 'Trà Vinh'),
    City(city_id: '60', city_name: 'Tuyên Quang'),
    City(city_id: '61', city_name: 'Vĩnh Long'),
    City(city_id: '62', city_name: 'Vĩnh Phúc'),
    City(city_id: '63', city_name: 'Yên Bái')
  ];

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    
    return  Container(
    padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
    child: Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: GetBuilder<ImageController>(
                      init: ImageController(),
                      initState: (state) async {
                        ImageController.to.imageFile == null;
                      },
                      builder: (value) => image.isLoading.value ? 
                      const Center(
                        child: CircularLoadingIndicator()
                      ) : 
                      SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: ClipOval(
                          child: (ImageController.to.imageFile?.path != "" && ImageController.to.imageFile != null) ? 
                          Image(
                            height: 100.0,
                            width: 100.0,
                            image: FileImage(File(ImageController.to.imageFile?.path ??"")),
                            fit: BoxFit.cover
                          ) : 
                          (profileController.data.value?.profile?.user_picture != "" && profileController.data.value?.profile?.user_picture != null 
                          && (ImageController.to.imageFile?.path == "" || ImageController.to.imageFile == null)) ? 
                          Image(
                            height: 100.0, 
                            width: 100.0, 
                            image: CachedNetworkImageProvider("${profileController.data.value?.profile?.user_picture}"), 
                            fit: BoxFit.cover
                          ) : 
                          const Image(
                            height: 100.0, 
                            width: 100.0, 
                            image: AssetImage('assets/images/avatar-mac-dinh.png'), 
                            fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor:Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        builder: ((builder) => GetBuilder<ImageController>(
                          builder: ((_) => image.isLoading.value ? 
                          WillPopScope(
                            onWillPop: () async { return false;}, 
                            child: Container(
                              decoration: const BoxDecoration(color: Colors.transparent),
                              child: const Center(
                                child: CircularLoadingIndicator()
                              ),
                            )
                          ) :
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white
                            ),
                            height: 120.0,
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal:20,vertical:20),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height:20),
                                Text(
                                  "choose-avatar".tr,
                                  style:const TextStyle(
                                    fontSize:20.0,
                                  ),
                                ),
                                const SizedBox(height:20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextButton.icon(
                                      icon: Icon(
                                        Icons.camera,
                                        color: AppColors.pink,
                                      ),
                                      onPressed: () async {
                                        await image.changecameraAvatar(context);
                                        Navigator.pop(context);
                                      },
                                      label: Text(
                                        "camera".tr,
                                        style: TextStyle(color: AppColors.pink),
                                      ),
                                    ),
                                    TextButton.icon(
                                      icon: Icon(
                                        Icons.image,
                                        color: AppColors.pink,
                                      ),
                                      onPressed: () async {
                                        await image.changegalleryAvatar(context);
                                        Navigator.pop(context);
                                      },
                                      label: Text(
                                        "gallery".tr,
                                        style: TextStyle(color: AppColors.pink),
                                      ),
                                    ),
                                  ]
                                )
                              ],
                            ),
                          )),
                        ))
                      );
                    },
                  ),
                ]
              ),
              const SizedBox(height: 30.0),
              ItemProfileUser(
                image: "assets/images/customize.png", 
                placeholderText: "Họ và tên đệm", 
                textController: profileController.lastname
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/customize.png", 
                placeholderText: "Tên", 
                textController: profileController.firstname
              ),
              const Divider(thickness: 1.0),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => ShowDateBirth());
                },
                child: ItemProfileUser(
                  image: "assets/images/birth.png", 
                  placeholderText: "Ngày sinh", textController: 
                  profileController.birth
                ),
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/idcard.png", 
                placeholderText: "CMND/Hộ chiếu", 
                textController: profileController.id
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/issue-place.png", 
                placeholderText: "Nơi cấp", 
                textController: profileController.poi
              ),
              const Divider(thickness: 1.0),
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) => ShowDateIDIssue()
                  );
                },
                child: ItemProfileUser(
                  image: "assets/images/issue-date.png", 
                  placeholderText: "Ngày cấp", 
                  textController: profileController.doi
                ),
              ),
              const Divider(thickness: 1.0),
              GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      const SizedBox(
                        child: Image(
                          height: 20,
                          width: 20,
                          image: AssetImage("assets/images/city.png"),
                          fit:BoxFit.contain
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        "${city[profileController.cityID.value].city_name}",
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                            color: AppColors.black,
                            fontSize: 14.0,
                            fontWeight:FontWeight.w700
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ),
              const Divider(thickness: 1.0,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    const SizedBox(
                      child: Image(
                        height: 20,
                        width: 20,
                        image: AssetImage("assets/images/gender.png"),
                        fit: BoxFit.cover
                      ),
                    ),
                    const SizedBox(width: 10),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            profileController.gender(true);
                          },
                          child: Row(
                            children: [
                              profileController.gender.value == true ? 
                              imageCheckBox("assets/images/green_active.png") : 
                              imageCheckBox("assets/images/inactive.png"),
                              const SizedBox(width: 10.0),
                              Text(
                                "Nam",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              )
                            ]
                          )
                        ),
                        const SizedBox(width: 20.0),
                        GestureDetector(
                          onTap: () {
                            profileController.gender(false);
                          },
                          child: Row(
                            children: [
                              profileController.gender.value == true ? 
                              imageCheckBox("assets/images/inactive.png") : 
                              imageCheckBox("assets/images/green_active.png"),
                              const SizedBox(width: 10.0),
                              Text(
                                "Nữ",
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              )
                            ]
                          )
                        ),
                      ],
                    )
                  ],
                )
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/working.png", 
                placeholderText: "Công việc", 
                textController: profileController.work
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/factory.png", 
                placeholderText: "Cơ quan", 
                textController: profileController.factory
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/resident.png", 
                placeholderText: "Thường trú", 
                textController: profileController.resident
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/hometown.png", 
                placeholderText: "Quê quán", 
                textController: profileController.hometown
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/faculty.png", 
                placeholderText: "Ngành đào tạo", 
                textController: profileController.faculty
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/school_icon.png", 
                placeholderText: "Nhà trường", 
                textController: profileController.school
              ),
              const Divider(thickness: 1.0),
              ItemProfileUser(
                image: "assets/images/class_icon.png", 
                placeholderText: "Lớp", 
                textController: profileController.classroom
              ),
              const Divider(thickness: 1.0),
              const SizedBox(height: 16.0),
              SizedBox(
                width: widthScreen - 56,
                child: CupertinoButton(
                  onPressed: () async {
                    if (profileController.firstname.text != "" &&
                      profileController.lastname.text != "" &&
                      profileController.id.text != "" &&
                      profileController.doi.text != "" &&
                      profileController.poi.text != "") 
                    {
                      if (image.imageFile?.path != "" &&
                        image.imageFile?.path != null) {
                        final file = await image.imageFile?.readAsBytes();
                        await profileController.updateProfile(
                          profileController.firstname.text,
                          profileController.lastname.text,
                          profileController.gender.value ? 'male' : 'female',
                          profileController.birth.text,
                          profileController.data.value?.profile?.user_phone ?? "",
                          profileController.work.text,
                          profileController.factory.text,
                          profileController.resident.text,
                          profileController.hometown.text,
                          profileController.faculty.text,
                          profileController.school.text,
                          profileController.classroom.text,
                          profileController.cityID.value.toString(),
                          profileController.id.text,
                          profileController.doi.text,
                          profileController.poi.text,
                          file
                        );
                      } else {
                        await profileController.updateProfile(
                          profileController.firstname.text,
                          profileController.lastname.text,
                          profileController.gender.value ? 'male' : 'female',
                          profileController.birth.text,
                          profileController.data.value?.profile?.user_phone ?? "",
                          profileController.work.text,
                          profileController.factory.text,
                          profileController.resident.text,
                          profileController.hometown.text,
                          profileController.faculty.text,
                          profileController.school.text,
                          profileController.classroom.text,
                          profileController.cityID.value.toString(),
                          profileController.id.text,
                          profileController.doi.text,
                          profileController.poi.text,
                          null
                        );
                      }
                      await profileController.profile(store.userFromStorage?.user_name ??"");
                    } else {
                        showAlertDialog(
                          context,
                          "Thiếu trường cần thiết",
                          "Nhập đủ các trường hợp lệ"
                        );
                      }
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.pink,
                    child: Text(
                      'Lưu',
                      style: GoogleFonts.raleway(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                  )
                )
              ],
            )
          ),
        ]
      ),
    );
  }
    ClipOval imageCheckBox(String image) {
    return ClipOval(
      child: Image(
        height: 20.0,
        width: 20.0,
        image: AssetImage(image),
        fit: BoxFit.cover
      ),
    );
  }

  _showDialog(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: heightScreen / 3,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Hủy',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Chọn',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: profileController.cityID.value
                  ),
                  onSelectedItemChanged: (int selectedItem) async {
                    profileController.cityID.value = selectedItem;
                  },
                  children: List<Widget>.generate(city.length, (int index) {
                    return Center(child: Text(city[index].city_name ?? ""));
                  }),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
