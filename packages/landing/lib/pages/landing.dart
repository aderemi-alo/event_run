import 'package:jaspr/ui.dart';
import 'package:landing/components/landing_footer.dart';
import 'package:landing/components/navigation_bar.dart';

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
        NavigationBar(),

        // ─── Hero Section ───
        _buildHero(),

        // ─── Features Grid ───
        _buildFeatureDeepDive1(),
        _buildFeatureDeepDive2(),
        _buildFeatures(),

        _buildHowItWorks(),

        // ─── Testimonial Section ───
        // _buildTestimonial(),

        // ─── CTA Section ───
        _buildCta(),

        // ─── Footer ───
        Footer(),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  NAVIGATION
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  HERO SECTION
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  Component _buildHero() {
    return section(
      classes:
          'pt-32 pb-16 md:pt-48 md:pb-32 px-4 sm:px-6 lg:px-8 max-w-7xl mx-auto text-center',
      [
        // // Badge
        // div(
        //   classes:
        //       'inline-flex items-center px-3 py-1 rounded-full bg-teal-50 text-teal-700 text-xs font-semibold mb-8 border border-teal-100',
        //   [
        //     span(classes: 'flex h-2 w-2 rounded-full bg-teal-500 mr-2', []),
        //     text('New: Professional Invoice Generator'),
        //   ],
        // ),

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
              [text('Get Started For Free')],
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

        // // Social Proof
        // div(
        //   classes: 'mt-16 pt-8 border-t border-slate-100',
        //   [
        //     p(
        //       classes:
        //           'text-sm font-medium text-slate-400 mb-6 uppercase tracking-wider',
        //       [text('Trusted by 500+ Vendors in Lagos, Abuja & PH')],
        //     ),
        //     div(
        //       classes:
        //           'flex flex-wrap justify-center gap-8 md:gap-16 opacity-50 grayscale hover:grayscale-0 transition-all duration-500',
        //       [
        //         span(
        //             classes: 'text-xl font-bold text-slate-800',
        //             [text('WeddingDigest')]),
        //         span(
        //             classes: 'text-xl font-bold text-slate-800',
        //             [text('BellaNaija Weddings')]),
        //         span(
        //             classes: 'text-xl font-bold text-slate-800',
        //             [text('SugarWeddings')]),
        //         span(
        //             classes: 'text-xl font-bold text-slate-800',
        //             [text('EventLife NG')]),
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  //  FEATURES GRID
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  Component _buildFeatureDeepDive1() {
    // Feature Deep Dive 1: Conflict Management
    return section(
      id: 'features',
      classes: 'py-20 bg-white overflow-hidden',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'lg:grid lg:grid-cols-2 lg:gap-16 items-center',
              [
                // LEFT – Visual
                div(
                  classes: 'mb-12 lg:mb-0 relative',
                  [
                    div(
                      classes:
                          'relative mx-auto w-full max-w-[500px] aspect-square lg:aspect-[4/3] bg-slate-100 rounded-3xl overflow-hidden shadow-2xl border border-slate-200',
                      [
                        div(
                            classes:
                                'absolute top-0 left-0 w-full h-full bg-slate-50 opacity-50',
                            []),
                        div(
                          classes:
                              'absolute top-10 left-10 right-10 bottom-10 bg-white rounded-xl shadow-lg p-6',
                          [
                            // Header
                            div(
                              classes: 'flex justify-between items-center mb-6',
                              [
                                div(
                                    classes: 'h-4 w-32 bg-slate-200 rounded',
                                    []),
                                div(
                                    classes:
                                        'h-8 w-8 bg-slate-100 rounded-full',
                                    []),
                              ],
                            ),

                            // Calendar grid
                            div(
                              classes: 'grid grid-cols-7 gap-2 mb-4',
                              [
                                for (var i = 0; i < 7; i++)
                                  div(classes: 'h-4 bg-slate-50 rounded', []),
                              ],
                            ),

                            // Events
                            div(
                              classes: 'space-y-3',
                              [
                                // Success row
                                div(
                                  classes:
                                      'flex items-center p-3 bg-green-50 border border-green-100 rounded-lg',
                                  [
                                    div(
                                      classes:
                                          'h-8 w-8 rounded-full bg-green-200 flex items-center justify-center text-green-700 mr-3',
                                      [
                                        raw(
                                          check.replaceFirst(
                                            RegExp(r'class="[^"]*"'),
                                            'class="w-4 h-4"',
                                          ),
                                        ),
                                      ],
                                    ),
                                    div(
                                      [
                                        div(
                                            classes:
                                                'h-3 w-24 bg-green-200 rounded mb-1',
                                            []),
                                        div(
                                            classes:
                                                'h-2 w-16 bg-green-100 rounded',
                                            []),
                                      ],
                                    ),
                                  ],
                                ),

                                // Conflict alert
                                div(
                                  classes:
                                      'relative p-4 bg-red-50 border border-red-100 rounded-xl shadow-lg transform scale-105 border-l-4 border-l-red-500',
                                  [
                                    div(
                                        classes:
                                            'absolute -right-2 -top-2 bg-red-500 text-white text-[10px] font-bold px-2 py-1 rounded-full uppercase tracking-wide animate-bounce',
                                        [
                                          text('Conflict'),
                                        ]),
                                    div(
                                      classes: 'flex items-start',
                                      [
                                        div(
                                          classes: 'mr-3 mt-0.5 text-red-600',
                                          [
                                            raw(
                                              alertCircle.replaceFirst(
                                                RegExp(r'class="[^"]*"'),
                                                'class="w-5 h-5"',
                                              ),
                                            ),
                                          ],
                                        ),
                                        div(
                                          [
                                            h4(
                                              classes:
                                                  'text-sm font-bold text-red-900',
                                              [
                                                text('Double Booking Detected!')
                                              ],
                                            ),
                                            p(
                                              classes:
                                                  'text-xs text-red-700 mt-1',
                                              [
                                                text(
                                                  'You don\'t have enough speakers for "Okoye Wedding" on Nov 25th.',
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // RIGHT – Text
                div(
                  [
                    div(
                      classes:
                          'inline-flex items-center px-3 py-1 rounded-full bg-red-50 text-red-600 text-xs font-bold uppercase tracking-wider mb-4',
                      [text('Stop Losing Money')],
                    ),
                    h2(
                      classes:
                          'text-3xl md:text-4xl font-bold text-slate-900 mb-6',
                      [text('Never double book your equipment again.')],
                    ),
                    p(
                      classes: 'text-lg text-slate-600 mb-8 leading-relaxed',
                      [
                        text(
                          'EventRun automatically checks your inventory availability before you confirm a job. If you try to book the same speakers or chairs for two different events on the same day, we\'ll warn you instantly.',
                        )
                      ],
                    ),
                    ul(
                      classes: 'space-y-4',
                      [
                        for (final item in [
                          'Real-time inventory tracking',
                          'Visual conflict alerts',
                          'Equipment availability forecast',
                        ])
                          li(
                            classes: 'flex items-center',
                            [
                              div(
                                classes:
                                    'flex-shrink-0 h-6 w-6 rounded-full bg-teal-100 flex items-center justify-center mr-3 text-teal-600',
                                [
                                  raw(
                                    check.replaceFirst(
                                      RegExp(r'class="[^"]*"'),
                                      'class="w-3.5 h-3.5"',
                                    ),
                                  ),
                                ],
                              ),
                              span(
                                classes: 'text-slate-700 font-medium',
                                [text(item)],
                              ),
                            ],
                          ),
                      ],
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

  Component _buildFeatureDeepDive2() {
    // Feature Deep Dive 2: Invoicing
    return section(
      classes: 'py-20 bg-slate-50 overflow-hidden',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'lg:grid lg:grid-cols-2 lg:gap-16 items-center',
              [
                // LEFT – Text (order-2 on mobile, order-1 on desktop)
                div(
                  classes: 'order-2 lg:order-1',
                  [
                    div(
                      classes:
                          'inline-flex items-center px-3 py-1 rounded-full bg-blue-50 text-blue-600 text-xs font-bold uppercase tracking-wider mb-4',
                      [text('Get Paid Faster')],
                    ),
                    h2(
                      classes:
                          'text-3xl md:text-4xl font-bold text-slate-900 mb-6',
                      [text('Professional invoices sent via WhatsApp.')],
                    ),
                    p(
                      classes: 'text-lg text-slate-600 mb-8 leading-relaxed',
                      [
                        text(
                          'Create branded invoices in seconds and share them directly to your client\'s WhatsApp or Email. Track who has paid and who owes you money with a simple dashboard.',
                        ),
                      ],
                    ),
                    ul(
                      classes: 'space-y-4',
                      [
                        for (final item in [
                          'Generate PDF invoices instantly',
                          'One-click WhatsApp sharing',
                          'Track deposits and balances',
                        ])
                          li(
                            classes: 'flex items-center',
                            [
                              div(
                                classes:
                                    'flex-shrink-0 h-6 w-6 rounded-full bg-blue-100 flex items-center justify-center mr-3 text-blue-600',
                                [
                                  raw(
                                    check.replaceFirst(
                                      RegExp(r'class="[^"]*"'),
                                      'class="w-3.5 h-3.5"',
                                    ),
                                  ),
                                ],
                              ),
                              span(
                                classes: 'text-slate-700 font-medium',
                                [text(item)],
                              ),
                            ],
                          ),
                      ],
                    ),
                    div(
                      classes: 'mt-8',
                      [
                        a(
                          href: '/onboarding',
                          classes:
                              'text-teal-600 font-bold hover:text-teal-700 flex items-center group',
                          [
                            text('Start sending invoices'),
                            span(
                              classes:
                                  'w-5 h-5 ml-2 transform group-hover:translate-x-1 transition-transform inline-flex',
                              [
                                raw(
                                  arrowRight.replaceFirst(
                                    RegExp(r'class="[^"]*"'),
                                    'class="w-5 h-5"',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // RIGHT – Visual (order-1 on mobile, order-2 on desktop)
                div(
                  classes: 'mb-12 lg:mb-0 order-1 lg:order-2 relative',
                  [
                    // Abstract App Visual - Invoice (phone mock)
                    div(
                      classes:
                          'relative mx-auto w-full max-w-[400px] h-[500px] bg-slate-900 rounded-[3rem] p-4 shadow-2xl border-4 border-slate-800',
                      [
                        div(
                          classes:
                              'bg-white w-full h-full rounded-[2.5rem] overflow-hidden relative',
                          [
                            // Phone Header
                            div(
                              classes:
                                  'h-14 bg-teal-600 w-full flex items-center px-6 text-white justify-between',
                              [
                                div(
                                  classes: 'flex items-center space-x-2',
                                  [
                                    div(
                                        classes:
                                            'w-8 h-8 rounded-full bg-teal-500',
                                        []),
                                    div(
                                        classes: 'h-3 w-20 bg-teal-500 rounded',
                                        []),
                                  ],
                                ),
                              ],
                            ),

                            // Chat Interface
                            div(
                              classes: 'p-4 space-y-4 bg-slate-50 h-full',
                              [
                                // Outgoing message 1
                                div(
                                  classes: 'flex justify-end',
                                  [
                                    div(
                                      classes:
                                          'bg-teal-100 text-teal-900 p-3 rounded-2xl rounded-tr-none max-w-[80%] text-sm',
                                      [
                                        p(
                                          [
                                            text(
                                              'Hello Ma, here is the invoice for the upcoming wedding reception.',
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Outgoing message 2: PDF card
                                div(
                                  classes: 'flex justify-end',
                                  [
                                    div(
                                      classes:
                                          'bg-white border border-slate-200 p-3 rounded-2xl rounded-tr-none max-w-[85%] shadow-sm',
                                      [
                                        div(
                                          classes:
                                              'flex items-center space-x-3 mb-2',
                                          [
                                            div(
                                              classes:
                                                  'w-10 h-10 bg-red-100 rounded-lg flex items-center justify-center text-red-500',
                                              [
                                                raw(
                                                  fileText.replaceFirst(
                                                    RegExp(r'class="[^"]*"'),
                                                    'class="w-5 h-5"',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            div(
                                              [
                                                p(
                                                  classes:
                                                      'font-bold text-slate-900 text-sm',
                                                  [text('INV-0042.pdf')],
                                                ),
                                                p(
                                                  classes:
                                                      'text-xs text-slate-500',
                                                  [text('145 KB • PDF')],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        div(
                                          classes:
                                              'h-8 bg-slate-100 rounded text-center text-xs font-bold text-slate-600 leading-8',
                                          [text('Tap to view')],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // Incoming message
                                div(
                                  classes: 'flex justify-start',
                                  [
                                    div(
                                      classes:
                                          'bg-white text-slate-800 p-3 rounded-2xl rounded-tl-none max-w-[80%] text-sm shadow-sm border border-slate-100',
                                      [
                                        p(
                                          [
                                            text(
                                                'Seen! Payment sent. Thanks Ola.')
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
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

  Component _buildFeatures() {
    return section(
      classes: 'py-20 bg-white',
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
                      'We built EventRun specifically for Nigerian event vendors.',
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

  Component _buildHowItWorks() {
    return section(
      id: 'how-it-works',
      classes: 'py-20 bg-slate-900 text-white',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            // Header
            div(
              classes: 'text-center mb-16',
              [
                h2(
                  classes: 'text-3xl md:text-4xl font-bold mb-4',
                  [text('How EventRun Works')],
                ),
                p(
                  classes: 'text-lg text-slate-400 max-w-2xl mx-auto',
                  [
                    text(
                      'Get up and running in less than 5 minutes. No complex training required.',
                    ),
                  ],
                ),
              ],
            ),

            // Steps
            div(
              classes: 'relative',
              [
                // Connector line (Desktop)
                div(
                  classes:
                      'hidden md:block absolute top-12 left-0 w-full h-0.5 bg-slate-700',
                  [],
                ),

                div(
                  classes: 'grid md:grid-cols-3 gap-12',
                  [
                    // Step 1
                    div(
                      classes:
                          'relative flex flex-col items-center text-center',
                      [
                        div(
                          classes:
                              'w-24 h-24 bg-slate-800 border-4 border-slate-900 rounded-full flex items-center justify-center z-10 mb-6 shadow-xl',
                          [
                            // Users icon
                            div(
                              classes: 'text-teal-400',
                              [
                                raw(
                                  users.replaceFirst(
                                    RegExp(r'class="[^"]*"'),
                                    'class="w-10 h-10"',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        h3(
                          classes: 'text-xl font-bold mb-3',
                          [text('Create your account')],
                        ),
                        p(
                          classes: 'text-slate-400 leading-relaxed',
                          [
                            text(
                              'Sign up and enter your business details. Add your inventory items and existing client list.',
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Step 2
                    div(
                      classes:
                          'relative flex flex-col items-center text-center',
                      [
                        div(
                          classes:
                              'w-24 h-24 bg-slate-800 border-4 border-slate-900 rounded-full flex items-center justify-center z-10 mb-6 shadow-xl',
                          [
                            // Calendar icon
                            div(
                              classes: 'text-blue-400',
                              [
                                raw(
                                  calendar.replaceFirst(
                                    RegExp(r'class="[^"]*"'),
                                    'class="w-10 h-10"',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        h3(
                          classes: 'text-xl font-bold mb-3',
                          [text('Add your events')],
                        ),
                        p(
                          classes: 'text-slate-400 leading-relaxed',
                          [
                            text(
                              'Log your upcoming jobs. We\'ll instantly tell you if you have enough equipment available.',
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Step 3
                    div(
                      classes:
                          'relative flex flex-col items-center text-center',
                      [
                        div(
                          classes:
                              'w-24 h-24 bg-slate-800 border-4 border-slate-900 rounded-full flex items-center justify-center z-10 mb-6 shadow-xl',
                          [
                            // Credit card icon
                            div(
                              classes: 'text-green-400',
                              [
                                raw(
                                  creditCard.replaceFirst(
                                    RegExp(r'class="[^"]*"'),
                                    'class="w-10 h-10"',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        h3(
                          classes: 'text-xl font-bold mb-3',
                          [text('Get paid')],
                        ),
                        p(
                          classes: 'text-slate-400 leading-relaxed',
                          [
                            text(
                              'Generate an invoice and send it to your client. Know when payment is due.',
                            ),
                          ],
                        ),
                      ],
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
  //  TESTIMONIAL
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // Component _buildTestimonial() {
  //   return section(
  //     classes: 'py-20 bg-white',
  //     [
  //       div(
  //         classes: 'max-w-4xl mx-auto px-4 text-center',
  //         [
  //           // Quote Icon
  //           div(
  //             classes: 'mb-8 flex justify-center',
  //             [
  //               div(
  //                 classes: 'p-3 bg-teal-50 rounded-full',
  //                 [
  //                   raw(
  //                     '<svg class="w-8 h-8 text-teal-600" fill="currentColor" viewBox="0 0 24 24">'
  //                     '<path d="M14.017 21L14.017 18C14.017 16.8954 13.1216 16 12.017 16H9C9.00001 15 9.00001 14 9.00001 13C9.00001 11.8954 9.89543 11 11 11H13V15H17V11V7H13L13 9H11C8.79086 9 7 10.7909 7 13V16C7 18.7614 9.23858 21 12.017 21H14.017ZM21 21L21 18C21 16.8954 20.1046 16 19 16H15.983C15.983 15 15.983 14 15.983 13C15.983 11.8954 16.8784 11 17.983 11H20V15H24V11V7H20L20 9H17.983C15.7739 9 13.983 10.7909 13.983 13V16C13.983 18.7614 16.2216 21 19 21H21Z"/>'
  //                     '</svg>',
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),

  //           // Quote Text
  //           h3(
  //             classes:
  //                 'text-2xl md:text-4xl font-bold text-slate-900 mb-6 leading-tight',
  //             [
  //               text(
  //                 '"Before EventRun, I used to double book my speakers at least once a month. '
  //                 'Since I started using it, I haven\'t had a single conflict and my revenue is up 40%."',
  //               ),
  //             ],
  //           ),

  //           // Attribution
  //           div([
  //             p(
  //               classes: 'font-bold text-slate-900 text-lg',
  //               [text('Chukwudi Onuoha')],
  //             ),
  //             p(
  //               classes: 'text-slate-500',
  //               [text('CEO, SoundKing Rentals, Lagos')],
  //             ),
  //           ]),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
                  'Stop losing money to double-bookings and disorganized operations. EventRun helps Nigerian event vendors run professional, profitable businesses.',
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
              [text('No credit card required')],
            ),
          ],
        ),
      ],
    );
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

const check =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-check-icon lucide-check"><path d="M20 6 9 17l-5-5"/></svg>';

const alertCircle =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-alert-icon lucide-circle-alert"><circle cx="12" cy="12" r="10"/><line x1="12" x2="12" y1="8" y2="12"/><line x1="12" x2="12.01" y1="16" y2="16"/></svg>';

const arrowRight =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-right-icon lucide-arrow-right"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>';

const fileText =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-file-text-icon lucide-file-text"><path d="M6 22a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h8a2.4 2.4 0 0 1 1.704.706l3.588 3.588A2.4 2.4 0 0 1 20 8v12a2 2 0 0 1-2 2z"/><path d="M14 2v5a1 1 0 0 0 1 1h5"/><path d="M10 9H8"/><path d="M16 13H8"/><path d="M16 17H8"/></svg>';

const users =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-users-icon lucide-users"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><path d="M16 3.128a4 4 0 0 1 0 7.744"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><circle cx="9" cy="7" r="4"/></svg>';

const calendar =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-calendar-icon lucide-calendar"><path d="M8 2v4"/><path d="M16 2v4"/><rect width="18" height="18" x="3" y="4" rx="2"/><path d="M3 10h18"/></svg>';

const creditCard =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-credit-card-icon lucide-credit-card"><rect width="20" height="14" x="2" y="5" rx="2"/><line x1="2" x2="22" y1="10" y2="10"/></svg>';
