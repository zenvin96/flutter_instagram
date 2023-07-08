import "dart:typed_data";

import "package:firebase_storage/firebase_storage.dart";

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List image, bool isPost, uid) async {
    UploadTask uploadTask =
        _storage.ref().child(childName).child(uid).putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
