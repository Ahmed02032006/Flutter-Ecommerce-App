import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/main_screen.dart';
import 'package:flutter_application_1/theme/theme.dart';
import 'package:flutter_application_1/widgets/gradient_button.dart';

class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({super.key});

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  String? _selectedLanguage;

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'nativeName': 'English'},
    {'code': 'es', 'name': 'Spanish', 'nativeName': 'Espanol'},
    {'code': 'fr', 'name': 'French', 'nativeName': 'Francais'},
    {'code': 'de', 'name': 'German', 'nativeName': 'Deutsch'},
    {'code': 'it', 'name': 'Italian', 'nativeName': 'Italiano'},
  ];

  void _handleLanguageSelection() {
    if (_selectedLanguage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: AppTheme.textPrimary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose Language",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Select your preferred language",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _languages.length,
                      itemBuilder: (context, index) {
                        final language = _languages[index];
                        final isSelected =
                            language['code'] == _selectedLanguage;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primaryColor
                                  : AppTheme.textSecondary.withOpacity(0.2),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedLanguage = language['code'];
                              });
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          language['name']!,
                                          style: const TextStyle(
                                            color: AppTheme.textPrimary,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          language['nativeName']!,
                                          style: const TextStyle(
                                            color: AppTheme.textSecondary,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? AppTheme.primaryColor
                                            : AppTheme.textSecondary
                                                .withOpacity(0.2),
                                        width: 2,
                                      ),
                                    ),
                                    child: isSelected
                                        ? Container(
                                            margin: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                              color: AppTheme.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: GradientButton(
                        text: "Continue",
                        onPressed: _handleLanguageSelection,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
