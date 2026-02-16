import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/constants/app_constants.dart';
import 'package:app/core/theme/app_theme.dart';
import 'package:app/core/router/app_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import '../l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  usePathUrlStrategy();

  runApp(const ProviderScope(child: EventRunApp()));
}

class EventRunApp extends ConsumerWidget {
  const EventRunApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
