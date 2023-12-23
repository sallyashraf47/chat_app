import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../constants.dart';
import '../../../models/message.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  List<Message> messagesList = [];

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);
  ChatCubit() : super(ChatInitial());
  sendMessage({required String data, required String email}){
    messages.add(
      {kMessage: data, kCreatedAt: DateTime.now(), 'id' : email },

    );
  }
  getMessage(){
    messagesList.clear();
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {

      for (int i = 0; i < event.docs.length; i++) {
        messagesList.add(Message.fromJson(event.docs[i]));
      }
      emit(ChatSuccess(messagesList));
    });
  }
}
