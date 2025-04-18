import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:scalp_pure/components/AppColor.dart';
import 'BackEnd/provider_class.dart';
import 'Screens/splash_screen.dart';
import 'components/AppMessage.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scalp Pure',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.white,
        fontFamily: GoogleFonts.libreBaskerville().fontFamily,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: GoogleFonts.libreBaskerville().fontFamily,
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderClass(),
        )
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          builder: (_, __) => MaterialApp(
            theme: ThemeData(
              scaffoldBackgroundColor: AppColor.white,
            ),
                home: const SplashScreen(),
                debugShowCheckedModeBanner: false,
                title: AppMessage.appName,
              )),
    );
  }
}
