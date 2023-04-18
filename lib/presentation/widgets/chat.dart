import 'package:chat_test_work/data/repository.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/widgets/message_in.dart';
import 'package:chat_test_work/presentation/widgets/message_out.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatWidget extends StatelessWidget {
  final Repository repository = Repository();

  ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    final currentUser = infoProvider.currentUser;
    final chatId = infoProvider.chatId;
    final query = repository.getMessagesQuery(chatId);

    return Expanded(
      child: FirebaseAnimatedList(
          query: query,
          itemBuilder: (context, snapshot, animation, index) {
            final json = snapshot.value as Map<dynamic, dynamic>;
            final message = Message.fromJson(json);
            return FadeTransition(
              opacity: animation,
              child: (message.idFrom == currentUser.id)
                  ? MessageOut(message: message)
                  : MessageIn(message: message),
            );
          }),
    );
  }
}
