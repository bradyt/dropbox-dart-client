import 'package:dropbox/dropbox.dart';
import 'dart:io';

void main() {
    Dropbox dropbox = new Dropbox();
    ServiceClient serviceclient = dropbox.getServiceClient();
    ContentClient contentClient = dropbox.getContentClient();
    
    // serviceclient.getMedatada().then((_) {});
    // serviceclient.getAccountInfo().then((_) {});
    
    // var file = new File("/home/manuel/Pictures/blushing_rose_by_kezzi_rose-d3jobqk.png");
    // var content = file.readAsBytesSync();
    // contentClient.uploadFile(path: "prova.png", content: content);
}