import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manoel_varela/constant/colors.dart';
import 'package:manoel_varela/entities/books_entity.dart';
import 'package:manoel_varela/entities/user_entity.dart';
import 'package:manoel_varela/services/book_services.dart';
import 'package:manoel_varela/services/user_controller.dart';
import 'package:manoel_varela/services/user_services.dart';
import 'package:manoel_varela/src/features/booking/booking_controller.dart';
import 'package:manoel_varela/src/features/booking/booking_page.dart';
import 'package:manoel_varela/src/features/home/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:manoel_varela/src/features/login/login_controller.dart';
import 'package:manoel_varela/src/features/login/login_page.dart';
import 'firebase_options.dart';

bool shouldUseFirebaseEmulator = false;

late final FirebaseApp app;
late final FirebaseAuth auth;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth = FirebaseAuth.instanceFor(app: app);
  if (shouldUseFirebaseEmulator) {
    await auth.useAuthEmulator('localhost', 9099);
  }

  initInstances();
  runApp(GetMaterialApp(
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    ),
    debugShowMaterialGrid: false,
    debugShowCheckedModeBanner: false,
    localizationsDelegates: GlobalMaterialLocalizations.delegates,
    supportedLocales: [
      Locale('pt', 'BR'),
    ],
    getPages: [
      GetPage(
          name: '/',
          page: () {
            return LoginPage();
          }),
      GetPage(
          name: '/home',
          page: () {
            return HomePage();
          }),
      GetPage(
          name: '/booking',
          page: () {
            final BookType bookType = Get.arguments;
            return BookingPage(bookType: bookType);
          })
    ],
  ));
}

initInstances() {
  Get.lazyPut(() => BookingServices());
  Get.put(UserService());
  Get.lazyPut(() => BookingController());
  Get.put(UserController());
  Get.put(LoginController());
}
