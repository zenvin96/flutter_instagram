import "dart:typed_data";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:instagram/resources/firestore_methods.dart";
import "package:instagram/utils/colors.dart";
import "package:instagram/utils/utils.dart";
import "package:loader_overlay/loader_overlay.dart";
import "package:provider/provider.dart";

import "../models/user.dart";
import "../providers/user_provider.dart";

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _captionController = TextEditingController();

  _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create Post'),
            children: [
              SimpleDialogOption(
                child: const Text('Photo with Camera'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List image = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = image;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Image from Gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List image = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = image;
                  });
                },
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void postImage(User user, String caption, Uint8List postImage) async {
    try {
      context.loaderOverlay.show();
      String res = await FireStoreMethods().uploadPost(
          caption, postImage, user.uid, user.username, user.profileImage);

      if (res == 'success') {
        if (context.mounted) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Posted'),
            ),
          );
        }
      } else {
        if (context.mounted) {
          context.loaderOverlay.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res),
            ),
          );
        }
      }
    } catch (e) {
      print(e);
    }
    clearImage();
  }

  @override
  void dispose() {
    super.dispose();
    _captionController.dispose();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return _file == null
        ? Center(
            child: IconButton(
            iconSize: 50,
            icon: const Icon(Icons.upload),
            onPressed: () => _selectImage(context),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: const Text('Post To'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(
                      user,
                      _captionController.text,
                      _file!,
                    );
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  clearImage();
                },
              ),
            ),
            body: Column(children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profileImage,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        controller: _captionController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                          hintText: 'Write Caption...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.memory(
                          _file!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white, thickness: 0.5),
                  ])
            ]));
  }
}
