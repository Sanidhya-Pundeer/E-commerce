import 'package:ecommerce/model/UserClass.dart';
import 'package:ecommerce/model/cartProvider.dart';
import 'package:ecommerce/model/product.dart';
import 'package:ecommerce/model/userProvider.dart';
import 'package:ecommerce/screens/bagPage.dart';
import 'package:ecommerce/screens/checkout.dart';
import 'package:ecommerce/screens/detailPage.dart';
import 'package:ecommerce/screens/home.dart';
import 'package:ecommerce/screens/homepage.dart';
import 'package:ecommerce/screens/orders.dart';
import 'package:ecommerce/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyDWyoNplIU4scGt1VhSQEM7O4QxEfl0yUE',
          appId: '1:832058424039:android:59d27b0b086dc86d978042',
          messagingSenderId: '832058424039',
          projectId: 'mad-projects-e0ced'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => userProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 229, 229, 229)),
          useMaterial3: true,
        ),
        home: Login(),
        routes: {
          '/signup': (context) => Signup(),
          '/home': (context) => HomePage(),
          '/home1': (context) => Home(), // Assuming this route is not used
          '/bagPage': (context) => BagPage(),
          '/detailPage': (context) => DetailPage(
                product: ModalRoute.of(context)!.settings.arguments as Product,
              ),
          '/checkout': (context) => Checkout(
                userEmail: Provider.of<userProvider>(context).email!,
              ),
          '/login': (context) => Login(),
          '/orders': (context) => Orders(
                userEmail: Provider.of<userProvider>(context).email!,
              ),
        },
      ),
    );
  }
}
