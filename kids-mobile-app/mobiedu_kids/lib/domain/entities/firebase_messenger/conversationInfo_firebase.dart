import 'package:mobiedu_kids/domain/entities/firebase_messenger/data_conversationInfo_firebase.dart';
import 'package:mobiedu_kids/domain/entities/firebase_messenger/messenger_conversations_firebase.dart';

class ConversationInfoFirebase {
  final DataConversationInfoFirebase? conversationInfo;
  final MessengerConversationsFirebase? messages;

  ConversationInfoFirebase({
    this.conversationInfo,
    this.messages
  });


  factory ConversationInfoFirebase.fromJson(Map<String, dynamic>? json) {
    return ConversationInfoFirebase(
      conversationInfo:json?['conversationInfo'] == null ? null : DataConversationInfoFirebase.fromJson(json?['conversationInfo']),
      messages: json?["messages"] == null ? null : MessengerConversationsFirebase.fromJson(json?['conversationInfo']),
    );
  }

   Map<String, dynamic> toJson() => {
    "conversationInfo": conversationInfo,
    "messages": messages,
  };
}