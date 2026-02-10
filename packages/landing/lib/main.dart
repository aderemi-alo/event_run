import 'package:jaspr/server.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:landing/jaspr_options.dart';
import 'package:landing/pages/contact_us.dart';
import 'package:landing/pages/landing.dart';
import 'package:landing/pages/pricing.dart';
import 'package:landing/pages/privacy_policy.dart';
import 'package:landing/pages/terms_of_service.dart';

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
        Route(
          path: '/pricing',
          title: 'EventRun - Pricing',
          builder: (context, state) => const PricingPage(),
        ),
        Route(
          path: '/privacy',
          title: 'EventRun - Privacy Policy',
          builder: (context, state) => const PrivacyPolicyPage(),
        ),
        Route(
          path: '/terms',
          title: 'EventRun - Terms of Service',
          builder: (context, state) => const TermsOfServicePage(),
        ),
        Route(
          path: '/contact',
          title: 'EventRun - Contact Us',
          builder: (context, state) => const ContactPage(),
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
