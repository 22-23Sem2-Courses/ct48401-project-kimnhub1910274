import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../shared/dialog_utils.dart';
import 'products_manager.dart';

//dinh nghia them/ cap nhat san pham
class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  EditProductScreen(
    Product? product, {
    super.key,
  }) {
    if (product == null) {
      this.product = Product(
        id: null,
        title: '',
        price: 0,
        // priceDiscount: 0,
        description: '',
        imageUrl: '',
      );
    } else {
      this.product = product;
    }
  }
  late final Product product;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Product _editedProduct;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('jpeg'));
  }

//khoi tao cac bien . _imageUrlFocusNode: nghe trang thai focus cua truong nhap lieu cua anh
  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedProduct = widget.product;
    _imageUrlController.text = _editedProduct.imageUrl;
    super.initState();
  }

//giai phong bien
  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

// xay dung bieu mau hieu chinh san pham
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
          actions: <Widget>[
            IconButton(
              onPressed: _saveForm,
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _editForm,
                    child: ListView(
                      children: <Widget>[
                        buildTitleField(),
                        buildPriceField(),
                        // buildPriceDiscountField(),
                        buildDescriptionField(),
                        buildProductPreview(),
                      ],
                    )),
              ));
  }

// truong nhap lieu ten san pham
  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedProduct.title,
      decoration: const InputDecoration(
          labelText: 'Title',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(title: value);
      },
    );
  }

// truong nhap lieu gia san pham
  TextFormField buildPriceField() {
    return TextFormField(
      initialValue: _editedProduct.price.toString(),
      decoration: const InputDecoration(
          labelText: 'Price',
          labelStyle: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          )),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a price';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than size';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(price: double.parse(value!));
      },
    );
  }

//truong nhap lieu mo ta
  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedProduct.description,
      decoration: const InputDecoration(
          labelText: 'Description',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      // maxLines: 2,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(description: value);
      },
    );
  }

// review
  Widget buildProductPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 20,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isNotEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

// url img
  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(
          labelText: 'Image URL',
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a image URL';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL';
        }
        return null;
      },
      onSaved: (value) {
        _editedProduct = _editedProduct.copyWith(imageUrl: value);
      },
    );
  }

  // Future<void> showErrorDialog(BuildContext context, String message) {
  //   return showDialog(
  //     context: context,
  //     builder: (ctx) => AlertDialog(
  //       title: const Text('An Error Occurred!'),
  //       content: Text(message),
  //       actions: <Widget>[
  //         TextButton(
  //           child: const Text('Okay'),
  //           onPressed: () {
  //             Navigator.of(ctx).pop();
  //           },
  //         )
  //       ],
  //     ),
  //   );
  // }
// _saveForm them san pham vao danh sach san pham boi ProductManager
//
  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!
        .validate(); // lan luot goi validator cua moi truong nhap trong form.
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save(); // goi onSaved
    setState(() {});
    try {
      final productsManager = context.read<ProductsManager>();
      // print(_editedProduct.description);

      if (_editedProduct.id != null) {
        productsManager.updateProduct(_editedProduct);
      } else {
        productsManager.addProduct(_editedProduct);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong');
    }
    setState(() {
      _isLoading = false;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }
}
