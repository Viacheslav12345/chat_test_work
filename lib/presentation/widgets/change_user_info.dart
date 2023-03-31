import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChangeUserInfo extends StatefulWidget {
  final String label;
  const ChangeUserInfo(this.label, {Key? key}) : super(key: key);

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'Your ${widget.label}',
          border: const OutlineInputBorder(),
        ),
        maxLines: 1,
        inputFormatters: [LengthLimitingTextInputFormatter(15)],
        onSubmitted: ((value) {
          final personProvider =
              Provider.of<InfoProvider>(context, listen: false);
          (widget.label == 'name')
              ? personProvider.currentUser.name = value
              : personProvider.currentUser.profession = value;

          personProvider.updateCurrentUser(personProvider.currentUser);
          setState(() {});
        }));
  }
}
