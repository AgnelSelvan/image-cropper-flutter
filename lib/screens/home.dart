import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_cropper_example/utils/db/db.dart';
import 'package:image_cropper_example/widgets/edit_icon.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final double radius = 140;
  String? croppedImage;

  void pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
        ],
      );
      croppedImage = croppedFile?.path;
      await AppSharedPreferences.instance.setImageCropKey(croppedImage!);
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      croppedImage = AppSharedPreferences.instance.getImageCropKey();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Image Cropper Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (croppedImage != null)
              Container(
                width: radius * 2,
                height: radius * 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  image: DecorationImage(
                    image: FileImage(File(croppedImage!)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: EditIcon(
                  onTap: pickImage,
                  alignment: Alignment(Alignment.bottomCenter.x + 0.8, 0.9),
                ),
              )
            else
              SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: Stack(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: radius * 2,
                      color: Colors.grey.shade300,
                    ),
                    EditIcon(onTap: pickImage),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
