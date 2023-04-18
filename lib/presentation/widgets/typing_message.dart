import 'package:chat_test_work/common/const.dart';
import 'package:chat_test_work/data/datasources/remote_storage.dart';
import 'package:chat_test_work/domain/entities/massage.dart';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:chat_test_work/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypingMessage extends StatefulWidget {
  const TypingMessage({Key? key}) : super(key: key);

  @override
  State<TypingMessage> createState() => _TypingMessageState();
}

class _TypingMessageState extends State<TypingMessage> {
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;

    return Row(
      children: [
        Flexible(
          child: SizedBox(
              child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150.0,
            ),
            child: TextField(
              keyboardType: TextInputType.text,
              maxLines: null,
              controller: messageController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                labelText: 'Start typing...',
                labelStyle: SafeGoogleFont(
                  'Eloquia Text',
                  fontSize: 15 * fem,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff666668),
                ),
              ),
              onSubmitted: ((value) {
                _sendMessage(value);
              }),
            ),
          )),
        ),
        SizedBox(
          height: 48 * fem,
          width: 72 * fem,
          child: GestureDetector(
            onTap: () {
              _sendMessage(messageController.text);
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                'assets/components/images/paper-airplane.png',
                width: 20 * fem,
                height: 20 * fem,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _sendMessage(String value) {
    final infoProvider = Provider.of<InfoProvider>(context, listen: false);
    final currentUser = infoProvider.currentUser;
    if (messageController.text.isNotEmpty) {
      final message = Message(
        idFrom: currentUser.id,
        idTo: infoProvider.chatId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: messageController.text,
      );
      RemoteDataSource().sendMessage(message);
      messageController.clear();
      setState(() {});
    } else {}
  }
}
