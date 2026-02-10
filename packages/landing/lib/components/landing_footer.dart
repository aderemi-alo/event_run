import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  const Footer({super.key});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    final year = DateTime.now().year;

    yield footer(
      classes: 'bg-slate-900 text-slate-400 py-12',
      [
        div(
          classes:
              'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 md:grid-cols-4 gap-8',
          [
            // Brand Column
            div(classes: 'col-span-1 md:col-span-1', [
              span(
                classes: 'text-xl font-bold text-white tracking-tight',
                [text('EventRun')],
              ),
              p(
                classes: 'mt-4 text-sm leading-relaxed',
                [
                  text(
                      'The all-in-one business management platform built for the Nigerian events industry.')
                ],
              ),
            ]),

            ..._footerLinks.entries.map((entry) => _FooterColumn(
                  title: entry.key,
                  links: entry.value,
                )),
          ],
        ),

        // Copyright
        div(
          classes:
              'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-12 pt-8 border-t border-slate-800 text-sm text-center md:text-left',
          [text('© $year EventRun Nigeria. All rights reserved.')],
        ),
      ],
    );
  }
}

/// Helper Component: Handles the UI consistency for columns
class _FooterColumn extends StatelessComponent {
  final String title;
  final Map<String, String> links; // Label : Url

  const _FooterColumn({required this.title, required this.links});

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div([
      h4(classes: 'text-white font-semibold mb-4', [text(title)]),
      ul(
        classes: 'space-y-2 text-sm',
        [
          for (final entry in links.entries)
            li([
              a(
                href: entry.value,
                classes: 'hover:text-white transition-colors',
                [text(entry.key)],
              )
            ]),
        ],
      ),
    ]);
  }
}

/// Footer links data
const _footerLinks = {
  'Product': {
    'Features': '/#features',
    'Pricing': '/pricing',
  },
  'Company': {
    'Contact': '/contact',
  },
  'Legal': {
    'Privacy Policy': '/privacy',
    'Terms of Service': '/terms',
  },
};
