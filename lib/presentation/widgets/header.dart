import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/common/utils.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/presentation/widgets/header_icons.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height / baseHeight;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    final currentChatUsers = infoProvider.currentChatUsers;
    int seenMinutesAgo = 0;

    if (currentChatUsers.isNotEmpty) {
      final lastSeenUsersTime =
          (currentChatUsers.map((user) => int.parse(user.lastSeen)).toList())
              .max;
      Duration duration = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(lastSeenUsersTime));
      seenMinutesAgo = duration.inMinutes;
    }
    return Container(
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
                    child: Consumer<Map<String, Image>>(
                      builder: (BuildContext context, value, Widget? child) {
                        final int avaDiffCount = currentChatUsers.length -
                            value.values.toList().length;
                        final listImages = value.values.toList();
                        if (avaDiffCount > 0) {
                          for (var i = 0; i < avaDiffCount; i++) {
                            listImages.add(Image.asset(
                              'assets/components/images/unknown-user.png',
                              fit: BoxFit.cover,
                            ));
                          }
                        }
                        return HeaderIcons(avaImages: listImages);
                      },
                    )),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: EdgeInsets.only(top: 28 * h),
            height: 18 * fem,
            child: Text(
              (seenMinutesAgo < 60)
                  ? 'last seen $seenMinutesAgo minutes ago'
                  : (seenMinutesAgo < 1440)
                      ? 'last seen ${(seenMinutesAgo / 60).roundToDouble().toInt()} hours ago'
                      : 'last seen ${(seenMinutesAgo / 1440).roundToDouble().toInt()} days ago',
              style: SafeGoogleFont(
                'Eloquia Text',
                fontSize: 12 * ffem,
                fontWeight: FontWeight.w400,
                color: const Color(0xff666668),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3 - 20,
          )
        ],
      ),
    );
  }
}
