import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';
import '../constants/app_constants.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final bool showAsList;
  final VoidCallback? onLanguageChanged;

  const LanguageSelectionWidget({
    super.key,
    this.showAsList = false,
    this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        if (showAsList) {
          return _buildLanguageList(context, languageService);
        } else {
          return _buildLanguageDropdown(context, languageService);
        }
      },
    );
  }

  Widget _buildLanguageDropdown(
      BuildContext context, LanguageService languageService) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppConstants.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: languageService.currentLocale.languageCode,
          icon: Icon(
            Icons.language,
            color: AppConstants.primaryColor,
          ),
          onChanged: (String? newValue) async {
            if (newValue != null) {
              await languageService.changeLanguage(newValue);
              onLanguageChanged?.call();
            }
          },
          items: LanguageService.supportedLanguages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    entry.value['flag']!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        entry.value['nativeName']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.textPrimaryColor,
                        ),
                      ),
                      Text(
                        entry.value['name']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppConstants.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLanguageList(
      BuildContext context, LanguageService languageService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Choose Language / भाषा चुनें / ਭਾਸ਼ਾ ਚੁਣੋ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppConstants.textPrimaryColor,
            ),
          ),
        ),
        ...LanguageService.supportedLanguages.entries.map((entry) {
          final isSelected =
              languageService.currentLocale.languageCode == entry.key;

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppConstants.primaryColor.withOpacity(0.1)
                  : AppConstants.cardColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? AppConstants.primaryColor
                    : Colors.grey.withOpacity(0.3),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppConstants.backgroundColor,
                ),
                child: Center(
                  child: Text(
                    entry.value['flag']!,
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              title: Text(
                entry.value['nativeName']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isSelected
                      ? AppConstants.primaryColor
                      : AppConstants.textPrimaryColor,
                ),
              ),
              subtitle: Text(
                entry.value['name']!,
                style: TextStyle(
                  fontSize: 14,
                  color: AppConstants.textSecondaryColor,
                ),
              ),
              trailing: isSelected
                  ? Icon(
                      Icons.check_circle,
                      color: AppConstants.primaryColor,
                      size: 28,
                    )
                  : Icon(
                      Icons.radio_button_unchecked,
                      color: AppConstants.textSecondaryColor,
                      size: 28,
                    ),
              onTap: () async {
                if (!isSelected) {
                  await languageService.changeLanguage(entry.key);
                  onLanguageChanged?.call();
                }
              },
            ),
          );
        }).toList(),

        // Special note for Nabha users when Punjabi is available
        if (LanguageService.supportedLanguages.containsKey('pa'))
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppConstants.secondaryColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: AppConstants.secondaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'ਨਾਭਾ ਸ਼ਹਿਰ ਦੇ ਨਿਵਾਸੀਆਂ ਲਈ ਪੰਜਾਬੀ ਵਿੱਚ ਖਾਸ ਸਮੱਗਰੀ ਉਪਲਬਧ ਹੈ\nSpecial content for Nabha city residents in Punjabi',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppConstants.secondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// Dialog for language selection
class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const LanguageSelectionDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppConstants.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400, maxHeight: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Select Language',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: LanguageSelectionWidget(
                showAsList: true,
                onLanguageChanged: () {
                  // Close dialog after language change
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
