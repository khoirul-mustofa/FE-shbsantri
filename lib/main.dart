import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'domain/core/utils/constant/constant.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  await dotenv.load(fileName: environmentPath.path).then((value) {
    kBaseUrl = dotenv.env['BASE_URL']!;
  });
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widgets) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.0)),
            child: GetMaterialApp(
              initialRoute: initialRoute,
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              theme: ThemeData(
                  useMaterial3: true,
                  bottomSheetTheme: const BottomSheetThemeData(
                      backgroundColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent)),
              getPages: Nav.routes,
            ),
          );
        });
  }
}
