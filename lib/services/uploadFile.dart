import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
List imageLinks;
Future uploadFile(File _image,String userName,int index) async {
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('UserData/$userName/Images/image'+'$index');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  print('File Uploaded');
  storageReference.getDownloadURL().then((fileURL) {
    imageLinks.add(fileURL);
    print('ys');
   return imageLinks;
  });
  await uploadTask.onComplete;

}

 Future uploadFiles(List<File> images,String userName)async {
   for (int i = 0; i < images.length; i++) {
     if (images[i] != null) {
       await uploadFile(images[i], userName, i + 1);
     }
   }
   print(imageLinks);
   return imageLinks;
 }

