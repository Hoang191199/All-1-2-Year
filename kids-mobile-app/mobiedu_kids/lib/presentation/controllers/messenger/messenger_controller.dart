import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobiedu_kids/app/config/app_common.dart';
import 'package:mobiedu_kids/app/config/app_constants.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/firebase_messenger/add_group.dart';
import 'package:mobiedu_kids/domain/entities/firebase_messenger/data_user_firebase.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/conversations_detail.dart';

class MessengerController extends GetxController {
  final user = Rx<DataUserFireBase?>(null);
  final store = Get.find<LocalStorageService>();
  final isLoading = false.obs;
  final isLoadingFriend = false.obs;
  final listKeyConversation = [];
  final listDataFriend = <Map<String, String>>[].obs;
  final listDataChat = <Map<String, String>>[].obs;
  final isLoadingMore = false.obs;
  int offset = 0;
  int batchSize = 20;
  var checkLoadMore = 0.obs;
  var flagLoadMore = false.obs;
  final checkBox = <bool>[].obs;
  final listGroup = RxList<AddGroup?>([]);
  final listUserInGroup = RxList<AddGroup?>([]);
  late TextEditingController search;
  final isLoadingListChat = false.obs;
  final checkData = false.obs;
  final checkDataFriend = false.obs;
  int offsetFriend = 0;
  int batchSizeFriend = 11;
  var checkLoadMoreFriend = 0.obs;
  var flagLoadMoreFriend = false.obs;
  List<dynamic>? listData = [];


  @override
  void onInit() {
    search = TextEditingController();
    getUserNow();
    super.onInit();
  }

  Future<void> getUserNow() async {
    isLoading(true);
    try {
      final recentPostsRef = FirebaseDatabase.instance.ref('Users/_${store.userFromStorage?.user_id}');
      final DataSnapshot userNow = await recentPostsRef.get();
      Map<String, dynamic> mapData = Map<String, dynamic>.from(userNow.value as Map<Object?, Object?>);
      DataUserFireBase? dataUserNow = DataUserFireBase.fromJson(mapData);
      user.value = dataUserNow;
      await recentPostsRef.update({
        'lastLogin': convertDateTimeToString(DateTime.now())
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
    isLoading(false);
  }

  //Lấy ra danh sách chat

  getListChat() async {
    isLoadingListChat(true);
    final recentPostsRef = FirebaseDatabase.instance.ref('Users/_${store.userFromStorage?.user_id}').child('conversations');
    final DataSnapshot dataListChat = await recentPostsRef.get();
    if(dataListChat.value != null){
      Map<String, dynamic>? mapListChat = Map<String, dynamic>.from(dataListChat.value as Map<Object?, Object?>);
      listDataChat.clear();
      mapListChat.forEach((key, value) {
        listDataChat.add({
          'conversation_key': key,
          'user_id': value['user_id'] ?? '',
          'isDelete' : (value['isDelete']).toString(),
        });
      });
      checkData.value = false;
    }else{
      checkData.value = true;
    }
    isLoadingListChat(false);
  }

  Stream<List<dynamic>> getListChatStream() {
    StreamController<List<dynamic>> streamController = StreamController();

    DatabaseReference usersReference = FirebaseDatabase.instance.ref('Users');
    DatabaseReference conversationsReference = FirebaseDatabase.instance.ref('Conversations');

    conversationsReference.onValue.listen((conversationsEvent) async {
      List<dynamic> data = [];
      List<dynamic> listDataChatCopy = List.from(listDataChat);

      for (Map<String, dynamic> userData in listDataChatCopy) {
        if(userData['isDelete'] == '0'){
          String conversationKey = userData['conversation_key'];
          String userId = userData['user_id'];

          if (conversationsEvent.snapshot.hasChild(conversationKey)) {
            dynamic userData = await getUserData(usersReference, userId, conversationKey);
            if (userData != null) {
              if(userData['lastMessage'] != "" || (userData['isGroup'] == '1')){
                data.add(userData);
              }
            }
          }
        }
      }
      streamController.add(data);
    });

    return streamController.stream;
  }

  // Lấy danh sách bạn bè

  getListFriend() async {
    isLoadingFriend(true);
    final recentPostsRef = FirebaseDatabase.instance.ref('Users/_${store.userFromStorage?.user_id}').child('friends');
    final DataSnapshot dataMessanger = await recentPostsRef.limitToLast(offsetFriend + batchSizeFriend).get();
    if(dataMessanger.value != null){
      Map<String, dynamic>? mapListMessages = Map<String, dynamic>.from(dataMessanger.value as Map<Object?, Object?>);
      listDataFriend.clear();
      mapListMessages.forEach((key, value) {
        listDataFriend.add({
          'friend_id': key,
          'conversation_key': value,
        });
      });
      checkDataFriend.value = false;
    }else{
      checkDataFriend.value = true;
    }
    update();
    isLoadingFriend(false);
  }

  Stream<List<dynamic>> getListFriendStream() {
    StreamController<List<dynamic>> streamController = StreamController();

    DatabaseReference usersReference = FirebaseDatabase.instance.ref('Users');
    DatabaseReference conversationsReference = FirebaseDatabase.instance.ref('Conversations');

    conversationsReference.onValue.listen((conversationsEvent) async {
      List<dynamic> data = [];

      for (Map<String, dynamic> friendData in listDataFriend) {
        String conversationKey = friendData['conversation_key'];
        String userId = friendData['friend_id'];

        if (conversationsEvent.snapshot.hasChild(conversationKey)) {
          dynamic userData = await getUserData(usersReference, userId, conversationKey);
          if (userData != null) {
              data.add(userData);
          }
        }
      }

      streamController.add(data);
    });

    return streamController.stream;
  }

  loadMoreFriend() {
    offsetFriend += batchSizeFriend;
    update();
  }

  //Lấy thông tin Conversations

  Future<dynamic> getUserData(DatabaseReference usersReference, String userId, String conversationKey) async {
    dynamic userData = {};
    if(userId != ""){
      DataSnapshot userDataSnapshot = await usersReference.child(userId).get();
      userData = userDataSnapshot.value;
    }
    userData['friend_id'] = userId;
    userData['conversation_key'] = conversationKey;

    DatabaseReference conversationsReference = FirebaseDatabase.instance.ref('Conversations');
    DataSnapshot conversationSnapshot = await conversationsReference.get();
    DataSnapshot converstationInfoSnapshot = conversationSnapshot.child(conversationKey).child("conversationInfo");
    Map<dynamic, dynamic> conversationData = Map<dynamic, dynamic>.from(converstationInfoSnapshot.value as Map<dynamic, dynamic>);
    //lấy thông tin Group Chat
    userData['lastMessage'] = conversationData['lastMessage'];
    userData['isGroup'] = (conversationData['isGroup']).toString();
    userData['nameGroup'] = conversationData['nameGroup'];
    userData['avatarGroup'] = conversationData['avatarGroup'];
    userData['lastTimeUpdated'] = conversationData['lastTimeUpdated'];

    return userData;
  }

  //Lấy ra đoạn chat

  getMessenger(String? key) {
    isLoadingMore(true);
    var responseMessenger = FirebaseDatabase.instance.ref('Conversations/$key').child('messages').limitToLast(offset + batchSize);
    isLoadingMore(false);
    return responseMessenger.onValue;
  }

  loadMoreMessages() {
    offset += batchSize;
    update(); 
  }

  // Gửi tin nhắn

  sendMessager(String? keyConversations, String? textMess) async {
    if(textMess != ''){
      //Thêm tin nhắn mới
      DatabaseReference chatRef = FirebaseDatabase.instance.ref('Conversations/$keyConversations').child('messages');
      DatabaseReference newMessages = chatRef.push();
      String? newKey = newMessages.key;
      await chatRef.child(newKey ?? '').set({
        'content': textMess,
        'time': convertDateTimeToString(DateTime.now()),
        'type': 'text',
        'userId': '_${store.userFromStorage?.user_id}'
      }).then((_) {}).catchError((onError) {
          // Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
      }); 
      //Cập nhật tin nhắn cuối cùng
      DatabaseReference listMessagesRef = FirebaseDatabase.instance.ref('Conversations/$keyConversations').child('conversationInfo');
      await listMessagesRef.update({
        'lastMessage': textMess,
        'lastTimeUpdated': convertDateTimeToString(DateTime.now())
      }).then((_) {}).catchError((onError) {
          // Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
      });
      // Cập nhật tin nhắn đã xem
      DatabaseReference isSeenRef = FirebaseDatabase.instance.ref('Conversations/$keyConversations').child('conversationInfo').child('participants/_${store.userFromStorage?.user_id}');
      await isSeenRef.update({
        'isSeen': 1,
      }).then((_) {}).catchError((onError) {
          // Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
      });  
    }
  }

  String convertDateTimeToString(DateTime dateTime) {
    final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
    return date;
  }

  void initializeData(int length) {
    checkBox.value = List.generate(length, (_) => false);
  }

  // Tạo Group Chat

  addGroupChat() async {
    var listName = '';
    if(listGroup.isNotEmpty){
      AddGroup currentUser = AddGroup(
        fullName: store.userFromStorage?.user_fullname,
        userId: '_${store.userFromStorage?.user_id}',
      );
      listGroup.add(currentUser);
      for(var element in listGroup) {
        listName += element?.fullName ?? '';
        if (listGroup.last != element) {
          listName += ', ';
        }
        
      }
      Map<String, dynamic> participants = {};
      for (var item in listGroup) {
        if (item?.userId != null) {
          participants[item?.userId ?? ''] = {
            'fromMessageKey': "",
            'isAdmin': 0,
            'isSeen': 1,
            'isTyping': 0,
            'isLeave': 0,
            'name': item?.fullName,
          };
        }
      }

      DatabaseReference groupChat = FirebaseDatabase.instance.ref('Conversations');
        DatabaseReference newMessages = groupChat.push();
        String? newKey = newMessages.key;
        await groupChat.child(newKey ?? '').set({
        'conversationInfo': {
          'avatarGroup': '',
          'isGroup': 1,
          'lastMessage': '',
          'lastTimeUpdated': convertDateTimeToString(DateTime.now()),
          'nameGroup': listName,
          'participants' : participants
        }
        }).then ((_) async {
          for(var user in listGroup){
            final recentPostsRef = FirebaseDatabase.instance.ref('Users/${user?.userId}').child('conversations');
            await recentPostsRef.child(newKey ?? '').set({
              'isDelete': 0,
              'user_id': ''
            }).then((_) async {
              await getListChat();
              Get.to(()=>ConversationsDetail(
                  keyConversations: newKey,
                  name: listName,
                  isGroup: '1',
                )
              );
            }).catchError((onError){

            });
          }
          listGroup.value = [];
        }).catchError((onError) {
          listGroup.value = [];
            // Scaffold.of(context).showSnackBar(SnackBar(content: Text(onError)));
        }); 
    }
  }

  //Thông tin user trong Group Chat
  getInfoUserInGroup(String? key) async {
    DatabaseReference conversationsReference = FirebaseDatabase.instance.ref('Conversations/$key');
    DataSnapshot participantsSnapshot = await conversationsReference.child('conversationInfo').child('participants').get();
    Map<dynamic, dynamic> participantsData = Map<dynamic, dynamic>.from(participantsSnapshot.value as Map<dynamic, dynamic>);
    for (var element in participantsData.keys) { 
      DatabaseReference usersReference = FirebaseDatabase.instance.ref('Users/$element');
      DataSnapshot usersSnapshot = await usersReference.child('avatar').get();
      AddGroup infoUser = AddGroup(
        userId: element,
        image: (usersSnapshot.value).toString()
      );
      listUserInGroup.add(infoUser);
      update();
    }
  }

  void getImage(ImageSource imageSource, int index, BuildContext context, String name) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      // if(tabs.value == 'check-in'){
      //   listDetailCheckIn[index].source_file = pickedFile.path;
      //   listDetailCheckIn[index].fileName = pickedFile.name;
      // }else{
      //   listDetailCheckOut[index].source_file = pickedFile.path;
      //   listDetailCheckOut[index].fileName = pickedFile.name;
      // }
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chụp");
    }
  }

  void pickImageFromGallery(BuildContext context, int index, String name) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
        // if (tabs.value == 'check-in') {
        //   listDetailCheckIn[index].source_file = pickedFile.path;
        //   listDetailCheckIn[index].fileName = pickedFile.name;
        // } else {
        //   listDetailCheckOut[index].source_file = pickedFile.path;
        //   listDetailCheckOut[index].fileName = pickedFile.name;
        // }
    } else {
      showSnackbar(SnackbarType.notice, "Thất bại", "Ảnh chưa được chọn!");
    }
  }
}
