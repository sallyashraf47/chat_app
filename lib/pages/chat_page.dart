import 'package:chat_app/pages/cubit/chat/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/message.dart';
import '../widgets/chat_buble.dart';


class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';

  final _controller = ScrollController();

  // CollectionReference messages =
  //     FirebaseFirestore.instance.collection(kMessagesCollections);
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
 var email  = ModalRoute.of(context)!.settings.arguments ;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  Text('chat'),
                ],
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
  builder: (context, state) {
    var messagesList=BlocProvider.of<ChatCubit>(context).messagesList;
    return ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) { 
                        return messagesList[index].id == email ?  ChatBuble(
                          message: messagesList[index],
                        ) : ChatBubleForFriend(message: messagesList[index]);
                      });
  },
),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      BlocProvider.of<ChatCubit>(context).sendMessage(data: data, email: email as String);
                      // messages.add(
                      //   {kMessage: data, kCreatedAt: DateTime.now(), 'id' : email },
                      //
                      // );
                      controller.clear();
                      _controller.animateTo(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    decoration: InputDecoration(
                      hintText: 'Send Message',
                      suffixIcon: const Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }


}
