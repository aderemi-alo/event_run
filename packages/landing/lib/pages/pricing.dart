import 'package:jaspr/jaspr.dart';
import 'package:landing/components/landing_footer.dart';
import 'package:landing/components/navigation_bar.dart';

// Assumes you already have these SVG strings like you did for `check`:
// const checkCircle2 = '...';
// const menu = '...';
// const xIcon = '...';
// const arrowRight = '...';

class PricingPage extends StatelessComponent {
  const PricingPage({super.key});

  // void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes:
          'min-h-screen bg-slate-50 font-sans text-slate-900 overflow-x-hidden',
      [
        NavigationBar(),
        _buildPricingHeader(),
        _buildPricingCards(),
        _buildCta(),
        Footer(),
      ],
    );
  }

  Component _buildPricingHeader() {
    return section(
      classes: 'pt-32 pb-12 px-4 text-center bg-white',
      [
        h1(
          classes:
              'text-4xl md:text-5xl font-extrabold text-slate-900 tracking-tight mb-4',
          [text('Pricing that protects your bookings')],
        ),
        p(
          classes: 'text-lg text-slate-500 max-w-2xl mx-auto',
          [
            text(
                'Start for free, upgrade when you grow. Prices in Nigerian Naira (₦).')
          ],
        ),
      ],
    );
  }

  Component _buildPricingCards() {
    return section(
      classes: 'pb-20 bg-white',
      [
        div(
          classes: 'max-w-7xl mx-auto px-4 sm:px-6 lg:px-8',
          [
            div(
              classes: 'grid md:grid-cols-2 gap-8 max-w-4xl mx-auto',
              [
                _buildStarterCard(),
                _buildProCard(),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _buildStarterCard() {
    return div(
      classes:
          'bg-white rounded-2xl shadow-sm border border-slate-200 p-8 flex flex-col hover:border-teal-200 transition-colors',
      [
        div(
          classes: 'mb-6',
          [
            h3(
              classes: 'text-lg font-bold text-slate-900 mb-2',
              [text('Starter')],
            ),
            div(
              classes: 'flex items-baseline',
              [
                span(
                  classes: 'text-4xl font-extrabold text-slate-900',
                  [text('Free')],
                ),
              ],
            ),
            p(
              classes: 'text-sm text-slate-500 mt-2',
              [text('For testing EventRun on small jobs.')],
            ),
          ],
        ),
        div(
          classes: 'flex-1',
          [
            ul(
              classes: 'space-y-4 mb-8',
              [
                _featureLi('5 events per month'),
                _featureLi('15 clients'),
                _featureLi('30 inventory items'),
                _featureLi('Conflict warnings'),
                _featureLi('Basic dashboard'),
                _featureLi('1 invoice total'),
              ],
            ),
          ],
        ),
        a(
          href: '/signup',
          classes:
              'w-full block text-center py-3 px-4 bg-slate-50 hover:bg-slate-100 text-slate-700 font-bold rounded-xl transition-colors',
          [text('Get Started')],
        ),
      ],
    );
  }

  Component _buildProCard() {
    return div(
      classes:
          'bg-white rounded-2xl shadow-xl border-2 border-teal-500 p-8 flex flex-col relative transform md:-translate-y-4 z-10',
      [
        div(
          classes:
              'absolute top-0 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-teal-500 text-white px-4 py-1 rounded-full text-xs font-bold uppercase tracking-wide',
          [text('Most Popular')],
        ),
        div(
          classes: 'mb-6',
          [
            h3(
              classes: 'text-lg font-bold text-slate-900 mb-2',
              [text('Pro')],
            ),
            div(
              classes: 'flex items-baseline',
              [
                span(
                  classes: 'text-4xl font-extrabold text-slate-900',
                  [text('₦6,000')],
                ),
                span(classes: 'ml-2 text-slate-500', [text('/month')]),
              ],
            ),
            p(
              classes: 'text-sm text-slate-500 mt-2',
              [text('Built for vendors who can’t afford mistakes.')],
            ),
          ],
        ),
        div(
          classes: 'flex-1',
          [
            ul(
              classes: 'space-y-4 mb-8',
              [
                _featureLi('Professional invoices (WhatsApp-ready PDFs)',
                    bold: true),
                _featureLi('Unlimited Events & Inventory', bold: true),
                _featureLi('Automatic conflict detection', bold: true),
                _featureLi('Full Client Management', bold: true),
                _featureLi('Email Support', bold: false),
              ],
            ),
          ],
        ),
        a(
          href: '/signup',
          classes:
              'w-full block text-center py-3 px-4 bg-teal-600 hover:bg-teal-700 text-white font-bold rounded-xl shadow-lg transition-colors',
          [text('Upgrade to Pro')],
        ),
      ],
    );
  }

  Component _featureLi(String label, {bool bold = false}) {
    return li(
      classes:
          'flex items-start text-sm text-slate-700${bold ? ' font-medium' : ''}',
      [
        div(
          classes: 'mr-3 flex-shrink-0 text-teal-500',
          [
            raw(
              checkCircle2.replaceFirst(
                RegExp(r'class="[^"]*"'),
                'class="w-5 h-5"',
              ),
            ),
          ],
        ),
        text(label),
      ],
    );
  }

  Component _buildCta() {
    return section(
      classes: 'py-20 bg-teal-700',
      [
        div(
          classes: 'max-w-4xl mx-auto px-4 text-center',
          [
            h2(
              classes: 'text-3xl md:text-4xl font-bold text-white mb-6',
              [text('Ready to run events without stress?')],
            ),
            p(
              classes: 'text-teal-100 text-lg mb-10 max-w-xl mx-auto',
              [
                text(
                    'Stop losing money to double-bookings and disorganized operations. EventRun helps Nigerian event vendors run professional, profitable businesses.')
              ],
            ),
            a(
              href: '/onboarding',
              classes:
                  'inline-flex items-center px-8 py-4 bg-white text-teal-800 text-lg font-bold rounded-xl shadow-xl transition-transform hover:-translate-y-1',
              [
                text('Upgrade to Pro'),
                span(
                  classes: 'ml-2 inline-flex',
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
            p(
              classes: 'mt-4 text-sm text-teal-200 opacity-80',
              [text('You can start free and upgrade anytime')],
            ),
          ],
        ),
      ],
    );
  }
}

const String checkCircle2 =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-check-icon lucide-circle-check"><circle cx="12" cy="12" r="10"/><path d="m9 12 2 2 4-4"/></svg>';

const String menu =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-menu-icon lucide-menu"><path d="M4 5h16"/><path d="M4 12h16"/><path d="M4 19h16"/></svg>';

const String xIcon =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x-icon lucide-x"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>';

const String arrowRight =
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-arrow-right-icon lucide-arrow-right"><path d="M5 12h14"/><path d="m12 5 7 7-7 7"/></svg>';
