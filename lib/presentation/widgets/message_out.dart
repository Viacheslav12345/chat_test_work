// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:chat_test_work/domain/entities/massage.dart';

import '../../common/const.dart';
import '../../common/utils.dart';

class MessageOut extends StatelessWidget {
  final Message message;
  const MessageOut({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10 * fem, vertical: 6 * fem),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(alignment: AlignmentDirectional.topEnd, children: [
            Container(
              margin: EdgeInsets.only(left: 8 * fem, right: 8.5),
              padding: EdgeInsets.fromLTRB(7 * fem, 5 * fem, 6 * fem, 6 * fem),
              decoration: BoxDecoration(
                color: const Color(0xff007aff),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(6 * fem),
                  topLeft: Radius.circular(6 * fem),
                  bottomRight: Radius.circular(6 * fem),
                ),
              ),
              child: Flexible(
                child: SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: SizedBox(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(right: 8 * fem),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 220),
                                          margin:
                                              EdgeInsets.only(bottom: 10 * fem),

                                          // -------------message ChattUser----------------------------------

                                          child: Text(
                                            message.content,
                                            style: SafeGoogleFont(
                                              'Eloquia Text',
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xffffffff),
                                            ),
                                            maxLines: 20,
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Container(
                                          height: 1 * h,
                                          decoration: const BoxDecoration(
                                            color: Color(0xfff2f2f7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat('HH:mm a').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(message.timestamp))),
                                style: SafeGoogleFont(
                                  'Eloquia Text',
                                  fontSize: 12 * ffem,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 2),
              width: 14.5 * fem,
              height: 39 * fem,
              child: Image.asset(
                'assets/components/images/bubble-left-3sj.png',
                width: 14.5 * fem,
                height: 39 * fem,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
