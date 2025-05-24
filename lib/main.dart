import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:take_me_with_you/core/utils/app.dart';
// import 'package:take_me_with_you/core/utils/app_pref.dart';
import 'package:take_me_with_you/core/utils/di.dart';
import 'package:take_me_with_you/core/utils/firebase_options.dart';
import 'package:take_me_with_you/core/utils/language_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // AppPreferences appPreferences = instance<AppPreferences>();
  // appPreferences.removeUserToken();
  // appPreferences.setUserToken(
  //     '''eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiZjhmZGY0YmU0NjllMjM2OGY3YmU2NmQxMTAyNzJiMjg3N2M0NDdmODgyMmFhMThhZjRhNGU5MzJlNWMyMWM3YmJmZDZiOGI2NjcyOWY1NGYiLCJpYXQiOjE3MjU3OTQ1MzIuOTQ4OTcsIm5iZiI6MTcyNTc5NDUzMi45NDg5NzQsImV4cCI6MTc1NzMzMDUzMi45NDM0OTQsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.Tn82AZeYW8SAouMINdx8MHme4Pxqdwe8ICrwl1eJwEvuqZxUzEJgVmQoK4ROYlDIunMEXcUf6H4q4yOAA6JnIuJtjOgu2fIKf6sYLitR2yr9Dfiy5IyYySXPqlUaNMCAJX0tmZDCZYT4RZ7JA6bmTDfnXjZh7jsikLJgLLaMaxPfqSNbvJKeygiXvDNDm42iQinXRPTBXU3JB65VSWjXMk_Nn7t7eMV2MMjSy8ljoXzHaFfdPTYCT_HGuI8I3k8I9r3EPw_3LpYb72jOKFoloKKV1_rs0fOZ8vjrh9-_PvAHMlgPPD5wGNEBr65uLYY8NEYFG9ztjF3wabcrSmgQvWuc6mnyZMetJEHldf1cwdI1n2WN_MIFkwOGyuaXYxopsvjGY1stmSffEs5phLd1Zaas5rUmn_o2_5toTJePosBeBQeysofWgh7UBatsXpxvUgPcQtpPqLQLroks1LQK8NsL-i52JyhC55pMqCmHYgqnXqIltXn_o6zySG80SA6sCLeMcUp7uy69zNVizpE4nt3pLEXZkhd5nEhR_vAdTa0H2O6WWoOb4yFhWL_xJUvlhTUIlaa1EP_rHQ9zsSA9RHaK16-insrguo21SKyBoOkl6QJsRNty-RaBCtr__afSUl084OXLBis6qaT8pD9eZXhLlhT3fof8-lANuOJpXy0''',
  //     'Khdne Admin',
  //     '0987654321',
  //     1);
  // appPreferences.setUserToken(
  //     '''eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI1IiwianRpIjoiNWVkZGI4OTg3ZTE1NzY1MzM5YWUwYjg2YWM5MWJiNzVkMDc1MGUwZTExNTZhMmZhZmFiOTRmYjAzMDVhMGM5NjM4MDE2OGE2NDJmNTUxZDEiLCJpYXQiOjE3MjU3OTQ4NTQuNjgwNjU4LCJuYmYiOjE3MjU3OTQ4NTQuNjgwNjYyLCJleHAiOjE3NTczMzA4NTQuNjQzNDQ5LCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.jOhkE0DkppF820Klvz3L91Xzv2llokowd5Oer1d0Wt00P3zaw7vlUtIaij7ot9gC8A1XWirptcbfQFQdsdz7msf7Tqgae7tXvPIiNd-poT-MsLDAl1E9at0ANFV6XLO6PrJjEU6Z3ZIAWzA7m4aPbWWdgPJUdiiFSSciOU0nDFs3iefH9fYohKuEA9UC_ayXn-VPL3gPp2S2nyjA1EyH8jIMQWHnadDgSgEvR10T3kz0ndYkdQvA7WZfzkWAUnenjoc6vF_oHV_Gall1MlufTW1ZktMPWx4pdeAg2tKi5MSlwyQsmmpR6GGexkvhuTmRyL4rgMn1ovHqPTWQfRtMgmUJCOth_XR02UZ2w0QeenFsv_OOUOZa5LVZp5ElEuSkiqN2UAfj6Neg9N7InJnJ-ytB7r6jCyKA8T_-RxIeYF6AEHT817mEGX2e19ySOyboHRDyEwB-pcj8Al0MxPdgdrPso-AxcfOnqS1U28sfaLmzKXl-yiMwRLFYbDX1ILuWN5Fa7sRUcuBuzXl3F6stqttn7MvCjigQF179tIHrSw1S2ssYM81FWFSO-MrsZKslRYO6MlFeHcteaoZdgKOX64viTBOwfGLf_siq9JyRkGtzkDcsL1qOOC9pRkeayKH3AsLYGRMmSd7BAzVRLQb3HczkyRYy7ZyVXuFsf4mGTGg''',
  //     'malek',
  //     '0948811066',
  //     4);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: EasyLocalization(
          supportedLocales: const [arabicLocale, englishLocale],
          path: assetPathLocalization,
          startLocale: arabicLocale,
          child: MyApp(),
        ),
      ),
    );
  });
}
