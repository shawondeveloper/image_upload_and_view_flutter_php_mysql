import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  File _image;
  final picker = ImagePicker();

  

  TextEditingController nameContr = TextEditingController();

  Future choiceImage()async{
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage.path);
    });
  }

  

  Future upload(File imageFile)async{

    //var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    //var length = await imageFile.length();
    var uri = Uri.parse("http://192.168.1.101/image_upload_php_mysql/upload.php");

    var request = http.MultipartRequest("POST",uri);
    request.fields['name'] = nameContr.text;
    
    var pic = await http.MultipartFile.fromPath("image", imageFile.path);
    //var pic = http.MultipartFile("image",stream,length,filename: basename(imageFile.path));
    
    request.files.add(pic);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("image uploaded");
    }else{
      print("uploaded faild");
    }

    nameContr.text = "";


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            TextField(
              controller: nameContr,
              decoration: InputDecoration(
                labelText: 'Name'
              ),
            ),


            IconButton(icon: Icon(Icons.camera),
            onPressed: (){
              choiceImage();
            },),
            Container(
              width: 300,
              height: 300,
              child: _image == null ? Text('No image selected') : Image.file(_image),
              ),

              RaisedButton(child: Text('Upload Image'),
              onPressed: (){
              upload(_image);
            },),

          

          ],
        ),
      ),
    );
  }
}
