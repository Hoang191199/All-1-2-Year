import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:mobiedu_kids/app/services/local_storage.dart';
import 'package:mobiedu_kids/domain/entities/contact/contact.dart';
import 'package:mobiedu_kids/domain/entities/response_data_object.dart';
import 'package:mobiedu_kids/domain/usecases/contact_use_case.dart';
import 'package:mobiedu_kids/presentation/controllers/messenger/messenger_controller.dart';
import 'package:mobiedu_kids/presentation/pages/messenger/conversations_detail.dart';

class ContactController extends GetxController {
  ContactController(this.fetch);

  final responseData = Rx<ResponseDataObject<ContactData>?>(null);
  final isLoading = false.obs;
  final store = Get.find<LocalStorageService>();
  final listUserIdConversations = [].obs;

  final ContactUseCase fetch;

  fetchData() async {
    isLoading(true);
    final response = await fetch.execute();
    responseData.value = response;
    isLoading(false);
  }

  newChat(String? userName, String? userId, String? email, String? avatar) async {

    Get.put(MessengerController());
    DatabaseReference chatRef = FirebaseDatabase.instance.ref('Users/_${store.userFromStorage?.user_id}');
    DatabaseReference conversations = chatRef.child('conversations');
    DatabaseReference friends = chatRef.child('friends');

    final DataSnapshot listConversations = await conversations.get();
    final DataSnapshot listFriends = await friends.get();
    List checkConversations = [];
    List checkFriend = [];
    if(listConversations.value != null){
      Map<String, dynamic> mapDataConversations = Map<String, dynamic>.from(listConversations.value as Map<Object?, Object?>);
      mapDataConversations.forEach((key, value) {
        if(value['user_id'] == '_$userId'){
          checkConversations.add(key);
        }
      });
    }
    if(listFriends.value != null){
      Map<String, dynamic> mapDataFriends = Map<String, dynamic>.from(listFriends.value as Map<Object?, Object?>);
      mapDataFriends.forEach((keyFriend, valueFriend) {
        if (keyFriend == '_$userId') {
          checkFriend.add(valueFriend);
        }
      });
    }

    if(checkConversations.isNotEmpty || checkFriend.isNotEmpty){
      if(checkConversations.isNotEmpty){
        Get.to(() => ConversationsDetail(
          avatar: avatar,
          name: userName,
          email: email,
          keyConversations: checkConversations[0],
          isGroup: '0',
        ));
      }else{
        Get.to(() => ConversationsDetail(
          avatar: avatar,
          name: userName,
          email: email,
          keyConversations: checkFriend[0],
          isGroup: '0',
        ));
      }
    }else{
      DatabaseReference newMessages = chatRef.push();
      String? newKey = newMessages.key;
      await conversations.child(newKey ?? '').set({
        'isDelete': 0,
        'user_id': '_$userId'
      }).then((_) {
        Get.to(() => ConversationsDetail(
          avatar: avatar,
          name: userName,
          email: email,
          keyConversations: newKey,
          isGroup: '0',
        ));
      }).catchError((onError) {}); 
    }
  }
}
