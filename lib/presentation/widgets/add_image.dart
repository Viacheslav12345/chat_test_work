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
  UploadTask? uploadTaskFull;
  UploadTask? uploadTaskIcon;

  final ImagePicker _picker = ImagePicker();

  final ref = FirebaseStorage.instance.ref().child("icons");

  @override
  Widget build(BuildContext context) {
    InfoProvider infoProvider = Provider.of<InfoProvider>(context);
    final currentUser = infoProvider.currentUser;

    return InkWell(
      onTap: () async {
        File? selectedImage;
        // load from phone
        final XFile? imageIcon = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 5);
        if (imageIcon != null) {
          selectedImage = File(imageIcon.path);
          //save into FirebaseStorage
          var ref = FirebaseStorage.instance
              .ref()
              .child('icons/${path.basename(selectedImage.path)}');
          uploadTaskIcon = ref.putFile(File(selectedImage.path));

          var snapshotIcon = await uploadTaskIcon!;
          var urlDownloadIcon = await snapshotIcon.ref.getDownloadURL();
          //delete old Image
          if (currentUser.avatar != '') {
            FirebaseStorage.instance
                .ref()
                .child('icons/${currentUser.avatar}')
                .delete();
          }
          currentUser.avatar = path.basename(selectedImage.path);
          currentUser.urlAvatar = urlDownloadIcon;
          infoProvider.updateCurrentUser(currentUser);
          setState(() {});
        }
        // ignore: use_build_context_synchronously
        Navigator.of(context).canPop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: (currentUser.urlAvatar != '')
                  ? NetworkImage(currentUser.urlAvatar) as ImageProvider
                  : const AssetImage(
                      'assets/components/images/unknown-user.png'),
              alignment: Alignment.center,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
