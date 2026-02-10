import 'package:jaspr/jaspr.dart';
import 'package:landing/components/landing_footer.dart';
import 'package:landing/components/navigation_bar.dart';

// Assumes you already have Lucide SVG strings like you did for `check`
// const menu = '...';   // lucide menu svg
// const xIcon = '...';  // lucide x svg

class PrivacyPolicyPage extends StatefulComponent {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool isMenuOpen = false;

  void toggleMenu() => setState(() => isMenuOpen = !isMenuOpen);

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield div(
      classes:
          'min-h-screen bg-slate-50 font-sans text-slate-900 overflow-x-hidden',
      [
        NavigationBar(),
        _buildContent(),
        Footer(),
      ],
    );
  }

  Component _buildContent() {
    return div(
      classes: 'pt-32 pb-20 px-4 sm:px-6 lg:px-8 max-w-4xl mx-auto',
      [
        h1(
          classes: 'text-3xl md:text-4xl font-extrabold text-slate-900 mb-2',
          [text('EventRun Privacy Policy')],
        ),
        p(
          classes: 'text-slate-500 mb-8',
          [
            raw(
              '<strong>Last Updated:</strong> February 9, 2026 | <strong>Effective Date:</strong> February 9, 2026',
            ),
          ],
        ),

        // Main prose container
        div(
          classes: 'prose prose-slate max-w-none text-slate-700 space-y-8',
          [
            _ppSection(
              title: 'Introduction',
              children: [
                p([
                  text(
                    'EventRun ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our business management platform at eventrun.ng (the "Service").',
                  ),
                ]),
                p(classes: 'mt-2', [
                  text(
                    'This policy complies with the Nigeria Data Protection Regulation (NDPR) 2019 and other applicable Nigerian laws.',
                  ),
                ]),
                p(classes: 'mt-2 font-semibold', [
                  text(
                    'By using EventRun, you agree to the collection and use of information in accordance with this policy.',
                  ),
                ]),
              ],
            ),

            _ppSection(
              title: '1. Information We Collect',
              children: [
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('1.1 Information You Provide Directly')],
                ),
                p(classes: 'mb-2', [
                  text(
                      'When you create an account or use EventRun, we collect:')
                ]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([
                      raw('<strong>Account Information:</strong> Name, email address, phone number, business name, business type'),
                    ]),
                    li([
                      raw('<strong>Business Data:</strong> Event details, client information, team member details, inventory lists, invoice data'),
                    ]),
                    li([
                      raw('<strong>Payment Information:</strong> We do NOT store credit/debit card details. Payment processing is handled by third-party providers (Paystack/Flutterwave) who maintain their own security standards'),
                    ]),
                    li([
                      raw('<strong>Communications:</strong> Messages you send to our support team, feedback, or survey responses'),
                    ]),
                  ],
                ),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('1.2 Information Collected Automatically')],
                ),
                p(classes: 'mb-2', [
                  text('When you access the Service, we automatically collect:')
                ]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([
                      raw('<strong>Usage Data:</strong> Pages visited, features used, time spent on platform, click patterns')
                    ]),
                    li([
                      raw('<strong>Device Information:</strong> IP address, browser type, device type, operating system')
                    ]),
                    li([
                      raw('<strong>Cookies and Tracking:</strong> We use cookies and similar technologies (see Section 8)')
                    ]),
                  ],
                ),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('1.3 Information from Third Parties')],
                ),
                p([
                  text(
                      'We may receive information from payment processors (transaction status) and analytics providers.'),
                ]),
              ],
            ),

            _ppSection(
              title: '2. How We Use Your Information',
              children: [
                p(classes: 'mb-2', [
                  text(
                      'We use collected information for the following purposes:')
                ]),
                ul(
                  classes: 'list-disc pl-5 space-y-1',
                  [
                    li([
                      raw('<strong>To Provide the Service:</strong> Create/manage accounts, enable event management/invoicing, process payments, provide support.')
                    ]),
                    li([
                      raw('<strong>To Improve Our Service:</strong> Analyze usage patterns, develop new features, conduct research.')
                    ]),
                    li([
                      raw('<strong>To Communicate with You:</strong> Send notifications/updates, respond to inquiries, send marketing communications (opt-out available).')
                    ]),
                    li([
                      raw('<strong>To Ensure Security:</strong> Detect/prevent fraud, monitor threats, enforce Terms of Service.')
                    ]),
                    li([
                      raw('<strong>Legal Compliance:</strong> Comply with Nigerian laws, respond to legal requests.')
                    ]),
                  ],
                ),
              ],
            ),

            _ppSection(
              title: '3. Legal Basis for Processing (NDPR Compliance)',
              children: [
                p(classes: 'mb-2', [
                  text(
                      'Under the Nigeria Data Protection Regulation, we process your personal data based on:'),
                ]),
                ol(
                  classes: 'list-decimal pl-5 space-y-1',
                  [
                    li([
                      raw('<strong>Consent:</strong> You have given clear consent for specific purposes.')
                    ]),
                    li([
                      raw('<strong>Contract:</strong> Processing is necessary to fulfill our service agreement.')
                    ]),
                    li([
                      raw('<strong>Legal Obligation:</strong> Processing is required to comply with Nigerian law.')
                    ]),
                    li([
                      raw('<strong>Legitimate Interest:</strong> Processing is necessary for our legitimate business interests (security, improvement).')
                    ]),
                  ],
                ),
              ],
            ),

            _ppSection(
              title: '4. How We Share Your Information',
              children: [
                p(classes: 'mb-2', [
                  text(
                      'We do NOT sell your personal information. We may share your information with:'),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.1 Service Providers')]),
                p(classes: 'mb-2', [
                  text(
                    'We share data with third parties who help us operate (Paystack/Flutterwave for payments, Supabase for hosting, Google Analytics). They are contractually obligated to protect your data.',
                  ),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.2 Business Transfers')]),
                p(classes: 'mb-2', [
                  text(
                      'If EventRun is acquired or merged, your information may be transferred. You will be notified.')
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.3 Legal Requirements')]),
                p(classes: 'mb-2', [
                  text(
                      'We may disclose information if required by law, court order, or to protect our rights and safety.')
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.4 With Your Consent')]),
                p([
                  text(
                      'We may share information with third parties when you explicitly consent.')
                ]),
              ],
            ),

            _ppSection(
              title: '5. Data Retention',
              children: [
                p(classes: 'mb-2', [
                  text(
                    'We retain your information while your account is active, to provide services, and to comply with legal obligations (e.g., tax records for 6 years).',
                  ),
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Account Deletion:</strong> Upon deletion, we delete or anonymize personal data within 30 days, except where retention is legally required.'),
                ]),
                p([
                  raw('<strong>Business Records:</strong> Invoice data may be retained for up to 7 years for tax compliance.')
                ]),
              ],
            ),

            _ppSection(
              title: '6. Your Data Protection Rights (NDPR Rights)',
              children: [
                p(classes: 'mb-2', [text('You have the right to:')]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([
                      raw('<strong>Access:</strong> Request a copy of your data.')
                    ]),
                    li([
                      raw('<strong>Rectification:</strong> Correct inaccurate information.')
                    ]),
                    li([
                      raw('<strong>Erasure:</strong> Request deletion of your data (Right to be Forgotten).')
                    ]),
                    li([
                      raw('<strong>Data Portability:</strong> Export your data in CSV/PDF format.')
                    ]),
                    li([
                      raw('<strong>Object:</strong> Object to marketing processing.')
                    ]),
                    li([
                      raw('<strong>Withdraw Consent:</strong> Withdraw consent at any time.')
                    ]),
                    li([
                      raw('<strong>Lodge a Complaint:</strong> File a complaint with the NDPC.')
                    ]),
                  ],
                ),
                p([
                  raw('To exercise these rights, contact us at: <strong>privacy@eventrun.ng</strong>'),
                ]),
              ],
            ),

            _ppSection(
              title: '7. Data Security',
              children: [
                // p(
                //   classes: 'mb-2',
                //   [
                //     text(
                //       'We use SSL/TLS encryption, database encryption (AES-256), access controls, and regular backups. However, no internet transmission is 100% secure. You are responsible for keeping your password confidential.',
                //     ),
                //   ],
                // ),
                p(classes: 'mb-2', [
                  text(
                    'We implement reasonable, industry-standard technical and organizational measures to protect personal data against unauthorized access, loss, or misuse.',
                  ),
                ]),
              ],
            ),

            _ppSection(
              title: '8. Cookies and Tracking Technologies',
              children: [
                p(classes: 'mb-2', [
                  text(
                    'We use essential cookies (login), analytics cookies, and preference cookies. You can control cookies via browser settings.',
                  ),
                ]),
              ],
            ),

            _ppSection(
              title: '9. Third-Party Links',
              children: [
                p([
                  text(
                      'Our Service may contain links to third-party sites. We are not responsible for their privacy practices.')
                ]),
              ],
            ),

            _ppSection(
              title: '10. Children\'s Privacy',
              children: [
                p([
                  text(
                      'EventRun is for business use by individuals 18+. We do not knowingly collect data from children under 18.')
                ]),
              ],
            ),

            _ppSection(
              title: '11. International Data Transfers',
              children: [
                p([
                  text(
                      'Data is primarily stored in Nigeria or Africa. If transferred internationally, we ensure safeguards required by NDPR.')
                ]),
              ],
            ),

            _ppSection(
              title: '12. Marketing Communications',
              children: [
                p([
                  text(
                      'We may send promotional emails. You can opt-out via "Unsubscribe" links or settings. Transactional emails cannot be opted out of.')
                ]),
              ],
            ),

            _ppSection(
              title: '13. Changes to This Policy',
              children: [
                p([
                  text(
                      'We may update this policy. Significant changes will be notified via email or platform notice. Continued use constitutes acceptance.')
                ]),
              ],
            ),

            _ppSection(
              title: '14. Data Protection Officer',
              children: [
                p([text('Email: dpo@eventrun.ng')]),
              ],
            ),

            _ppSection(
              title: '15. Contact Us',
              children: [
                raw(
                  '<p><strong>EventRun Privacy Team</strong><br/>Email: privacy@eventrun.ng<br/>Support: support@eventrun.ng<br/>Website: https://eventrun.ng</p>',
                ),
              ],
            ),

            _ppSection(
              title: '16. Complaints and Regulatory Authority',
              children: [
                raw(
                  '<p><strong>Nigeria Data Protection Commission (NDPC)</strong><br/>Website: https://ndpc.gov.ng<br/>Email: info@ndpc.gov.ng</p>',
                ),
              ],
            ),

            // Summary box
            section(
              classes: 'bg-slate-100 p-6 rounded-xl border border-slate-200',
              [
                h2(
                  classes: 'text-xl font-bold text-slate-900 mb-4',
                  [text('Summary of Key Points')],
                ),
                p(
                  classes: 'text-sm text-slate-600 mb-4',
                  [
                    text(
                      'Plain-English summary (for convenience only). If anything here conflicts with the full Privacy Policy above, the full policy applies.',
                    ),
                  ],
                ),
                ul(
                  classes: 'space-y-2',
                  [
                    _summaryItem(
                        'We collect information you provide and limited usage data necessary to operate the Service'),
                    _summaryItem(
                        'We use data to provide and improve our Service'),
                    _summaryItem('We do NOT sell your personal information'),
                    _summaryItem(
                        'We do not use your data for advertising purposes'),
                    _summaryItem(
                        'You have rights under NDPR to access, correct, and delete your data'),
                    _summaryItem(
                        'We use reasonable, industry-standard security measures to protect your data'),
                    _summaryItem('You can export your data anytime'),
                    _summaryItem(
                        'You can delete your account and data upon request'),
                  ],
                ),
              ],
            ),

            p(
              classes: 'font-bold text-slate-900',
              [
                text(
                  'By using EventRun, you acknowledge that you have read and understood this Privacy Policy.',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Component _summaryItem(String label) {
    return li(
      classes: 'flex items-center',
      [
        span(classes: 'mr-2', [text('✅')]),
        text(label),
      ],
    );
  }

  Component _ppSection(
      {required String title, required List<Component> children}) {
    return section(
      [
        h2(
          classes: 'text-xl font-bold text-slate-900 mb-4',
          [text(title)],
        ),
        ...children,
      ],
    );
  }
}
