import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  final imagePicker = ImagePicker();
  Future getImageFromCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  Future getImageFromGarally() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          /*CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile==null? AssetImage("assets/images/Profile.png"),
          ),*/
          CircleAvatar(
              radius: 80.0,
              child: _image == null
                  ? Text(
                '写真を選択してください',
                style: Theme.of(context).textTheme.headline4,
              )
                  : Image.file(_image!)
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () async {
                  var result = await showModalBottomSheet<int>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 100.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Choose Profile photo",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                              FlatButton.icon(
                                icon: Icon(Icons.camera),
                                onPressed: () {
                                  getImageFromCamera();
                                },
                                label: Text("Camera"),
                              ),
                              FlatButton.icon(
                                icon: Icon(Icons.image),
                                onPressed: () {
                                  getImageFromGarally();
                                },
                                label: Text("Gallery"),
                              ),
                            ])
                          ],
                        ),
                      );
                    },
                  );
                  print('bottom sheet result: $result');
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.teal,
                  size: 28.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}