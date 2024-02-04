import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../core/firebase/firebase_store/firebase_firestore.dart';
import '../../models/last_message_model.dart';
import '../../models/message_model.dart';

abstract class MessagesRemoteDataSource {
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers();

  Future<DocumentReference<Map<String, dynamic>>> sendMessage(
      {required String receiverId,
      required LastMsgModel lastMsgModel,
      required String content});

  Future<List<MessageModel>> getMessages({required String receiverId});
}

class MessagesRemoteDataSourceImpl extends MessagesRemoteDataSource {
  final StorageByFirebase storageByFirebase;

  MessagesRemoteDataSourceImpl({required this.storageByFirebase});

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await storageByFirebase.getAllUsers();
  }

  @override
  Future<DocumentReference<Map<String, dynamic>>> sendMessage(
      {required String receiverId,
      required LastMsgModel lastMsgModel,
      required String content}) async {
    return await storageByFirebase.sendMessage(
        receiverId: receiverId, content: content, lastMsgModel: lastMsgModel);
  }

  @override
  Future<List<MessageModel>> getMessages({required String receiverId}) async {
    return await storageByFirebase.getMessages(receiverId: receiverId);
  }
}
