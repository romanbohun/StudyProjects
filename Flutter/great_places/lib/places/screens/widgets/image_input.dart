import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/common/services/file_service.dart';
import 'package:image_picker/image_picker.dart';


class ImageInput extends StatefulWidget {
  final Function onImageSelected;

  ImageInput({this.onImageSelected});

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final _fileService = FileService();
  File _storedImage;

  void _takePictureHandler() async {
    final imageFile = await ImagePicker()
        .getImage(
        source: ImageSource.gallery,
        maxWidth: 600,
    );

    if (imageFile == null) {
      return null;
    }

    final savedFile = await _fileService.saveFileToDocumets(File(imageFile.path));
    setState(() {
      _storedImage = savedFile;
    });

    if (widget.onImageSelected != null) {
      widget.onImageSelected(savedFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _storedImage != null
              ? Image.file(
            _storedImage,
            fit: BoxFit.cover,
            width: double.infinity,
          )
              : Text('No Image'),
          alignment: Alignment.center,
        ),
        SizedBox(width: 10,),
        Expanded(
          child: FlatButton.icon(
            onPressed: _takePictureHandler,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
