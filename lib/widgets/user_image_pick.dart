import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class UserImagePick extends StatefulWidget {
  const UserImagePick({super.key, required this.onPickedImage});

  final void Function(File setImage) onPickedImage;

  @override
  State<UserImagePick> createState() => _UserImagePickState();
}

class _UserImagePickState extends State<UserImagePick> {
  File? setpickedimage;

  void _getimage() async {
    final pickedimage = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50, maxHeight: 170);

    if (pickedimage == null) {
      return;
    }
    setState(() {
      setpickedimage = File(pickedimage.path);
    });

    widget.onPickedImage(setpickedimage!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundColor: const Color.fromARGB(255, 173, 172, 172),
          foregroundImage: setpickedimage != null
              ? FileImage(setpickedimage!) //* FileImage() -> yeilds a image provider and that is whay foreground image want. Image.file() is not used used as it gives widget rather than an Image Provider.
              : null, 
        ),
        TextButton.icon(
          onPressed: () {
            _getimage();
          },
          label: Text(
            "Add Image",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon:const Icon(Icons.image),
        ),
      ],
    );
  }
}
