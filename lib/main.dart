import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app/config/routes/app_pages.dart';
import 'app/config/themes/app_theme.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inisialisasi Hive
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  
  // Membuka box untuk Hive
  await Hive.openBox('userBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            textTheme: Typography.englishLike2018.apply(
                fontSizeFactor: 1.sp,
                bodyColor: Colors.black,
                displayColor: Colors.black),
          ),
          debugShowCheckedModeBanner: false, // Remove the debug banner
          initialRoute: AppPages.initial,
          getPages: AppPages.routes,
          home: Scaffold(
            // Using Scaffold to set background color
            backgroundColor: Color(0xFFFCFB), // Set background color here
            body: child,
          ),
        );
      },
    );
  }
}
