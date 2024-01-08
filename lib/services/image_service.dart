import 'package:image_picker/image_picker.dart';

class ImageService {
  Future<XFile?> captureImage() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }
}
