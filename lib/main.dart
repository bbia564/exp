import 'package:experiment/db_experiment/db_experiment.dart';
import 'package:experiment/pages/experiment_one/experiment_details/experiment_details_binding.dart';
import 'package:experiment/pages/experiment_one/experiment_details/experiment_details_view.dart';
import 'package:experiment/pages/experiment_one/experiment_details/experment_too.dart';
import 'package:experiment/pages/experiment_one/experiment_one_binding.dart';
import 'package:experiment/pages/experiment_one/experiment_one_view.dart';
import 'package:experiment/pages/experiment_pace/exp_set_binding.dart';
import 'package:experiment/pages/experiment_pace/exp_set_view.dart';
import 'package:experiment/pages/experiment_tab/experiment_tab_binding.dart';
import 'package:experiment/pages/experiment_tab/experiment_tab_view.dart';
import 'package:experiment/pages/experiment_three/custom_type_add/custom_type_add_binding.dart';
import 'package:experiment/pages/experiment_three/custom_type_add/custom_type_add_view.dart';
import 'package:experiment/pages/experiment_three/experiment_three_binding.dart';
import 'package:experiment/pages/experiment_three/experiment_three_view.dart';
import 'package:experiment/pages/experiment_two/experiment_two_binding.dart';
import 'package:experiment/pages/experiment_two/experiment_two_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff383c4b);
Color bgColor = const Color(0xfff4f6fa);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBExperiment().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: RootList,
      initialRoute: '/',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme:BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> RootList = [
  GetPage(name: '/', page: () => const ExpLeaView(), binding: ExpLeaBinding()),
  GetPage(name: '/experimentTab', page: () => ExperimentTabPage(), binding: ExperimentTabBinding()),
  GetPage(name: '/experimentOne', page: () => ExperimentOnePage(),binding: ExperimentOneBinding()),
  GetPage(name: '/experimentTwo', page: () => ExperimentTwoPage(),binding: ExperimentTwoBinding()),
  GetPage(name: '/expGp', page:  () => const ExpGpo()),
  GetPage(name: '/experimentThree', page: () => ExperimentThreePage(),binding: ExperimentThreeBinding()),
  GetPage(name: '/customTypeAdd', page: () => CustomTypeAddPage(),binding: CustomTypeAddBinding()),
  GetPage(name: '/experimentDetails', page: () => ExperimentDetailsPage(),binding: ExperimentDetailsBinding()),
];