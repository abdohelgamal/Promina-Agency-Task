import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:promina_agency_task/controllers/meetings_cubit.dart';
import 'package:promina_agency_task/models/meeting.dart' as model;
import 'package:promina_agency_task/views/screens/splash.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Hive.initFlutter();
  Hive.registerAdapter<model.Meeting>(model.MeetingAdapter());
  Hive.registerAdapter<model.Category>(model.CategoryAdapter());
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return BlocProvider(
          create: (BuildContext context) {
            return MeetingsCubit();
          },
          child: MaterialApp(
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
              scrollbarTheme: ScrollbarThemeData(
                minThumbLength: 20,
                crossAxisMargin: 0,
                interactive: true,
                trackColor: const MaterialStatePropertyAll(Colors.white),
                trackVisibility: const MaterialStatePropertyAll(true),
                thumbVisibility: const MaterialStatePropertyAll(true),
                thickness: MaterialStatePropertyAll(3.sp),
              ),
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          ));
    });
  }
}
