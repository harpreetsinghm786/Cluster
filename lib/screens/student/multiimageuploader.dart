import 'dart:io';
import 'dart:io' show File;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../helper/responsive.dart';

class multiimageuploader extends StatefulWidget {
  const multiimageuploader({Key? key}) : super(key: key);

  @override
  _multiimageuploaderState createState() => _multiimageuploaderState();
}

class _multiimageuploaderState extends State<multiimageuploader> {
  List<Widget> itemPhotosWidgetList = <Widget>[];

  final ImagePicker _picker = ImagePicker();
  File? file;
  List<XFile>? photo = <XFile>[];
  List<XFile> itemImagesList = <XFile>[];

  List<String> downloadUrl = <String>[];

  bool uploading = false;
  List<bool> mouse = [];

  @override
  Widget build(BuildContext context) {
    double _screenwidth = 600, _screenheight = 500;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return displayWebUploadFormScreen(_screenwidth, _screenheight);
    });
  }

  displayWebUploadFormScreen(_screenwidth, _screenheight) {
    return Column(
      children: [
        const SizedBox(
          height: 100.0,
        ),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    offset: const Offset(0.0, 0.5),
                    blurRadius: 30.0,
                  )
                ]),
            child: GridView.builder(
              shrinkWrap: true,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: Responsive.ismobile(context) ? 4 : 5),
                itemCount: itemPhotosWidgetList.length+1,
                itemBuilder: (context,index){
                  return index==0?Container(
                                  height: 140,
                                  width: 140,
                                  decoration:
                                      BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(
                                            7),
                                    color:
                                        finalgrey,
                                  ),
                                  child:
                                      FlatButton(
                                    onPressed: ()  {
                                      pickPhotoFromGallery();
                                    },
                                    child: Center(
                                        child:
                                            Icon(Icons.add)),
                                  ),
                                )
                  : MouseRegion(
                                  cursor:
                                      SystemMouseCursors
                                          .click,
                                  onEnter:
                                      (value) {
                                    setState(
                                        () {
                                      mouse[index - 1] = true;
                                    });
                                  },
                                  onExit:
                                      (value) {
                                    setState(
                                        () {
                                      mouse[index - 1] =
                                          false;
                                    });
                                  },
                                  child:
                                      Stack(
                                    children: [
                                      itemPhotosWidgetList[index-1],
                                      mouse[index - 1]
                                          ? GestureDetector(
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: glass,
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                child: Center(
                                                  child: Container(
                                                      padding: EdgeInsets.all(5),
                                                      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.white), borderRadius: BorderRadius.circular(50)),
                                                      child: Icon(
                                                        Icons.delete_forever,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                               itemPhotosWidgetList.removeAt(index - 1);
                                                });
                                              },
                                            )
                                          : Container()]
                ));})),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 50.0,
                left: 100.0,
                right: 100.0,
              ),
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15.0),
                  color: const Color.fromRGBO(0, 35, 102, 1),
                  onPressed: uploading ? null : () => upload(),
                  child: uploading
                      ? const SizedBox(
                          child: CircularProgressIndicator(),
                          height: 15.0,
                        )
                      : const Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
            ),
          ],
        ),
      ],
    );
  }

  addImage() {
    for (var bytes in photo!) {
      itemPhotosWidgetList.add(
        Container(
          decoration:
          BoxDecoration(
            borderRadius:
            BorderRadius.circular(7),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(File(bytes.path).path,
                  fit: BoxFit.cover)
          ),
          height:
          150,
          width:
          150,
        ),

      );
    }
    mouse.clear();
    for(int i=0;i<itemPhotosWidgetList.length;i++){
      mouse.add(false);
    }
  }

  pickPhotoFromGallery() async {
    photo = await _picker.pickMultiImage();
    if (photo != null) {
      setState(() {
        itemImagesList = itemImagesList + photo!;
        addImage();
        photo!.clear();
      });
    }
  }

  upload() async {
    String productId = await uplaodImageAndSaveItemInfo();
    setState(() {
      uploading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
        new SnackBar(content: Text("Image Uploaded Successfully")));
  }

  Future<String> uplaodImageAndSaveItemInfo() async {
    setState(() {
      uploading = true;
    });
    PickedFile? pickedFile;
    String? productId = "sfsdf";
    for (int i = 0; i < itemImagesList.length; i++) {
      file = File(itemImagesList[i].path);
      pickedFile = PickedFile(file!.path);

      await uploadImageToStorage(pickedFile, productId);
    }
    return productId;
  }

  uploadImageToStorage(PickedFile? pickedFile, String productId) async {
    String? pId = "asfdsdfs";
    Reference reference =
        FirebaseStorage.instance.ref().child('Items/$productId/product_$pId');
    await reference.putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    );
    String value = await reference.getDownloadURL();
    downloadUrl.add(value);
  }
}
