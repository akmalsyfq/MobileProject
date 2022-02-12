import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'config.dart';
import 'product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

class Detailshoppage extends StatefulWidget {
  final Product product;

  const Detailshoppage({Key? key, required this.product}) : super(key: key);

  @override
  State<Detailshoppage> createState() => _DetailshoppageState();
}

class _DetailshoppageState extends State<Detailshoppage> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/logo.png";
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  bool editForm = false;

  final TextEditingController _procodeEditingController =
      TextEditingController();
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
    _procodeEditingController.text = widget.product.procode.toString();
    _pronameEditingController.text = widget.product.proname.toString();
    _prodescEditingController.text = widget.product.prodesc.toString();
    _propriceEditingController.text = widget.product.proprice.toString();
    _proquanEditingController.text = widget.product.proquan.toString();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product Details'),
        actions: [
          IconButton(onPressed: _onDeletePr, icon: const Icon(Icons.delete)),
          IconButton(onPressed: _onEditForm, icon: const Icon(Icons.edit))
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: resWidth,
            child: Column(
              children: [
                SizedBox(
                    height: screenHeight / 2.5,
                    child: GestureDetector(
                      onTap: _selectImage,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Container(
                            decoration: BoxDecoration(
                          image: DecorationImage(
                            image: _image == null
                                ? NetworkImage(MyConfig.server +
                                    "/bellacosa/images/product/" +
                                    widget.product.procode.toString() +
                                    ".png")
                                : FileImage(_image!) as ImageProvider,
                            fit: BoxFit.fill,
                          ),
                        )),
                      ),
                    )),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              enabled: editForm,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
                                      ? "Product name must be longer than 3"
                                      : null,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              controller: _procodeEditingController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  labelText: 'Product Code',
                                  labelStyle: TextStyle(),
                                  icon: Icon(Icons.format_align_justify),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              enabled: editForm,
                              validator: (val) =>
                                  val!.isEmpty || (val.length < 3)
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
                              enabled: editForm,
                              validator: (val) => val!.isEmpty ||
                                      (val.length < 3)
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
                                  icon: Icon(
                                    Icons.person,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          Row(
                            children: [
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    enabled: editForm,
                                    validator: (val) => val!.isEmpty
                                        ? "Product price must contain value"
                                        : null,
                                    focusNode: focus1,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus2);
                                    },
                                    controller: _propriceEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Product Price',
                                        labelStyle: TextStyle(),
                                        icon: Icon(
                                          Icons.money,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        ))),
                              ),
                              Flexible(
                                flex: 5,
                                child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    enabled: editForm,
                                    validator: (val) => val!.isEmpty
                                        ? "Quantity should be more than 0"
                                        : null,
                                    focusNode: focus2,
                                    onFieldSubmitted: (v) {
                                      FocusScope.of(context)
                                          .requestFocus(focus3);
                                    },
                                    controller: _proquanEditingController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Product Quantity',
                                        labelStyle: TextStyle(),
                                        icon: Icon(
                                          Icons.ad_units,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(width: 2.0),
                                        ))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Visibility(
                            visible: editForm,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(resWidth / 2, resWidth * 0.1)),
                              child: const Text('Update Product'),
                              onPressed: _updateProductDialog,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage() {
    if (editForm) {
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
                        fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
                    child: const Text('Gallery'),
                    onPressed: () => {
                      Navigator.of(context).pop(),
                      _selectfromGallery(),
                    },
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(resWidth * 0.2, resWidth * 0.2)),
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

  void _onEditForm() {
    if (!editForm) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Edit this product",
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
                  setState(() {
                    editForm = true;
                  });
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
  }

  void _updateProductDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Update this product",
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
                _updateProduct();
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

  void _updateProduct() {
    String _proname = _pronameEditingController.text;
    String _prodesc = _prodescEditingController.text;
    String _proprice = _propriceEditingController.text;
    String _proquan = _proquanEditingController.text;
    String _procode = _procodeEditingController.text;
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Updating product.."),
        title: const Text("Processing..."));
    progressDialog.show();
    if (_image == null) {
      http.post(
          Uri.parse(MyConfig.server + "/bellacosa/php/update_product.php"),
          body: {
            "proid": widget.product.proid,
            "proname": _proname,
            "prodesc": _prodesc,
            "proprice": _proprice,
            "proquan": _proquan,
            "procode": _procode,
          }).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          Navigator.of(context).pop();
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          return;
        }
      });
    } else {
      String base64Image = base64Encode(_image!.readAsBytesSync());
      http.post(
          Uri.parse(MyConfig.server + "/bellacosa/php/update_product.php"),
          body: {
            "proid": widget.product.proid,
            "proname": _proname,
            "prodesc": _prodesc,
            "proprice": _proprice,
            "proquan": _proquan,
            "image": base64Image,
            "procode": _procode,
          }).then((response) {
        var data = jsonDecode(response.body);

        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          Navigator.of(context).pop();
          return;
        } else {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          progressDialog.dismiss();
          return;
        }
      });
    }
    progressDialog.dismiss();
  }

  void _onDeletePr() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Delete this product",
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
                _deleteProduct();
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

  void _deleteProduct() {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Deleting product.."),
        title: const Text("Processing..."));
    progressDialog.show();
    http.post(Uri.parse(MyConfig.server + "/bellacosa/php/delete_product.php"),
        body: {
          "proid": widget.product.proid,
        }).then((response) {
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        Navigator.of(context).pop();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        progressDialog.dismiss();
        return;
      }
    });
  }
}
