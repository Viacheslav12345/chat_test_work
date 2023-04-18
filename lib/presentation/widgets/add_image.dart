import 'dart:io';
import 'package:chat_test_work/domain/models/info_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Future<File?> getImageFromGallery() async {
    final ImagePicker picker = ImagePicker();

    File? selectedImage;
    // load from gallery
    final XFile? imageIcon =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 5);
    if (imageIcon != null) {
      selectedImage = File(imageIcon.path);
    }
    return selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    final currentUserUrlAva =
        context.select((InfoProvider value) => value.currentUser.urlAvatar);

    return InkWell(
      onTap: () async {
        File? selectedImage = await getImageFromGallery();
        await infoProvider.changeCurrentUserPhoto(selectedImage);
        // Navigator.of(context).canPop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: (currentUserUrlAva != '')
                  ? NetworkImage(currentUserUrlAva) as ImageProvider
                  : const AssetImage(
                      'assets/components/images/unknown-user.png'),
              alignment: Alignment.center,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
