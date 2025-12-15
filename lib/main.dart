import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/provider/favorite_meals_list.dart';
import 'package:mis_lab2/screens/category_page.dart';
import 'package:mis_lab2/screens/favorite_meals_page.dart';
import 'package:mis_lab2/screens/home_page_screen.dart';
import 'package:mis_lab2/screens/meal_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Firebase Login , for Later!!!!
  // FirebaseAuth.instance
  //     .authStateChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  //
  // print('User granted permission: ${settings.authorizationStatus}');

  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");

  RemoteMessage? initialMessage = await FirebaseMessaging.instance
      .getInitialMessage();
  if (initialMessage != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = initialMessage.data;
      if (data['screen'] == 'randomPage') {
        final context = navigatorKey.currentContext;
        if (context != null) {
          MyHomePage.fetchRandomMeal(context);
        }
      }
    });
  }

  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   final data = message.data;
  //
  //   print(data);
  //   if (data['screen'] == 'randomPage') {
  //     final context = navigatorKey.currentContext;
  //     if (context != null) {
  //       MyHomePage.fetchRandomMeal(context);
  //     }
  //   }
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: FavoriteMealsList())
      ],
      child: MaterialApp(
        title: 'Lab1 ',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: "/",
        navigatorKey: navigatorKey,
        routes: {
          "/": (context) => const MyHomePage(),
          "/category": (context) => MealByCategoryPage(),
          "/favorite_meals": (context) => FavoriteMealsPage(),
          "/meal": (context) => MealDetailPage(
            meal: ModalRoute.of(context)!.settings.arguments as MealModel?,
          ),
        },
      ),
    );

    // return MaterialApp(
    //   title: 'Lab1 ',
    //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
    //   initialRoute: "/",
    //   navigatorKey: navigatorKey,
    //   routes: {
    //     "/": (context) => const MyHomePage(),
    //     "/category": (context) => MealByCategoryPage(),
    //     "/favorite_meals": (context) => FavoriteMealsPage(),
    //     "/meal": (context) => MealDetailPage(meal: ModalRoute.of(context)!.settings.arguments as MealModel?),
    //   },
    //
    // );
  }
}
