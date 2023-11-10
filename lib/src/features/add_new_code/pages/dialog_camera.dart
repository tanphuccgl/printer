import 'package:flutter/material.dart';

class XDialogCamera extends StatelessWidget {
  final VoidCallback? onTapCamera;
  final VoidCallback? onTapGallery;

  const XDialogCamera({
    Key? key,
    this.onTapCamera,
    this.onTapGallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
      contentPadding: const EdgeInsets.only(bottom: 7),
      content: SizedBox(
        width: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                _listTile(
                  "Chụp ảnh",
                  Icons.camera_alt_outlined,
                  onTapCamera,
                ),
                _listTile(
                  "Chọn từ thư viện",
                  Icons.image_outlined,
                  onTapGallery,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _listTile(
    String label,
    IconData icon,
    VoidCallback? onTap,
  ) =>
      ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(
          label,
          style: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.normal,
          ),
        ),
        minLeadingWidth: 10,
        dense: true,
      );
}
