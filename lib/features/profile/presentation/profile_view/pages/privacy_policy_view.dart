import 'package:find_me_app/core/shared/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        titleText: "Privacy Policy",
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last Update
            const Text(
              "Last Update: 14/08/2024",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 15),

            // Privacy Policy description
            const Text(
              "FindMe is an application created to support families and communities in searching for missing children. "
              "Our mission is to provide a safe and reliable platform that helps in reconnecting lost children with their families, "
              "and to ensure that when these children grow into youth, their data can be matched to increase the chances of reunion.\n\n"
              "We are committed to protecting your privacy and safeguarding any information you share with us. "
              "All personal data, photos, and case details are stored securely and used only for the purpose of identification, "
              "awareness, and connecting families with missing loved ones.",
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 25),

            // Terms & Conditions
            const Text(
              "Terms & Conditions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            _buildTermItem(
              "FindMe is designed only for the purpose of helping families search for their missing children. "
              "The app should never be used for commercial or harmful activities.",
            ),
            _buildTermItem(
              "Users are responsible for providing accurate information (photos, age, location, and case details). "
              "False or misleading data may negatively affect the matching process and could harm other families.",
            ),
            _buildTermItem(
              "All data provided will be used solely for identification and awareness purposes. "
              "We do not share your personal information with third parties without consent.",
            ),
            _buildTermItem(
              "The app may use AI technology to analyze and match children's photos with potential youth identities. "
              "While we strive for high accuracy, FindMe does not guarantee 100% matching results.",
            ),
            _buildTermItem(
              "By using FindMe, you agree to these terms and acknowledge that the service is provided to support families, "
              "not as a replacement for official authorities or legal processes.",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
