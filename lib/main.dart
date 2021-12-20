import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_router.dart';
import 'configure_non_web.dart' if (dart.library.html) 'configure_web.dart';
import 'firebase_options.dart';

Future main() async {
  await dotenv.load(fileName: 'env');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureApp();
  runApp(PlanningPokerApp());
}

class PlanningPokerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Planning Poker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => MaterialPageRoute(
            settings: RouteSettings(name: settings.name, arguments: settings.arguments),
            maintainState: true,
            builder: (context) => AppRouter.route(settings.name!)));
  }
}
