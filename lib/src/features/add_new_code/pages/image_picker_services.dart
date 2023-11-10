import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<XFile?> onPickImage(ImageSource imageSource) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: imageSource);
      return photo;
    } catch (e) {
      return null;
    }
  }

  Future<List<XFile>> onPickMultiImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> photo = await picker.pickMultiImage();
    return photo;
  }
}
