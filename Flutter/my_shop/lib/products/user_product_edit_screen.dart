import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class UserProductEditScreen extends StatefulWidget {
  @override
  _UserProductEditScreenState createState() => _UserProductEditScreenState();
}

class _UserProductEditScreenState extends State<UserProductEditScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocuseNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _product = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageUrl: '',
  );

  @override
  void initState() {
    _imageUrlFocuseNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocuseNode.removeListener(_updateImageUrl);

    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocuseNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (_imageUrlFocuseNode.hasFocus) {
      setState(() {});
    }
  }

  void _imageUrlEditingComplete() {
    setState(() {});
  }

  void _saveTitleHandler(String value) {
    _product = Product(
      title: value,
      id: _product.id,
      price: _product.price,
      description: _product.description,
      imageUrl: _product.imageUrl,
    );
  }

  String _titleValidator(String value) {
    if (value.isEmpty) {
      return 'Please provide a title';
    }

    return null;
  }

  void _savePriceHandler(String value) {
    _product = Product(
      price: value.isEmpty ? 0.0 : double.parse(value),
      id: _product.id,
      title: _product.title,
      description: _product.description,
      imageUrl: _product.imageUrl,
    );
  }

  String _priceValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a price';
    }

    if (double.tryParse(value) == null) {
      return 'Please enter a valid number';
    }

    if (double.parse(value) <= 0) {
      return 'Please enter a price greater then zero';
    }
    return null;
  }

  void _saveDescriptionHandler(String value) {
    _product = Product(
      description: value,
      id: _product.id,
      title: _product.title,
      price: _product.price,
      imageUrl: _product.imageUrl,
    );
  }

  String _descriptionValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter a description';
    }

    if (value.length < 10) {
      return 'Should be at least 10 characters long.';
    }
    return null;
  }

  void _saveImageUrlHandler(String value) {
    _product = Product(
      imageUrl: value,
      id: _product.id,
      title: _product.title,
      price: _product.price,
      description: _product.description,
    );
  }

  String _imageUrlValidator(String value) {
    if (value.isEmpty) {
      return 'Please enter an image URL.';
    }

    if (!value.startsWith('http://') &&
        !value.startsWith('https://')) {
      return 'Please enter a valid URL.';
    }

    if (!value.endsWith('.png') &&
        !value.endsWith('.jpg') &&
        !value.endsWith('.jpeg')) {
      return 'Please enter a valid image URL.';
    }
    return null;
  }

  void _saveHandler() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      Provider.of<ProductsProvider>(context, listen: false)
          .addProduct(_product);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveHandler,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                onSaved: _saveTitleHandler,
                validator: _titleValidator,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocusNode);
                },
                onSaved: _savePriceHandler,
                validator: _priceValidator,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                onSaved: _saveDescriptionHandler,
                validator: _descriptionValidator,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Colors.grey
                        )
                    ),
                    child: _imageUrlController.text.isEmpty ?
                    Text('Enter a URL') :
                    FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Image URL',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocuseNode,
                      onEditingComplete: _imageUrlEditingComplete,
                      onFieldSubmitted: (_) => _saveHandler(),
                      onSaved: _saveImageUrlHandler,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
