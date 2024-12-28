part of 'shared.dart';

Future<File?> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    return File(image.path);
  } else {
    return null; // Jika pengguna membatalkan pemilihan gambar
  }
}

Future<String> uploadImage(File image) async {
  String fileName = basename(image.path);
  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() => task.snapshot);
  return await snapshot.ref.getDownloadURL();
}
