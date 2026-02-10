import 'package:jaspr/jaspr.dart';

/// EventRun Landing Page - Jaspr conversion
/// Uses Tailwind CSS classes (ensure Tailwind is configured in your Jaspr project)

class Landing extends StatefulComponent {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool isMenuOpen = false;

  void toggleMenu() {
    setState(() {
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes: 'min-h-screen bg-white font-sans text-slate-900',
      [
        // ─── Navigation ───
        _buildNav(),

        // ─── Hero Section ───
        _buildHero(),

        // ─── Features Grid ───
        _buildFeatures(),

        // ─── Testimonial Section ───
        _buildTestimonial(),

        // ─── CTA Section ───
        _buildCta(),

        // ─── Footer ───
        _buildFooter(),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  NAVIGATION
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildNav() {
    return nav(
      classes:
          'fixed w-full bg-white/80 backdrop-blur-md z-50 border-b border-slate-100',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'flex justify-between items-center h-16',
              [
                // Logo
                div(classes: 'flex items-center', [
                  span(
                    classes: 'text-2xl font-bold text-teal-700 tracking-tight',
                    [text('EventRun')],
                  ),
                ]),

                // Desktop Nav
                div(
                  classes: 'hidden md:flex items-center space-x-8',
                  [
                    a(
                      href: '#features',
                      classes:
                          'text-sm font-medium text-slate-600 hover:text-teal-600 transition-colors',
                      [text('Features')],
                    ),
                    a(
                      href: '#how-it-works',
                      classes:
                          'text-sm font-medium text-slate-600 hover:text-teal-600 transition-colors',
                      [text('How it works')],
                    ),
                    a(
                      href: '#pricing',
                      classes:
                          'text-sm font-medium text-slate-600 hover:text-teal-600 transition-colors',
                      [text('Pricing')],
                    ),
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
                      classes: 'text-slate-600 hover:text-teal-600 p-2',
                      onClick: () => toggleMenu(),
                      [
                        raw(isMenuOpen ? _xIcon : _menuIcon),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Mobile Nav Dropdown
        if (isMenuOpen)
          div(
            classes:
                'md:hidden bg-white border-t border-slate-100 absolute w-full',
            [
              div(
                classes: 'px-4 pt-2 pb-6 space-y-2 shadow-lg',
                [
                  a(
                    href: '#features',
                    classes:
                        'block px-3 py-3 text-base font-medium text-slate-600 hover:bg-slate-50 hover:text-teal-600 rounded-lg',
                    events: {'click': (e) => toggleMenu()},
                    [text('Features')],
                  ),
                  a(
                    href: '#how-it-works',
                    classes:
                        'block px-3 py-3 text-base font-medium text-slate-600 hover:bg-slate-50 hover:text-teal-600 rounded-lg',
                    events: {'click': (e) => toggleMenu()},
                    [text('How it works')],
                  ),
                  a(
                    href: '#pricing',
                    classes:
                        'block px-3 py-3 text-base font-medium text-slate-600 hover:bg-slate-50 hover:text-teal-600 rounded-lg',
                    events: {'click': (e) => toggleMenu()},
                    [text('Pricing')],
                  ),
                  div(
                    classes:
                        'pt-4 mt-4 border-t border-slate-100 flex flex-col space-y-3',
                    [
                      a(
                        href: '/login',
                        classes:
                            'w-full text-center py-3 text-base font-semibold text-teal-700 bg-teal-50 rounded-lg',
                        events: {'click': (e) => toggleMenu()},
                        [text('Log in')],
                      ),
                      a(
                        href: '/onboarding',
                        classes:
                            'w-full text-center py-3 text-base font-bold text-white bg-teal-600 rounded-lg shadow-md',
                        events: {'click': (e) => toggleMenu()},
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

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  HERO SECTION
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildHero() {
    return section(
      classes:
          'pt-32 pb-16 md:pt-48 md:pb-32 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto text-center',
      [
        // Badge
        div(
          classes:
              'inline-flex items-center px-3 py-1 rounded-full bg-teal-50 text-teal-700 text-xs font-semibold mb-8 border border-teal-100',
          [
            span(classes: 'flex h-2 w-2 rounded-full bg-teal-500 mr-2', []),
            text('New: Professional Invoice Generator'),
          ],
        ),

        // Heading
        h1(
          classes:
              'text-4xl md:text-6xl lg:text-7xl font-extrabold text-slate-900 tracking-tight mb-6 leading-tight',
          [
            text('Run your Nigerian '),
            br(classes: 'hidden md:block'),
            span(
              classes:
                  'text-transparent bg-clip-text bg-gradient-to-r from-teal-600 to-emerald-500',
              [text('Event Business')],
            ),
            text(' like a Pro.'),
          ],
        ),

        // Subtitle
        p(
          classes:
              'text-lg md:text-xl text-slate-500 mb-10 max-w-2xl mx-auto leading-relaxed',
          [
            text(
              'Stop using paper diaries and WhatsApp to manage your bookings. '
              'EventRun helps you prevent conflicts, send professional invoices, and track your revenue.',
            ),
          ],
        ),

        // CTA Buttons
        div(
          classes:
              'flex flex-col sm:flex-row items-center justify-center space-y-4 sm:space-y-0 sm:space-x-4',
          [
            a(
              href: '/onboarding',
              classes:
                  'w-full sm:w-auto px-8 py-4 bg-teal-600 hover:bg-teal-700 text-white text-lg font-bold rounded-xl shadow-xl shadow-teal-600/20 transition-all hover:-translate-y-1',
              [text('Start Your Free Trial')],
            ),
            a(
              href: '#features',
              classes:
                  'w-full sm:w-auto px-8 py-4 bg-white hover:bg-slate-50 text-slate-700 text-lg font-semibold border border-slate-200 rounded-xl transition-colors flex items-center justify-center',
              [
                text('See How It Works'),
                raw(
                  '<svg class="w-5 h-5 ml-2 text-slate-400" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>',
                ),
              ],
            ),
          ],
        ),

        // Social Proof
        div(
          classes: 'mt-16 pt-8 border-t border-slate-100',
          [
            p(
              classes:
                  'text-sm font-medium text-slate-400 mb-6 uppercase tracking-wider',
              [text('Trusted by 500+ Vendors in Lagos, Abuja & PH')],
            ),
            div(
              classes:
                  'flex flex-wrap justify-center gap-8 md:gap-16 opacity-50 grayscale hover:grayscale-0 transition-all duration-500',
              [
                span(
                    classes: 'text-xl font-bold text-slate-800',
                    [text('WeddingDigest')]),
                span(
                    classes: 'text-xl font-bold text-slate-800',
                    [text('BellaNaija Weddings')]),
                span(
                    classes: 'text-xl font-bold text-slate-800',
                    [text('SugarWeddings')]),
                span(
                    classes: 'text-xl font-bold text-slate-800',
                    [text('EventLife NG')]),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  FEATURES GRID
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildFeatures() {
    return section(
      id: 'features',
      classes: 'py-20 bg-slate-50',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Section Header
            div(
              classes: 'text-center mb-16',
              [
                h2(
                  classes: 'text-3xl md:text-4xl font-bold text-slate-900 mb-4',
                  [text('Everything you need to grow')],
                ),
                p(
                  classes: 'text-lg text-slate-500 max-w-2xl mx-auto',
                  [
                    text(
                      'We built EventRun specifically for Nigerian rentals, decorators, DJs, and event planners.',
                    ),
                  ],
                ),
              ],
            ),

            // Feature Cards Grid
            div(
              classes: 'grid md:grid-cols-3 gap-8',
              [
                FeatureCard(
                  iconSvg: _calendarIcon,
                  iconColor: 'text-teal-600',
                  title: 'Smart Calendar',
                  description:
                      'Visualize all your upcoming events. The system automatically alerts you of any double bookings before they happen.',
                ),
                FeatureCard(
                  iconSvg: _fileTextIcon,
                  iconColor: 'text-blue-600',
                  title: 'Professional Invoices',
                  description:
                      'Create and send branded PDF invoices via WhatsApp or Email in seconds. Track payments and follow up on overdue bills.',
                ),
                FeatureCard(
                  iconSvg: _usersIcon,
                  iconColor: 'text-purple-600',
                  title: 'Client CRM',
                  description:
                      'Keep all your client details in one place. Remember their preferences and view their complete booking history.',
                ),
                FeatureCard(
                  iconSvg: _shieldCheckIcon,
                  iconColor: 'text-emerald-600',
                  title: 'Inventory Tracking',
                  description:
                      "Know exactly what equipment is available for any date. Never promise a sound system you've already rented out.",
                ),
                FeatureCard(
                  iconSvg: _barChartIcon,
                  iconColor: 'text-amber-600',
                  title: 'Business Insights',
                  description:
                      "See how much you're making every month. Understand your busiest seasons and most profitable items.",
                ),
                FeatureCard(
                  iconSvg: _zapIcon,
                  iconColor: 'text-rose-600',
                  title: 'Mobile First',
                  description:
                      "Run your entire business from your phone. Whether you're at a site inspection or in traffic on Third Mainland Bridge.",
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  TESTIMONIAL
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildTestimonial() {
    return section(
      classes: 'py-20 bg-white',
      [
        div(
          classes: 'max-w-4xl mx-auto px-4 text-center',
          [
            // Quote Icon
            div(
              classes: 'mb-8 flex justify-center',
              [
                div(
                  classes: 'p-3 bg-teal-50 rounded-full',
                  [
                    raw(
                      '<svg class="w-8 h-8 text-teal-600" fill="currentColor" viewBox="0 0 24 24">'
                      '<path d="M14.017 21L14.017 18C14.017 16.8954 13.1216 16 12.017 16H9C9.00001 15 9.00001 14 9.00001 13C9.00001 11.8954 9.89543 11 11 11H13V15H17V11V7H13L13 9H11C8.79086 9 7 10.7909 7 13V16C7 18.7614 9.23858 21 12.017 21H14.017ZM21 21L21 18C21 16.8954 20.1046 16 19 16H15.983C15.983 15 15.983 14 15.983 13C15.983 11.8954 16.8784 11 17.983 11H20V15H24V11V7H20L20 9H17.983C15.7739 9 13.983 10.7909 13.983 13V16C13.983 18.7614 16.2216 21 19 21H21Z"/>'
                      '</svg>',
                    ),
                  ],
                ),
              ],
            ),

            // Quote Text
            h3(
              classes:
                  'text-2xl md:text-4xl font-bold text-slate-900 mb-6 leading-tight',
              [
                text(
                  '"Before EventRun, I used to double book my speakers at least once a month. '
                  'Since I started using it, I haven\'t had a single conflict and my revenue is up 40%."',
                ),
              ],
            ),

            // Attribution
            div([
              p(
                classes: 'font-bold text-slate-900 text-lg',
                [text('Chukwudi Onuoha')],
              ),
              p(
                classes: 'text-slate-500',
                [text('CEO, SoundKing Rentals, Lagos')],
              ),
            ]),
          ],
        ),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  CTA SECTION
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildCta() {
    return section(
      classes: 'py-20 bg-teal-700',
      [
        div(
          classes: 'max-w-4xl mx-auto px-4 text-center',
          [
            h2(
              classes: 'text-3xl md:text-4xl font-bold text-white mb-6',
              [text('Ready to organize your business?')],
            ),
            p(
              classes: 'text-teal-100 text-lg mb-10 max-w-xl mx-auto',
              [
                text(
                  'Join hundreds of Nigerian event vendors who trust EventRun. No credit card required for trial.',
                ),
              ],
            ),
            a(
              href: '/onboarding',
              classes:
                  'inline-flex items-center px-8 py-4 bg-white text-teal-800 text-lg font-bold rounded-xl shadow-xl transition-transform hover:-translate-y-1',
              [
                text('Get Started for Free'),
                raw(
                  '<svg class="w-5 h-5 ml-2" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>',
                ),
              ],
            ),
            p(
              classes: 'mt-4 text-sm text-teal-200 opacity-80',
              [text('Free 14-day trial • Cancel anytime')],
            ),
          ],
        ),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  FOOTER
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildFooter() {
    return footer(
      classes: 'bg-slate-900 text-slate-400 py-12',
      [
        div(
          classes:
              'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 grid grid-cols-1 md:grid-cols-4 gap-8',
          [
            // Brand Column
            div(
              classes: 'col-span-1 md:col-span-1',
              [
                span(
                  classes: 'text-xl font-bold text-white tracking-tight',
                  [text('EventRun')],
                ),
                p(
                  classes: 'mt-4 text-sm leading-relaxed',
                  [
                    text(
                      'The all-in-one business management platform built for the Nigerian events industry.',
                    ),
                  ],
                ),
              ],
            ),

            // Product Column
            _footerColumn(
                'Product', ['Features', 'Pricing', 'Success Stories']),

            // Company Column
            _footerColumn('Company', ['About Us', 'Careers', 'Contact']),

            // Legal Column
            _footerColumn('Legal', ['Privacy Policy', 'Terms of Service']),
          ],
        ),

        // Copyright
        div(
          classes:
              'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 mt-12 pt-8 border-t border-slate-800 text-sm text-center md:text-left',
          [
            text(
                '© ${DateTime.now().year} EventRun Nigeria. All rights reserved.'),
          ],
        ),
      ],
    );
  }

  Component _footerColumn(String title, List<String> links) {
    return div([
      h4(
        classes: 'text-white font-semibold mb-4',
        [text(title)],
      ),
      ul(
        classes: 'space-y-2 text-sm',
        links
            .map(
              (label) => li([
                a(
                  href: '#',
                  classes: 'hover:text-white transition-colors',
                  [text(label)],
                ),
              ]),
            )
            .toList(),
      ),
    ]);
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  FEATURE CARD COMPONENT
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

class FeatureCard extends StatelessComponent {
  final String iconSvg;
  final String iconColor;
  final String title;
  final String description;

  const FeatureCard({
    required this.iconSvg,
    required this.iconColor,
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes:
          'bg-white p-6 rounded-2xl border border-slate-200 shadow-sm hover:shadow-md transition-all hover:border-teal-200 group',
      [
        div(
          classes:
              'w-14 h-14 rounded-xl bg-slate-50 flex items-center justify-center mb-6 group-hover:bg-teal-50 transition-colors',
          [
            raw(iconSvg.replaceAll('{{COLOR}}', iconColor)),
          ],
        ),
        h3(
          classes: 'text-xl font-bold text-slate-900 mb-3',
          [text(title)],
        ),
        p(
          classes: 'text-slate-500 leading-relaxed',
          [text(description)],
        ),
      ],
    );
  }
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//  SVG ICON CONSTANTS (Lucide equivalents)
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

const _menuIcon =
    '<svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="4" x2="20" y1="12" y2="12"/><line x1="4" x2="20" y1="6" y2="6"/><line x1="4" x2="20" y1="18" y2="18"/></svg>';

const _xIcon =
    '<svg class="w-6 h-6" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>';

const _calendarIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/></svg>';

const _fileTextIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M15 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V7Z"/><path d="M14 2v4a2 2 0 0 0 2 2h4"/><path d="M10 9H8"/><path d="M16 13H8"/><path d="M16 17H8"/></svg>';

const _usersIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>';

const _shieldCheckIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/><path d="m9 12 2 2 4-4"/></svg>';

const _barChartIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 3v18h18"/><path d="M18 17V9"/><path d="M13 17V5"/><path d="M8 17v-3"/></svg>';

const _zapIcon =
    '<svg class="w-8 h-8 {{COLOR}}" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M4 14a1 1 0 0 1-.78-1.63l9.9-10.2a.5.5 0 0 1 .86.46l-1.92 6.02A1 1 0 0 0 13 10h7a1 1 0 0 1 .78 1.63l-9.9 10.2a.5.5 0 0 1-.86-.46l1.92-6.02A1 1 0 0 0 11 14z"/></svg>';
