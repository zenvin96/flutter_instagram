import "package:image_picker/image_picker.dart";

pickImage(ImageSource source) async {
  XFile? image = await ImagePicker().pickImage(source: source);

  if (image != null) {
    return await image.readAsBytes();
  }

  print('No image selected');
}
