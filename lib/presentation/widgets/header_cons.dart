import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/const.dart';

class HeaderIcons extends StatelessWidget {
  const HeaderIcons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    // infoProvider.allUsers.remove(infoProvider.currentUser);
    final allUsers = infoProvider.allUsers;

    double pShift = -18;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    List<Widget> listOfIcons = [];

    for (var i = 0; i < allUsers.length; i++) {
      pShift = pShift + 20 * fem;

      listOfIcons.add(Positioned(
        left: pShift,
        top: 0 * fem,
        child: Container(
          padding: EdgeInsets.fromLTRB(1 * fem, 1 * fem, 1 * fem, 1 * fem),
          width: 26 * fem,
          height: 26 * fem,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(13 * fem),
          ),
          child: Center(
            child: SizedBox(
              width: 24 * fem,
              height: 24 * fem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150 * fem),
                child: (allUsers[i].avatar == '')
                    ? Image.asset('assets/components/images/unknown-user.png')
                    : Image.network(
                        allUsers[i].urlAvatar,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ),
      ));
    }

    return Stack(
      children: listOfIcons,
    );
  }
}
