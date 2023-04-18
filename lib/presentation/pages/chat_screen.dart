import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/widgets/chat.dart';
import 'package:chat_test_work/presentation/widgets/footer.dart';
import 'package:chat_test_work/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    final currentChatUsers = infoProvider.currentChatUsers;

    Map<String, Image> initAvaImage = {
      for (var avaName in currentChatUsers.map((user) => user.avatar).toList())
        avaName.toString():
            Image.asset('assets/components/images/unknown-user.png')
    };

    return FutureProvider(
      create: (context) {
        return infoProvider.getImageFromCache();
      },
      initialData: initAvaImage,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //------- HEADER --------------------------------------------
              const HeaderWidget(),
              //------- CHAT --------------------------------------------
              ChatWidget(),
              //------- FOOTER --------------------------------------------
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
