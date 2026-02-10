import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:landing/jaspr_options.dart';

import 'landing.dart';

/// Example app setup showing how to use the Landing component
/// with Jaspr's router.
///
/// Prerequisites:
///   - Add `jaspr` and `jaspr_router` to your pubspec.yaml
///   - Ensure Tailwind CSS is configured (see tailwind.config.js below)
///
/// To run:
///   dart run jaspr serve
///
class App extends StatelessComponent {
  const App({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield Router(
      routes: [
        Route(
          path: '/',
          title: 'EventRun - Run Your Event Business Like a Pro',
          builder: (context, state) => const Landing(),
        ),
        // Add your other routes here:
        // Route(path: '/login', ...),
        // Route(path: '/onboarding', ...),
      ],
    );
  }
}

// Entry point
void main() {
  Jaspr.initializeApp(options: defaultJasprOptions);
  runApp(Document(
    title: 'EventRun',
    head: [
      raw('<script src="https://cdn.tailwindcss.com"></script>'),
    ],
    body: App(),
  ));
}
