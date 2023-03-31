import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/data/datasources/remote_storage.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/widgets/header_cons.dart';
import 'package:chat_test_work/presentation/widgets/message_in.dart';
import 'package:chat_test_work/presentation/widgets/message_out.dart';
import 'package:chat_test_work/presentation/widgets/typing_message.dart';
import 'package:chat_test_work/common/utils.dart';
import 'package:collection/collection.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);

    final currentUser = infoProvider.currentUser;
    final allUsers = infoProvider.allUsers;
    int seenMinutesAgo = 0;

    if (allUsers.isNotEmpty) {
      final lastSeenUsersTime =
          (allUsers.map((user) => int.parse(user.lastSeen)).toList()).max;
      Duration duration = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(lastSeenUsersTime));
      seenMinutesAgo = duration.inMinutes;
    }

    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
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
            Container(
              margin: const EdgeInsets.only(bottom: 9),
              height: 68 * fem,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          margin: const EdgeInsets.only(top: 21, left: 13),
                          // width: 84 * fem,
                          child: const HeaderIcons(),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    margin: EdgeInsets.only(top: 28 * h),
                    height: 18 * fem,
                    child: Text(
                      'last seen $seenMinutesAgo minutes ago',
                      style: SafeGoogleFont(
                        'Eloquia Text',
                        fontSize: 12 * ffem,
                        fontWeight: FontWeight.w400,
                        // height: 1.2575 * ffem / fem,
                        color: const Color(0xff666668),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3 - 20,
                  )
                ],
              ),
            ),

            //------- CHAT --------------------------------------------

            Expanded(
              child: FirebaseAnimatedList(
                query: RemoteDataSource().getMessageQuery(),
                itemBuilder: (context, snapshot, animation, index) {
                  final json = snapshot.value as Map<dynamic, dynamic>;
                  final message = Message.fromJson(json);
                  return (message.idFrom == currentUser.id)
                      ? MessageOut(message: message)
                      : MessageIn(message: message);
                },
              ),
            ),

            //------- FOOTER --------------------------------------------

            Container(
              padding:
                  EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32 * fem, 0 * fem),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0x191e1e1e)),
              ),
              child: const TypingMessage(),
            ),
          ],
        ),
      ),
    );
  }
}