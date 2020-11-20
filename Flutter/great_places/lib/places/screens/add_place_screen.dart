import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/places/providers/places_provider.dart';
import 'package:provider/provider.dart';

import '../../common/routes/routes.dart';
import '../../places/screens/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  var _titleController = TextEditingController();
  File _pickedImage;

  void _pictureSelectedHandler(File file) {
    _pickedImage = file;
  }

  void _addHandler(BuildContext context) {
    if (_titleController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<PlacesProvider>(context, listen: false)
        .add(_titleController.text, _pickedImage?.path);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title'
                      ),
                      controller: _titleController,
                    ),
                    SizedBox(height: 10,),
                    ImageInput(onImageSelected: _pictureSelectedHandler),
                  ],
                ),
              ),
            ),
            RaisedButton.icon(
              onPressed: () { _addHandler(context); },
              icon: Icon(Icons.add),
              label: Text('Add Place'),
              elevation: 0,
              color: Theme.of(context).accentColor,
            ),
          ],
        ),
      ),
    );
  }
}
