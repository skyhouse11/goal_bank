import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:goal_bank/main_wrapper.dart';

import 'package:goal_bank/data/settings.dart';

import 'package:goal_bank/models/app_class.dart';
import 'package:goal_bank/models/custom_style.dart';

import 'package:goal_bank/pages/about_page.dart';
import 'package:goal_bank/pages/create_goal_page.dart';
import 'package:goal_bank/pages/home_page.dart';
import 'package:goal_bank/pages/main_page.dart';
import 'package:goal_bank/pages/settings_page.dart';

import 'package:goal_bank/service/admob.dart';

import 'package:goal_bank/providers/auth_provider.dart';
import 'package:goal_bank/providers/focus_node_provider.dart';
import 'package:goal_bank/providers/language_provider.dart';
import 'package:goal_bank/providers/push_notifications_provider.dart';
import 'package:goal_bank/providers/shared_preference_provider.dart';
import 'package:goal_bank/providers/theme_provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton(AppClass());
  GetIt.instance.registerSingleton(AdMobService());

  await GetIt.instance<AdMobService>().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SharedPreferencesProvider()..fetch(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider()..init(),
        ),
        ChangeNotifierProvider(
          create: (context) => PushNotificationsProvider()..init(),
        ),
        ChangeNotifierProxyProvider<SharedPreferencesProvider, LanguageProvider>(
          create: (context) => LanguageProvider(),
          update: (context, shared, language) {
            return language..init(shared);
          },
        ),
        ChangeNotifierProxyProvider<LanguageProvider, CustomStyle>(
          create: (context) => CustomStyle(),
          update: (context, language, style) {
            return style..init(language);
          },
        ),
        ChangeNotifierProvider(
          create: (context) => CustomStyle(),
        ),
        ChangeNotifierProvider(
          create: (context) => FocusNodeProvider(),
        ),
      ],
      child: Selector<LanguageProvider, Locale>(builder: (context, val, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: MainPageLink,
          onGenerateRoute: Router.generateRoute,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            fontFamily: 'Ubuntu',
          ),
          locale: val,
          supportedLocales: [
            Locale('he'),
            Locale('en'),
            Locale('ru'),
          ],
          builder: (context, widget) {
            return MainWrapper(widget);
          },
        );
      }, selector: (ctx, value) {
        return value.locale;
      }),
    );
  }
}

class Router {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainPageLink:
        return MaterialPageRoute(builder: (_) => MainPage());
      case HomePageLink:
        return MaterialPageRoute(builder: (_) => HomePage());
      case CreateGoalPageLink:
        return MaterialPageRoute(builder: (_) => CreateGoalPage());
      case SettingsPageLink:
        return MaterialPageRoute(builder: (_) => SettingsPage());
      case AboutPageLink:
        return MaterialPageRoute(builder: (_) => AboutPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
