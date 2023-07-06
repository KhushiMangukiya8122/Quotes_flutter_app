import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Quotes for you",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 200,
              width: Get.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/lock.jpg"),
              ),),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "We are committed to ensuring the security and privacy of our users when they use our mobile application. This section outlines the measures we take to protect your information and maintain your privacy.\nData Collection and Usage:\nWe collect and use personal information from users solely for the purpose of providing and improving our mobile application's services. The types of personal information we may collect include but are not limited to name, email address, phone number, and usage data. We do not collect any personal information without your consent or unless it is necessary for the functionality of the app.\nData Storage and Protection:\nWe implement appropriate security measures to protect the personal information collected from unauthorized access, alteration, disclosure, or destruction. We use industry-standard encryption protocols to safeguard sensitive data during transmission and storage. Our data storage systems are protected by firewalls, access controls, and regular security assessments.\nSharing of Personal Information:\nWe do not sell, trade, or rent personal information to third parties. However, we may share personal information with trusted third-party service providers who assist us in delivering our services. These providers are bound by confidentiality agreements and are only authorized to use the information for specific purposes related to our app's functionality.\nData Retention:\nWe retain personal information for as long as necessary to fulfill the purposes for which it was collected and to comply with applicable laws and regulations. Once the data is no longer required, we will securely delete or anonymize it.\nUser Control and Rights:\nWe respect your rights regarding your personal information. You have the right to access, correct, or delete your personal information stored in our app's databases. You may also have the right to restrict or object to certain processing activities. We provide mechanisms within the app for users to manage their data and privacy preferences.\nThird-Party Services and Links:\nOur mobile application may contain links to third-party websites or services. We are not responsible for the privacy practices or the content of these third parties. We encourage users to review the privacy policies of these external services before interacting with them.\nChildren's Privacy:\nOur mobile application is not intended for children under the age of 13. We do not knowingly collect personal information from children. If we become aware that personal information of a child under 13 has been inadvertently collected, we will take immediate steps to delete it from our records.\nUpdates to the Privacy Policy:\nWe reserve the right to update or modify this privacy policy at any time. When we make changes, we will revise the 'last updated' date at the top of this policy. Significant changes will be communicated to users through prominent notifications or other appropriate means.",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
