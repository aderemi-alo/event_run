import 'package:jaspr/jaspr.dart';

@client
class NavigationBar extends StatefulComponent {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  bool _isMenuOpen = false;

  void _toggleMenu() {
    setState(() => _isMenuOpen = !_isMenuOpen);
  }

  static const _navLinks = [
    (label: 'Features', href: '/#features'),
    (label: 'How it works', href: '/#how-it-works'),
    (label: 'Pricing', href: '/pricing'),
  ];

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield nav(
      classes:
          'fixed w-full bg-white/90 backdrop-blur-md z-50 border-b border-slate-100 transition-all duration-300',
      [
        // Main container
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'flex justify-between items-center h-16',
              [
                // Logo
                a(
                  href: '/',
                  classes: 'flex items-center cursor-pointer',
                  [
                    span(
                      classes:
                          'text-2xl font-bold text-teal-700 tracking-tight',
                      [text('EventRun')],
                    ),
                  ],
                ),

                // Desktop Nav
                div(
                  classes: 'hidden md:flex items-center space-x-8',
                  [
                    for (final link in _navLinks)
                      a(
                        href: link.href,
                        classes:
                            'text-sm font-medium text-slate-600 hover:text-teal-600 transition-colors',
                        [text(link.label)],
                      ),

                    // Auth Buttons
                    div(
                      classes: 'flex items-center space-x-4 ml-4',
                      [
                        a(
                          href: '/login',
                          classes:
                              'text-sm font-semibold text-teal-700 hover:text-teal-800 transition-colors',
                          [text('Log in')],
                        ),
                        a(
                          href: '/onboarding',
                          classes:
                              'bg-teal-600 hover:bg-teal-700 text-white text-sm font-bold py-2.5 px-5 rounded-full shadow-lg shadow-teal-600/20 transition-all hover:scale-105 active:scale-95',
                          [text('Get Started Free')],
                        ),
                      ],
                    ),
                  ],
                ),

                // Mobile Menu Button
                div(
                  classes: 'md:hidden',
                  [
                    button(
                      classes:
                          'text-slate-600 hover:text-teal-600 p-2 focus:outline-none',
                      events: {'click': (e) => _toggleMenu()},
                      [
                        // Use raw() for SVG icons
                        _isMenuOpen ? raw(_Icons.close) : raw(_Icons.menu),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Mobile Nav Dropdown (OUTSIDE container, INSIDE nav)
        if (_isMenuOpen)
          div(
            classes:
                'md:hidden bg-white border-t border-slate-100 absolute w-full shadow-xl',
            [
              div(
                classes: 'px-4 pt-2 pb-6 space-y-2',
                [
                  for (final link in _navLinks)
                    a(
                      href: link.href,
                      classes:
                          'block px-3 py-3 text-base font-medium text-slate-600 hover:bg-slate-50 hover:text-teal-600 rounded-lg transition-colors',
                      events: {'click': (e) => _toggleMenu()},
                      [text(link.label)],
                    ),

                  // Mobile Auth Buttons
                  div(
                    classes:
                        'pt-4 mt-4 border-t border-slate-100 flex flex-col space-y-3',
                    [
                      a(
                        href: '/login',
                        classes:
                            'w-full text-center py-3 text-base font-semibold text-teal-700 bg-teal-50 rounded-lg',
                        events: {'click': (e) => _toggleMenu()},
                        [text('Log in')],
                      ),
                      a(
                        href: '/onboarding',
                        classes:
                            'w-full text-center py-3 text-base font-bold text-white bg-teal-600 rounded-lg shadow-md',
                        events: {'click': (e) => _toggleMenu()},
                        [text('Get Started Free')],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

// Icon Assets (SVGs)
class _Icons {
  static const menu = '''
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
      <path stroke-linecap="round" stroke-linejoin="round" d="M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5" />
    </svg>
  ''';

  static const close = '''
    <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
    </svg>
  ''';
}
