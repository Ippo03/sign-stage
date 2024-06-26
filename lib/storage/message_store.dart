import 'package:sign_stage/models/util/message.dart';

class MessageStore {
  // Singleton
  static final MessageStore _instance = MessageStore._internal();

  factory MessageStore() {
    return _instance;
  }

  MessageStore._internal();

  final List<Message> messages = [];
  int misunderstandingsCount = 0;
  bool isChatLocked = false;
  int chatRefreshedCount = 0;
  bool madeClearingAfterReset = false;
}
