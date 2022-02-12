import 'dart:convert';
import 'dart:io';
import 'config.dart';
import 'user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  double screenHeight = 0.0, screenWidth = 0.0;
  File? _image;

  var pathAsset = "assets/images/logo.png";
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final TextEditingController _proidEditingController = TextEditingController();
  final TextEditingController _pronameEditingController =
      TextEditingController();
  final TextEditingController _prodescEditingController =
      TextEditingController();
  final TextEditingController _propriceEditingController =
      TextEditingController();

  final TextEditingController _proquanEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Product"),
      ),
      body: Column(
        children: [
          Flexible(
              flex: 5,
              child: GestureDetector(
                onTap: _selectImage,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Card(
                    child: Container(
                        decoration: BoxDecoration(
                      image: DecorationImage(
                        image: _image == null
                            ? AssetImage(pathAsset)
                            : FileImage(_image!) as ImageProvider,
                        fit: BoxFit.fill,
                      ),
                    )),
                  ),
                ),
              )),
          Flexible(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //ute
                        const Text(
                          "Add New Product",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Product id must be longer than 3"
                                : null,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus5);
                            },
                            controller: _proidEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Product ID',
                                labelStyle: TextStyle(),
                                icon: Icon(
                                  Icons.format_align_justify,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Product name must be longer than 3"
                                : null,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus);
                            },
                            controller: _pronameEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Product Name',
                                labelStyle: TextStyle(),
                                icon: Icon(
                                  Icons.person,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty || (val.length < 3)
                                ? "Product description must be longer than 3"
                                : null,
                            focusNode: focus,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus1);
                            },
                            maxLines: 4,
                            controller: _prodescEditingController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                labelText: 'Product Description',
                                alignLabelWithHint: true,
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.notes),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty
                                ? "Product price must contain value."
                                : null,
                            focusNode: focus1,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            controller: _propriceEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Product Price',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.money_rounded),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),
                        TextFormField(
                            textInputAction: TextInputAction.next,
                            validator: (val) => val!.isEmpty
                                ? "Quantity should be more than 0."
                                : null,
                            focusNode: focus2,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus3);
                            },
                            controller: _proquanEditingController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                labelText: 'Product Quantity.',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.format_list_numbered),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                ))),

                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenWidth, screenHeight / 13)),
                          child: const Text('Add Product'),
                          onPressed: () => {
                            _newProductDialog(),
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _selectImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
              style: TextStyle(),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 7)),
                  child: const Text('Gallery'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectfromGallery(),
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(screenWidth / 4, screenHeight / 7)),
                  child: const Text('Camera'),
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    _selectFromCamera(),
                  },
                ),
              ],
            ));
      },
    );
  }

  void _newProductDialog() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in all the required fields.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Please insert the product picture.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Add this product",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _addNewProduct();
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addNewProduct() {
    String _code = _proidEditingController.text;
    String _name = _pronameEditingController.text;
    String _prodesc = _prodescEditingController.text;
    String _quantity = _proquanEditingController.text;
    String _price = _propriceEditingController.text;

    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Adding new product.."),
        title: const Text("Processing..."));
    progressDialog.show();

    String base64Image = base64Encode(_image!.readAsBytesSync());
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/new_product.php"),
        body: {
          "code": _code,
          "name": _name,
          "prodesc": _prodesc,
          "quantity": _quantity,
          "price": _price,
          "image": base64Image,
        }).then((response) async {
      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.of(context).pop();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
    progressDialog.dismiss();
  }

  Future<void> _selectfromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _selectFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
              ]
            : [
                CropAspectRatioPreset.square,
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          title: 'Crop Image',
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }
}
