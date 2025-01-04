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
  try {
    // Mendapatkan nama file dari path
    String fileName = basename(image.path);

    // Referensi ke lokasi file di Firebase Storage
    Reference ref = FirebaseStorage.instance.ref().child("uploads/$fileName");

    // Mengunggah file
    UploadTask task = ref.putFile(image);

    // Menunggu proses unggah selesai
    TaskSnapshot snapshot = await task;

    // Mendapatkan URL unduhan file
    String downloadURL = await snapshot.ref.getDownloadURL();
    print("File uploaded successfully. Download URL: $downloadURL");

    return downloadURL;
  } catch (e) {
    // Menangkap dan mencetak error
    print("Error uploading image: $e");
    throw Exception("Image upload failed: $e");
  }
}
