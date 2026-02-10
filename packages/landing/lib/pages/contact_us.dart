import 'package:jaspr/jaspr.dart';
import 'package:landing/components/landing_footer.dart';
import 'package:landing/components/navigation_bar.dart';

/// Contact page (Jaspr)
/// Note: This mirrors your React UI and keeps the same Tailwind classes.
/// For real submissions, replace the simulated delay with an API call.
///
/// Assumes you already have helper widgets like `appNav()` and `appFooter()`
/// from your other pages. If not, keep the inline nav/footer below.
class ContactPage extends StatefulComponent {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool isMenuOpen = false;

  String name = '';
  String email = '';
  String phone = '';
  String message = '';

  bool isSubmitting = false;
  bool submitted = false;

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);

  void resetForm() {
    setState(() {
      name = '';
      email = '';
      phone = '';
      message = '';
    });
  }

  Future<void> handleSubmit() async {
    if (isSubmitting) return;

    setState(() => isSubmitting = true);

    // Simulate API call
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    setState(() {
      isSubmitting = false;
      submitted = true;
    });
    resetForm();
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes:
          'min-h-screen bg-slate-50 font-sans text-slate-900 overflow-x-hidden',
      [
        NavigationBar(),

        // Header
        section(
          classes: 'pt-32 pb-12 px-4 text-center bg-white',
          [
            h1(
              classes:
                  'text-4xl md:text-5xl font-extrabold text-slate-900 tracking-tight mb-4',
              [text('Get in Touch')],
            ),
            p(
              classes: 'text-lg text-slate-500 max-w-2xl mx-auto',
              [text("Have questions about EventRun? We're here to help.")],
            ),
          ],
        ),

        // Content
        section(
          classes: 'pb-20 bg-white px-4 sm:px-6 lg:px-8',
          [
            div(
              classes:
                  'max-w-7xl mx-auto grid grid-cols-1 lg:grid-cols-2 gap-12',
              [
                // Contact Info
                div(
                  classes:
                      'bg-slate-50 p-8 rounded-2xl border border-slate-200',
                  [
                    h3(
                      classes: 'text-2xl font-bold text-slate-900 mb-6',
                      [text('Contact Information')],
                    ),
                    div(
                      classes: 'space-y-6',
                      [
                        // Email
                        div(
                          classes: 'flex items-start',
                          [
                            div(
                              classes:
                                  'w-10 h-10 bg-teal-100 text-teal-600 rounded-lg flex items-center justify-center flex-shrink-0 mt-1',
                              [_icon('mail', classes: 'w-5 h-5')],
                            ),
                            div(
                              classes: 'ml-4',
                              [
                                h4(
                                  classes:
                                      'text-sm font-bold text-slate-900 uppercase tracking-wide',
                                  [text('Support Email')],
                                ),
                                p(
                                  classes: 'text-slate-600 mt-1',
                                  [text('support@eventrun.ng')],
                                ),
                                p(
                                  classes: 'text-sm text-slate-500 mt-1',
                                  [text('We typically reply within 24 hours.')],
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Office
                        div(
                          classes: 'flex items-start',
                          [
                            div(
                              classes:
                                  'w-10 h-10 bg-teal-100 text-teal-600 rounded-lg flex items-center justify-center flex-shrink-0 mt-1',
                              [_icon('map-pin', classes: 'w-5 h-5')],
                            ),
                            div(
                              classes: 'ml-4',
                              [
                                h4(
                                  classes:
                                      'text-sm font-bold text-slate-900 uppercase tracking-wide',
                                  [text('Office')],
                                ),
                                p(
                                  classes: 'text-slate-600 mt-1',
                                  [text('Lagos, Nigeria')],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                // Contact Form
                div(
                  classes:
                      'bg-white p-8 rounded-2xl border border-slate-200 shadow-lg',
                  [
                    h3(
                      classes: 'text-2xl font-bold text-slate-900 mb-2',
                      [text('Send us a message')],
                    ),
                    p(
                      classes: 'text-slate-500 mb-6',
                      [
                        text(
                            "Fill out the form below and we'll get back to you shortly.")
                      ],
                    ),
                    if (submitted)
                      div(
                        classes:
                            'bg-green-50 border border-green-200 rounded-xl p-6 text-center',
                        [
                          div(
                            classes:
                                'w-12 h-12 bg-green-100 text-green-600 rounded-full flex items-center justify-center mx-auto mb-4',
                            [_icon('send', classes: 'w-6 h-6')],
                          ),
                          h4(
                            classes: 'text-lg font-bold text-green-800 mb-2',
                            [text('Message Sent!')],
                          ),
                          p(
                            classes: 'text-green-700',
                            [
                              text(
                                  "Thanks for reaching out. We'll be in touch soon.")
                            ],
                          ),
                          button(
                            classes:
                                'mt-4 text-sm font-medium text-green-700 underline hover:text-green-800',
                            events: {
                              'click': (e) {
                                e.preventDefault();
                                setState(() => submitted = false);
                              }
                            },
                            [text('Send another message')],
                          ),
                        ],
                      )
                    else
                      form(
                        events: {
                          'submit': (e) {
                            e.preventDefault();
                            handleSubmit();
                          },
                        },
                        classes: 'space-y-4',
                        [
                          // Full Name
                          div([
                            label(
                              classes:
                                  'block text-sm font-medium text-slate-700 mb-1',
                              attributes: {'for': 'name'},
                              [text('Full Name')],
                            ),
                            input(
                              classes:
                                  'w-full px-4 py-3 rounded-lg border border-slate-300 focus:ring-2 focus:ring-teal-500 focus:border-transparent outline-none transition-all',
                              attributes: {
                                'id': 'name',
                                'name': 'name',
                                'type': 'text',
                                'required': 'true',
                                'placeholder': 'Your name',
                                'value': name,
                              },
                              events: events(
                                onInput: (value) =>
                                    setState(() => name = value.toString()),
                              ),
                            ),
                          ]),

                          // Email + Phone
                          div(
                            classes: 'grid grid-cols-1 md:grid-cols-2 gap-4',
                            [
                              div([
                                label(
                                  classes:
                                      'block text-sm font-medium text-slate-700 mb-1',
                                  attributes: {'for': 'email'},
                                  [text('Email Address')],
                                ),
                                input(
                                  classes:
                                      'w-full px-4 py-3 rounded-lg border border-slate-300 focus:ring-2 focus:ring-teal-500 focus:border-transparent outline-none transition-all',
                                  attributes: {
                                    'id': 'email',
                                    'name': 'email',
                                    'type': 'email',
                                    'required': 'true',
                                    'placeholder': 'you@company.com',
                                    'value': email,
                                  },
                                  events: events(
                                    onInput: (value) => setState(
                                        () => email = value.toString()),
                                  ),
                                ),
                              ]),
                              div([
                                label(
                                  classes:
                                      'block text-sm font-medium text-slate-700 mb-1',
                                  attributes: {'for': 'phone'},
                                  [
                                    text('Phone Number '),
                                    span(
                                      classes: 'text-slate-400 font-normal',
                                      [text('(Optional)')],
                                    ),
                                  ],
                                ),
                                input(
                                  classes:
                                      'w-full px-4 py-3 rounded-lg border border-slate-300 focus:ring-2 focus:ring-teal-500 focus:border-transparent outline-none transition-all',
                                  attributes: {
                                    'id': 'phone',
                                    'name': 'phone',
                                    'type': 'tel',
                                    'placeholder': '+234...',
                                    'value': phone,
                                  },
                                  events: events(
                                    onInput: (value) => setState(
                                        () => phone = value.toString()),
                                  ),
                                ),
                              ]),
                            ],
                          ),

                          // Message
                          div([
                            label(
                              classes:
                                  'block text-sm font-medium text-slate-700 mb-1',
                              attributes: {'for': 'message'},
                              [text('Message')],
                            ),
                            textarea(
                              classes:
                                  'w-full px-4 py-3 rounded-lg border border-slate-300 focus:ring-2 focus:ring-teal-500 focus:border-transparent outline-none transition-all resize-none',
                              attributes: {
                                'id': 'message',
                                'name': 'message',
                                'required': 'true',
                                'rows': '4',
                                'placeholder': 'How can we help you?',
                              },
                              events: events(
                                onInput: (value) =>
                                    setState(() => message = value.toString()),
                              ),
                              [text(message)],
                            ),
                          ]),

                          // Submit
                          button(
                            classes:
                                'w-full bg-teal-600 hover:bg-teal-700 text-white font-bold py-3.5 px-6 rounded-xl shadow-lg shadow-teal-600/20 flex items-center justify-center transition-all disabled:opacity-70',
                            attributes: {
                              'type': 'submit',
                              if (isSubmitting) 'disabled': 'true',
                            },
                            [
                              if (isSubmitting)
                                _icon('loader-2',
                                    classes: 'w-5 h-5 animate-spin')
                              else
                                text('Send Message'),
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

        Footer(),
      ],
    );
  }
}

/// ---------- Minimal icon helper (Lucide-like SVG placeholders) ----------
/// If you're already using a Jaspr SVG/icon package, swap this out.
/// For now it renders a <span> with a data-icon marker so your CSS/JS
/// can replace it, or you can paste actual SVGs.
Component _icon(String name, {String? classes}) {
  return span(
    classes: classes,
    attributes: {'data-icon': name, 'aria-hidden': 'true'},
    [text('')],
  );
}
