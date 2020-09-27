import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
Future uploadFile(File _image,String userName,int index) async {
  StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('UserData/$userName/Images/image'+'$index');
  StorageUploadTask uploadTask = storageReference.putFile(_image);
  await uploadTask.onComplete;
  print('File Uploaded');
  storageReference.getDownloadURL().then((fileURL) {

  });
}

 Future uploadFiles(List<File> images,String userName)async{
  for(int i=0;i<images.length;i++)
    {
      if(images[i]!=null)
     await uploadFile(images[i], userName, i+1);
    }

}
