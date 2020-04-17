import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final File image;
  final Function callback;

  ImagePickerWidget({
    this.callback,
    this.image,
  });

  @override
  _ImagePickerWidget createState() => _ImagePickerWidget();
}

class _ImagePickerWidget extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 12) ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        height: 168,
        child: Stack(
          children: <Widget>[
            widget.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.file(
                      widget.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: RadialGradient(
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.025),
                          Color.fromRGBO(0, 0, 0, 0.15),
                        ],
                        radius: 0.9,
                        tileMode: TileMode.clamp,
                      ),
                    ),
                  ),
            Center(
              child: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: 40,
                ),
                splashColor: Colors.lightBlue,
                onPressed: () async {
                  await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 75,
                  ).then((image) {
                    if (widget.callback != null) widget.callback(image);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
