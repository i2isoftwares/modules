import 'dart:convert';
import 'dart:io';

import 'package:encrypt/encrypt.dart';
import 'package:get_storage/get_storage.dart';
import 'package:greenchecklist/helpers/constatnts.dart';
import 'package:greenchecklist/helpers/gc_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

String encryptString(String msg) {
  final box = GetStorage();
  var apiSecureKey = box.read(GCSession.key) ?? '';
  if (apiSecureKey.isNotEmpty && msg.isNotEmpty) {
    final key = Key.fromUtf8(apiSecureKey);
    final iv = IV.fromUtf8(apiSecureKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    return encrypter.encrypt(msg, iv: iv).base64;
  } else {
    return msg;
  }
}

decryptString(String msg) {
  final box = GetStorage();
  var apiSecureKey = box.read(GCSession.key) ?? '';
  final key = Key.fromUtf8(apiSecureKey);
  final iv = IV.fromUtf8(apiSecureKey);
  final encrypter = Encrypter(AES(
    key,
    mode: AESMode.cbc,
  ));
  return encrypter.decrypt(Encrypted(base64Decode(msg)), iv: iv);
}


makeDirs()async{
  var path=(await getApplicationDocumentsDirectory()).path;
  Directory directory= Directory(p.join(path,FOLDER_GC,FOLDER_DATABASE));
  directory.create(recursive: true);

  directory= Directory(p.join(path,FOLDER_GC,FOLDER_REPORT));
  directory.create();

  directory= Directory(p.join(path,FOLDER_GC,FOLDER_BACKUP));
  directory.create();

}