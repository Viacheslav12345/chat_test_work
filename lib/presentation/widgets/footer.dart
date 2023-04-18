import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/presentation/widgets/typing_message.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Container(
      padding: EdgeInsets.fromLTRB(32 * fem, 0 * fem, 32 * fem, 0 * fem),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0x191e1e1e)),
      ),
      child: const TypingMessage(),
    );
  }
}
