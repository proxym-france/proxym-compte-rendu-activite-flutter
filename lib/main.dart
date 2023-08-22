import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mycra_timesheet_app/core/route/route_provider.dart';
import 'package:mycra_timesheet_app/core/theme/theme_mode_provider.dart';
import 'package:mycra_timesheet_app/data/models/type/collab_type.dart';
import 'package:mycra_timesheet_app/features/time_card/page/time_card_list_page.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsBinding binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await Hive.initFlutter();
  Hive.registerAdapter(CollabTypeAdapter());

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final router = ref.watch(goRouterProvider);
    final theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
    final darkTheme = ThemeData.dark(useMaterial3: true);
    return MaterialApp.router(
      title: 'Oh Crapp',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: theme.copyWith(textTheme: GoogleFonts.montserratTextTheme(theme.textTheme)),
      darkTheme: darkTheme.copyWith(textTheme: GoogleFonts.montserratTextTheme(darkTheme.textTheme)),
      themeMode: themeMode.themeMode,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TimeCardList();
    // return AuthenticationPage();
  }
}
