import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:food_app/a_b_testing/ab_provider.dart';
import 'package:food_app/constant/app_string.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/provider/review_provider.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/provider/query_provider.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/provider/rest_demo.dart';
import 'package:food_app/functionalities/spalsh/splash_screen.dart';
import 'package:food_app/functionalities/track%20order/provider/track_order_provider.dart';
import 'package:food_app/localization/provider/local_provider.dart';
import 'package:food_app/services/api_service.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:toastification/toastification.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();
final localhostServer = InAppLocalhostServer(documentRoot: 'assets');
WebViewEnvironment? webViewEnvironment;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // flutterDeepLink();
  await dotenv.load(); // Load .env file
  await ApiService().initialize();
  String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    final availableVersion = await WebViewEnvironment.getAvailableVersion();
    assert(availableVersion != null,
        'Failed to find an installed WebView2 runtime or non-stable Microsoft Edge installation.');

    webViewEnvironment = await WebViewEnvironment.create(
        settings: WebViewEnvironmentSettings(userDataFolder: 'custom_path'));
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }

  String apiKey = dotenv.env['APIKEY'] ?? '';
  String authDomain = dotenv.env['AUTHDOMAIN'] ?? '';
  String projectId = dotenv.env['PROJECTID'] ?? '';
  String storageBucket = dotenv.env['STORAGEBUCKET'] ?? '';
  String messagingSenderId = dotenv.env['MESSAGINGSENDERID'] ?? '';
  String appId = dotenv.env['APPID'] ?? '';
  String measurementId = dotenv.env['MEASUREMENTID'] ?? '';

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
        measurementId: measurementId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await SentryFlutter.init((option) {
    option.dsn = AppString.projectSentryDNS;
    option.tracesSampleRate = 1.0;
    option.profilesSampleRate = 1.0;
    option.debug = true;
    option.sendDefaultPii = true;
    option.addIntegration(LoggingIntegration());
    option.enableFramesTracking = false;
  });

  // await SSlPinningManager().initialize();

  await Hive.initFlutter();
  await Hive.openBox("userProfile");
  await Hive.openBox("userCart");
  await Hive.openBox("paymentDetails");
  await Hive.openBox("translations");
  await Hive.openBox("favoriteMeals");

  runApp(SentryWidget(child: const MyApp()));
  sentryInit();
}

final HttpCertificatePinning data = HttpCertificatePinning();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String userUid = "";

  void getUserId() async {
    final databaseBox = Hive.box('userProfile');
    final id = await databaseBox.get("userid");
    debugPrint("Hive user id : $id");

    setState(() {
      userUid = id ?? "";
    });
    debugPrint("user Uid :$userUid");
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviders()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LocalProvider()),
        ChangeNotifierProvider(create: (_) => QueryProvider()),
        ChangeNotifierProvider(create: (_) => RestDemo()),
        ChangeNotifierProvider(create: (_) => TrackOrderProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
        ChangeNotifierProvider(create: (_) => AbProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<LocalProvider>(
        builder: (BuildContext context, LocalProvider value, Widget? child) {
          return ToastificationWrapper(
            child: MaterialApp(
              title: 'Swift Bite',
              navigatorKey: globalNavigatorKey,
              locale: value.appLocal,
              showSemanticsDebugger: false,
              //  supportedLocales: AppLocalizations.supportedLocales,
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
                Locale('he'),
              ],
              //--
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              localeResolutionCallback: (locale, supportedLocales) {
                if (locale == null) {
                  return supportedLocales.first;
                }
                for (var supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale.languageCode &&
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              theme: Provider.of<ThemeProvider>(context).themeData,

              //  ThemeData(
              //   colorScheme:
              //       ColorScheme.fromSeed(seedColor: AppColors.lightGreen),
              //   useMaterial3: false,
              // ),
              // routes: {
              //   "home": (context) => HomeScreen(),
              //   "login": (context) => const LoginScreen(),
              //   "bottom": (context) => const BottomScreen(),
              //   "cart": (context) => const CartScreen(),
              //   "signup": (context) => const CartScreen(),
              //   "profile": (context) => const ProfileScreen(),
              // },
              home: Consumer<AuthProviders>(
                builder: (context, auth, _) {
                  return SplashScreen();
                  // userUid.isEmpty
                  //     ? const SplashScreen()
                  //     : const BottomScreen();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

void sentryInit() async {
  FlutterError.onError = (FlutterErrorDetails details) async {
    await Sentry.captureException(
      details.exception,
      stackTrace: details.stack,
    );
    FlutterError.presentError(details);
  };
}

//  flutter gen-l10n

//  allow read, write: if request.auth!=null;  firebase rules

//  C:\Users\Admin\.jdks\corretto-17.0.11

//  kotlinOptions {
//          jvmTarget = JavaVersion.VERSION_1_8
//  }

//  adb shell am start -a android.intent.action.VIEW \-d "flutterDeepLink://swift-bite/#/home/hello-world"

// flutter clean
// flutter pub get
// flutter gen-l10n
