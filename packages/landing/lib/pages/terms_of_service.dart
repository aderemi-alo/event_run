import 'package:jaspr/jaspr.dart';
import 'package:landing/components/landing_footer.dart';
import 'package:landing/components/navigation_bar.dart';

// Assumes you already have Lucide SVG strings like your `check`:
// const menu = '...';   // lucide menu svg
// const xIcon = '...';  // lucide x svg

class TermsOfServicePage extends StatefulComponent {
  const TermsOfServicePage({super.key});

  @override
  State<TermsOfServicePage> createState() => _TermsOfServicePageState();
}

class _TermsOfServicePageState extends State<TermsOfServicePage> {
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

  // Content
  Component _buildContent() {
    return div(
      classes: 'pt-32 pb-20 px-4 sm:px-6 lg:px-8 max-w-4xl mx-auto',
      [
        h1(
          classes: 'text-3xl md:text-4xl font-extrabold text-slate-900 mb-2',
          [text('EventRun Terms of Service')],
        ),
        p(
          classes: 'text-slate-500 mb-8',
          [
            raw(
              '<strong>Last Updated:</strong> February 9, 2026 | <strong>Effective Date:</strong> February 9, 2026',
            ),
          ],
        ),
        div(
          classes: 'prose prose-slate max-w-none text-slate-700 space-y-8',
          [
            _tosSection(
              title: '1. Agreement to Terms',
              children: [
                p([
                  text(
                    'These Terms of Service ("Terms") constitute a legally binding agreement between you ("User," "you," or "your") and EventRun ("Company," "we," "our," or "us") governing your use of the EventRun platform at eventrun.ng (the "Service").',
                  ),
                ]),
                p(classes: 'mt-2', [
                  text(
                    'Our collection and use of personal data is governed by our Privacy Policy. By using the Service, you also agree to the Privacy Policy.',
                  ),
                ]),
                p(classes: 'mt-2 font-semibold', [
                  text(
                      'BY CREATING AN ACCOUNT OR USING THE SERVICE, YOU AGREE TO BE BOUND BY THESE TERMS.'),
                ]),
                p(classes: 'mt-2', [
                  text(
                      'If you do not agree to these Terms, you may not access or use the Service.'),
                ]),
              ],
            ),

            _tosSection(
              title: '2. Eligibility',
              children: [
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('2.1 Age and Capacity')]),
                p(classes: 'mb-2', [
                  text(
                      'You must be at least 18 years old and have the legal capacity to enter into binding contracts under Nigerian law.'),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('2.2 Business Use')]),
                p(classes: 'mb-2', [
                  text(
                      'EventRun is intended for business use by event vendors (decorators, photographers, DJs, and similar professionals). You represent that you are using the Service for legitimate business purposes.'),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('2.3 Geographic Restrictions')]),
                p([
                  text(
                      'The Service is primarily designed for businesses operating in Nigeria. Use outside Nigeria may have limited functionality.')
                ]),
              ],
            ),

            _tosSection(
              title: '3. Account Registration and Security',
              children: [
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('3.1 Account Creation')]),
                p(classes: 'mb-2', [
                  text(
                      'To use certain features, you must create an account by providing:')
                ]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([text('Valid email address')]),
                    li([text('Business name')]),
                    li([text('Phone number')]),
                    li([text('Password')]),
                  ],
                ),
                p(classes: 'mb-2', [
                  text(
                      'You must provide accurate, complete, and current information.')
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('3.2 Account Security')]),
                p(classes: 'mb-2', [
                  text(
                      'You are responsible for maintaining the confidentiality of your password and all activities that occur under your account. You must notify us immediately of any unauthorized access.'),
                ]),
                p(classes: 'mb-2 font-medium', [text('You agree NOT to:')]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([text('Share your account credentials with others')]),
                    li([
                      text('Create multiple accounts for the same business')
                    ]),
                    li([
                      text('Use another person\'s account without permission')
                    ]),
                  ],
                ),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('3.3 Account Verification')]),
                p([
                  text(
                      'We reserve the right to verify your identity and business information at any time.')
                ]),
              ],
            ),

            _tosSection(
              title: '4. Subscription Plans and Payments',
              children: [
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.1 Service Tiers')]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([
                      raw('<strong>Free Plan:</strong> Limited features as specified on our pricing page')
                    ]),
                    li([
                      raw('<strong>Pro Plan:</strong> ₦6,000/month (or as otherwise specified)')
                    ]),
                    li([text('Additional tiers may be introduced')]),
                  ],
                ),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.2 Payment Terms')]),
                p(classes: 'mb-2', [
                  raw('<strong>Billing Cycle:</strong> Subscriptions are billed monthly in advance. Billing date is the date you subscribe or upgrade.')
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Payment Methods:</strong> We accept payment via Paystack and Flutterwave. You authorize us to charge your payment method automatically each billing cycle.')
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Price Changes:</strong> We reserve the right to change pricing with 30 days\' notice. Price changes will not affect your current billing cycle. Continued use after price changes constitutes acceptance.')
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.3 Taxes')]),
                p(classes: 'mb-2', [
                  text(
                    'Fees may include applicable taxes where required by law. If taxes apply, they will be shown at checkout or on your invoice/receipt.',
                  ),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.4 Refund Policy')]),
                p(classes: 'mb-2', [
                  raw('<strong>Free Plan:</strong> No refunds (no charges).')
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Paid Subscriptions:</strong> No refunds for partial months. If you cancel mid-cycle, you retain access until the end of the billing period. Refunds may be issued at our sole discretion for service failures or technical issues.')
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Chargebacks:</strong> Initiating a chargeback without first contacting us may result in immediate account suspension.')
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.5 Failed Payments')]),
                p(classes: 'mb-2', [
                  text(
                      'If payment fails, we will attempt to charge your payment method up to 3 times. You will receive email notifications. After 7 days of failed payment, your account may be downgraded or suspended. We reserve the right to charge late fees of ₦500 per failed transaction.'),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('4.6 Cancellation')]),
                p([
                  text(
                      'You may cancel your subscription at any time through your account settings. Cancellation takes effect at the end of the current billing period.')
                ]),
              ],
            ),

            _tosSection(
              title: '5. Acceptable Use Policy',
              children: [
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('5.1 Permitted Use')]),
                p(classes: 'mb-2', [
                  text(
                      'You may use the Service to manage your event business operations, create and send invoices, track clients/team/inventory, and generate business reports.'),
                ]),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('5.2 Prohibited Activities')]),
                p(classes: 'mb-2 font-medium', [text('You agree NOT to:')]),
                ul(
                  classes: 'list-disc pl-5 mb-2 space-y-1',
                  [
                    li([
                      raw('<strong>Illegal Activities:</strong> Use the Service for any unlawful purpose, violate Nigerian laws, or infringe IP rights.')
                    ]),
                    li([
                      raw('<strong>Abuse and Harm:</strong> Send spam/fraudulent invoices, transmit viruses, or attempt unauthorized access.')
                    ]),
                    li([
                      raw('<strong>Misrepresentation:</strong> Impersonate another person or business, or create fraudulent accounts.')
                    ]),
                    li([
                      raw('<strong>Resource Abuse:</strong> Use automated scripts excessively, overload servers, or resell the Service without permission.')
                    ]),
                    li([
                      raw('<strong>Offensive Content:</strong> Upload defamatory/obscene content or harass others.')
                    ]),
                  ],
                ),
                h3(
                    classes: 'text-lg font-semibold text-slate-800 mb-2',
                    [text('5.3 Consequences of Violation')]),
                p([
                  text(
                      'Violation may result in warning, temporary suspension, permanent termination, and legal action.')
                ]),
              ],
            ),

            _tosSection(
              title: '6. User Content and Data',
              children: [
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.1 Your Data')],
                ),
                p(classes: 'mb-2', [
                  text(
                    'You retain all rights to the business data you input into the Service. We claim no ownership over your content.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.2 License to EventRun')],
                ),
                p(classes: 'mb-2', [
                  text(
                    'By using the Service, you grant us a limited, non-exclusive, worldwide license to store and process your data to provide the Service, create backups, and display your data back to you. This license terminates when you delete your account.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.3 Data Backup')],
                ),
                p(classes: 'mb-2', [
                  raw(
                    'While we perform regular backups, <strong>you are responsible for maintaining your own backups</strong> of critical business data. We recommend regularly exporting your data.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.4 Data Export')],
                ),
                p(classes: 'mb-2', [
                  text(
                    'You can export your data at any time in CSV or PDF format through the Service.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.5 Content Responsibility')],
                ),
                p(classes: 'mb-2', [
                  text(
                    'You are solely responsible for accuracy, legality, and rights to use any content you upload, and for compliance with client privacy obligations.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('6.6 Data Deletion')],
                ),
                p([
                  text(
                    'Upon account termination, we will delete your data within 30 days, except where retention is required by law.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '7. Intellectual Property',
              children: [
                p(classes: 'mb-2', [
                  raw(
                    'The Service, including software, text, graphics, logos, and design, is owned by EventRun and protected by law. <strong>We grant you a limited, non-exclusive, non-transferable license to access and use the Service</strong> for your business purposes during your subscription.',
                  ),
                ]),
                p(classes: 'mb-2', [
                  text(
                    'You may NOT copy/modify the Service, remove copyright notices, use our trademarks without permission, or mirror the Service.',
                  ),
                ]),
                p([
                  text(
                    'If you provide feedback, we may use it without any obligation to you.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '8. Service Availability and Modifications',
              children: [
                p(classes: 'mb-2', [
                  text(
                    'We strive for 99% uptime but do NOT guarantee uninterrupted access. Service may be unavailable due to maintenance, third-party failures, or force majeure.',
                  ),
                ]),
                p(classes: 'mb-2', [
                  text(
                    'We reserve the right to modify or discontinue features, add new tiers, or update the UI. Significant changes will be announced.',
                  ),
                ]),
                p([
                  text(
                    'We make no commitment to deliver specific roadmap features by specific dates.',
                  ),
                ]),
              ],
            ),
            _tosSection(
              title: '8.1 Third-Party Services',
              children: [
                p([
                  text(
                    'The Service may integrate with third-party services (such as payment providers). We do not control and are not responsible for third-party services, their availability, or their actions.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '9. Disclaimers and Limitations of Liability',
              children: [
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('9.1 "AS IS" Service')],
                ),
                p(
                  classes: 'mb-2 uppercase text-sm font-bold',
                  [
                    text(
                      'The Service is provided "AS IS" and "AS AVAILABLE" without warranties of any kind.',
                    ),
                  ],
                ),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('9.2 No Professional Advice')],
                ),
                p(classes: 'mb-2', [
                  text(
                    'EventRun is a software tool. It does NOT provide legal, tax, accounting, or business consulting advice.',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('9.3 Limitation of Liability')],
                ),
                p(classes: 'mb-2 font-medium', [
                  text('TO THE MAXIMUM EXTENT PERMITTED BY NIGERIAN LAW:'),
                ]),
                p(classes: 'mb-2', [
                  text(
                    'We shall NOT be liable for indirect/consequential damages, third-party service failures, unauthorized access, data errors, or downtime.',
                  ),
                ]),
                p(classes: 'mb-2', [
                  raw(
                    '<strong>TOTAL LIABILITY CAP:</strong> Our total liability shall not exceed the amount you paid us in the 12 months preceding the claim (or ₦50,000, whichever is less).',
                  ),
                ]),
                h3(
                  classes: 'text-lg font-semibold text-slate-800 mb-2',
                  [text('9.4 Exceptions')],
                ),
                p([
                  text(
                    'The above limitations do not apply to liability for death/personal injury caused by negligence, fraud, or liability that cannot be excluded under Nigerian law.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '10. Indemnification',
              children: [
                p([
                  text(
                    'You agree to indemnify, defend, and hold harmless EventRun from any claims, damages, or expenses arising from your use of the Service, your violation of these Terms, third-party rights violations, or fraudulent practices.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '11. Termination',
              children: [
                p(classes: 'mb-2', [
                  raw(
                    '<strong>By You:</strong> Cancel subscription or email support@eventrun.ng.',
                  ),
                ]),
                p(classes: 'mb-2', [
                  raw(
                    '<strong>By Us:</strong> We may suspend/terminate for violation of Terms, payment failure, security risks, or legal requirement.',
                  ),
                ]),
                p([
                  raw(
                    '<strong>Effect:</strong> Access ends immediately (or end of billing period). No refunds for remaining period. Data deleted within 30 days. You remain responsible for outstanding fees.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '12. Dispute Resolution',
              children: [
                p(classes: 'mb-2', [
                  raw('<strong>Governing Law:</strong> Federal Republic of Nigeria.'),
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Jurisdiction:</strong> Exclusive jurisdiction of courts in Lagos, Nigeria.'),
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Informal Resolution:</strong> Contact legal@eventrun.ng first.'),
                ]),
                p([
                  raw(
                    '<strong>Arbitration:</strong> If unresolved, arbitration under Arbitration and Conciliation Act (Nigeria) in Nigeria.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '13. General Provisions',
              children: [
                p(classes: 'mb-2', [
                  text(
                    'These Terms + Privacy Policy constitute the entire agreement. Unenforceable provisions are severable. Failure to enforce is not a waiver. You may not assign rights. We are not liable for force majeure. Notices sent to your email.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '14. Changes to Terms',
              children: [
                p([
                  text(
                    'We reserve the right to modify Terms. Changes effective upon posting. Material changes notified via email (30-day notice). Continued use constitutes acceptance.',
                  ),
                ]),
              ],
            ),

            _tosSection(
              title: '15. Contact Information',
              children: [
                raw(
                  '<p><strong>EventRun Legal Department</strong><br/>Email: legal@eventrun.ng<br/>Support: support@eventrun.ng<br/>Website: https://eventrun.ng</p>',
                ),
              ],
            ),

            _tosSection(
              title: '16. Specific Nigerian Law Compliance',
              children: [
                p(classes: 'mb-2', [
                  raw('<strong>Data Protection:</strong> Compliant with NDPR 2019.'),
                ]),
                p(classes: 'mb-2', [
                  raw('<strong>Consumer Protection:</strong> Subject to FCCPA 2018.'),
                ]),
                p([
                  raw('<strong>Electronic Transactions:</strong> Governed by Cybercrimes Act 2015.'),
                ]),
              ],
            ),

            // Summary box
            section(
              classes: 'bg-slate-100 p-6 rounded-xl border border-slate-200',
              [
                h2(
                  classes: 'text-xl font-bold text-slate-900 mb-4',
                  [text('Summary of Key Terms')],
                ),
                p(
                  classes: 'text-sm text-slate-600 mb-4',
                  [
                    text(
                      'Plain-English summary for convenience only. If anything here conflicts with the full Terms above, the full Terms apply.',
                    ),
                  ],
                ),
                ul(
                  classes: 'space-y-2',
                  [
                    _summaryItem(
                        'You must be 18+ and using EventRun for legitimate business purposes'),
                    _summaryItem(
                        'Subscriptions are billed monthly; no refunds for partial billing periods'),
                    _summaryItem(
                        'You retain ownership of your business data and can export it at any time'),
                    _summaryItem(
                        'You are responsible for maintaining your account security and backups'),
                    _summaryItem(
                      'EventRun is provided "as is" and is a support tool — you must verify bookings, inventory, and client commitments',
                    ),
                    _summaryItem(
                      'We are not liable for losses from missed events, double-bookings, downtime, or business decisions',
                    ),
                    _summaryItem(
                      'Our total liability is limited to the amount you paid in the last 12 months (or ₦50,000, whichever is less)',
                    ),
                    _summaryItem(
                        'We may modify or discontinue features with notice'),
                    _summaryItem(
                        'You may cancel your subscription at any time'),
                    _summaryItem(
                        'These Terms are governed by the laws of the Federal Republic of Nigeria'),
                  ],
                ),
              ],
            ),

            p(
              classes: 'font-bold text-slate-900',
              [
                text(
                  'BY CLICKING "I ACCEPT" OR USING THE SERVICE, YOU ACKNOWLEDGE THAT YOU HAVE READ, UNDERSTOOD, AND AGREE TO BE BOUND BY THESE TERMS OF SERVICE.',
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

  Component _tosSection(
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
