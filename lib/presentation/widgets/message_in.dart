import 'package:chat_test_work/domain/entities/person.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/common/utils.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageIn extends StatelessWidget {
  final Message message;
  const MessageIn({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    int chatId = infoProvider.chatId;
    Person? chatUser = infoProvider.currentChatUsers.firstWhereOrNull(
        (user) => user.id == message.idFrom && chatId == message.idTo);

    if (chatUser == null) {
      Provider.of<InfoProvider>(context)
          .setIdAndloadInfoForChat(chatId.toString())
          .then((value) {
        chatUser = infoProvider.currentChatUsers.firstWhereOrNull(
            (user) => user.id == message.idFrom && chatId == message.idTo);
      });
    }
    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 6 * fem),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4.5 * h),
                  width: 32 * fem,
                  height: 32 * fem,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20 * fem),
                    child: Consumer<Map<String, Image>>(
                      builder: (BuildContext context, value, Widget? child) {
                        final avaImage = value[chatUser?.avatar] ??
                            Image.asset(
                              'assets/components/images/unknown-user.png',
                              fit: BoxFit.cover,
                            );
                        return avaImage;
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(left: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Stack(children: [
                            SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 14.5 * fem,
                                    height: 12 * fem,
                                    child: Image.asset(
                                      'assets/components/images/bubble-tip.png',
                                      width: 14.5 * fem,
                                      height: 12 * fem,
                                    ),
                                  ),
                                  Container(
                                    width: 6 * fem,
                                    decoration: const BoxDecoration(
                                      color: Color(0xfff2f2f7),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 6 * fem,
                                    height: 7 * fem,
                                    child: Image.asset(
                                      'assets/components/images/bottom-curve-vector.png',
                                      width: 6 * fem,
                                      height: 7 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8.5 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  6 * fem, 4 * fem, 6 * fem, 3 * fem),
                              decoration: BoxDecoration(
                                color: const Color(0xfff2f2f7),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(6 * fem),
                                  topRight: Radius.circular(6 * fem),
                                  bottomRight: Radius.circular(6 * fem),
                                ),
                              ),
                              child: SizedBox(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            right: 10 * ffem,
                                          ),
                                          child: Text(
                                            chatUser?.name ?? 'Unnamed',
                                            style: SafeGoogleFont(
                                              'Eloquia Text',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xff2c2c2e),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          chatUser?.profession ?? 'Unnamed',
                                          style: SafeGoogleFont(
                                            'Eloquia Text',
                                            fontSize: 12 * ffem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff666668),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(right: 8 * fem),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 220),
                                                  margin: EdgeInsets.only(
                                                      bottom: 10 * fem),

                                                  // -------------message ChattUser----------------------------------

                                                  child: Text(
                                                    message.content,
                                                    style: SafeGoogleFont(
                                                      'Eloquia Text',
                                                      fontSize: 14 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: const Color(
                                                          0xff2c2c2e),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 1 * h,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0xfff2f2f7),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            DateFormat('HH:mm a').format(
                                                DateTime
                                                    .fromMillisecondsSinceEpoch(
                                                        int.parse(message
                                                            .timestamp))),
                                            style: SafeGoogleFont(
                                              'Eloquia Text',
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff666668),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
