import "dart:typed_data";

import "package:firebase_storage/firebase_storage.dart";
import "package:uuid/uuid.dart";

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List image, bool isPost, uid) async {
    Reference ref;

    if (isPost) {
      String id = const Uuid().v1();
      ref = _storage.ref().child(childName).child(uid).child(id);
    } else {
      ref = _storage.ref().child(childName).child(uid);
    }

    UploadTask uploadTask = ref.putData(image);

    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
