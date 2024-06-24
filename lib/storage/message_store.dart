import 'package:sign_stage/models/util/message.dart';

class MessageStore {
  // Singleton
  static final MessageStore _instance = MessageStore._internal();

  factory MessageStore() {
    return _instance;
  }

  MessageStore._internal();

  final List<Message> messages = [];
}
