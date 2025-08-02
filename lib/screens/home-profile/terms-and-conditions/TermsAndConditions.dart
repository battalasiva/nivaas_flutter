import 'package:flutter/material.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/enums.dart';
import 'package:nivaas/core/constants/sizes.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/widgets/elements/top_bar.dart';
import 'package:nivaas/widgets/elements/commonMethods.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});
  void _launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: nivaasSupportMobileNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: TopBar(title: 'Terms And Conditions'),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(getWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              'Welcome to NIVAAS!',
              style: txt_18_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            const Text(
              'These terms and conditions govern your use of the NIVAAS mobile application ("App") and related services provided by NIVAAS team ("NIVAAS", "we", "us", "our"). By using our App, you agree to comply with and be bound by these Terms.',
            ),
            const SizedBox(height: 16),
             Text(
              'Acceptance of Terms',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            Text(
              '1. Eligibility:',
              style: txt_14_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'You must be at least 18 years old to use the NIVAAS App. By using the App, you represent and warrant that you are at least 18 years old.',
            ),
            const SizedBox(height: 8),
            Text(
              '2. Modification of Terms:',
              style: txt_14_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'NIVAAS reserves the right to modify or update these Terms at any time without prior notice. Changes will be effective upon posting. Your continued use of the App after changes are posted constitutes your acceptance of the revised Terms.',
            ),
            const SizedBox(height: 16),
            Text(
              'Account Registration',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            Text(
              '1. Account Creation:',
              style: txt_14_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'To access certain features of the App, such as maintenance management or society due reminders and requesting repair services, you may be required to register and create an account. You agree to provide accurate, current, and complete information during registration and to update such information to keep it accurate, current, and complete.',
            ),
            const SizedBox(height: 8),
            Text(
              '2. Account Security:',
              style: txt_14_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'You are responsible for maintaining the confidentiality of your account credentials and for any activities that occur under your account. Notify NIVAAS immediately of any unauthorized use of your account or any other breach of security.',
            ),
            const SizedBox(height: 16),
            Text(
              'Use of the App',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            Text(
              '1. License:',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'NIVAAS grants you a limited, non-exclusive, non-transferable, revocable license to use the App for your personal use only.',
            ),
            const SizedBox(height: 8),
            Text(
              'Features Provided:',
              style: txt_14_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              '1. Notice Board: Users can view community notices, including announcements about festivals, events, or important updates within their apartment complex.',
            ),
            const SizedBox(height: 4),
            const Text(
              '2. Maintenance Management: Apartment administrators can raise a request to onboard their apartment with NIVAAS and onboard all flat owners. They can also share their admin responsibilities with other flat owners and configure maintenance costs.',
            ),
            const SizedBox(height: 4),
            const Text(
              '3. Notification System: The App sends notifications to both tenants and owners regarding their monthly dues and other relevant updates.',
            ),
            const SizedBox(height: 4),
            const Text(
              '4. Society Dues: Flat owners/tenants can view the detailed dues in the application.',
            ),
            const SizedBox(height: 4),
            const Text(
              '5. Record Maintenance: The App maintains detailed records of all transactions and maintenance activities, which can be exported to PDF.',
            ),
            const SizedBox(height: 16),
            Text(
              'Prohibited Conduct',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 4),
            const Text(
              'You agree not to:',
            ),
            const SizedBox(height: 4),
            const Text(
              '1. Violate these Terms or any applicable laws or regulations.',
            ),
            const SizedBox(height: 4),
            const Text(
              '2. Use the App for any illegal or unauthorized purpose.',
            ),
            const SizedBox(height: 4),
            const Text(
              '3. Attempt to gain unauthorized access to any part of the App or its related systems or networks.',
            ),
            const SizedBox(height: 16),
            Text(
              'Help Center',
              style: txt_16_700.copyWith(color: AppColor.black1),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: launchEmail,
              child:  Text(
                'Email: Support@nivaas.homes ',
                style: TextStyle(color: AppColor.primaryColor2, decoration: TextDecoration.underline),
              ),
            ),
            GestureDetector(
              onTap: _launchPhone,
              child:  Text(
                'Mobile Number: 9177333547 ',
                style: TextStyle(color: AppColor.primaryColor2, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16),
            // CustomizedButton(
            //               label: 'OK',
            //               style: txt_16_500.copyWith(color: AppColor.white),
            //               onPressed: (){
            //                 Navigator.pop(context);
            //               },
            //             ),
            // const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
