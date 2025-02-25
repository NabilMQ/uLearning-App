import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ulearning_app/common/service/storage_service.dart';

class Global {
  static late StorageService storageService;
  
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    // Bloc.observer = MyGlobalObserver();
    await Firebase.initializeApp();
    await dotenv.load(fileName: ".env");
    storageService = await StorageService().init();
  }
}