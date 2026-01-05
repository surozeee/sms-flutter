import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String defaultLanguage = 'en';
  
  static const Map<String, Map<String, String>> _translations = {
    'en': {
      // Dashboard
      'dashboard': 'Dashboard',
      'welcome': 'Welcome',
      'manage_campaigns': 'Manage your SMS campaigns efficiently',
      'sms_sent': 'SMS Sent',
      'today': 'Today',
      'quick_actions': 'Quick Actions',
      'load_contacts': 'Load Contacts',
      'send_sms': 'Send SMS',
      'image_share': 'Image Share',
      'share_connect': 'Share & Connect',
      'share_app': 'Share App',
      'settings': 'Settings',
      'logout': 'Logout',
      'contacts': 'Contacts',
      'statistics': 'Statistics',
      
      // Search
      'search': 'Search',
      'advanced_search': 'Advanced Search',
      'search_contacts': 'Search Contacts',
      'search_by_name': 'Search by Name',
      'search_by_phone': 'Search by Phone',
      'search_by_carrier': 'Search by Carrier',
      'filter_by_carrier': 'Filter by Carrier',
      'all_carriers': 'All Carriers',
      'ntc': 'NTC',
      'ncell': 'Ncell',
      'smart': 'Smart',
      'unknown': 'Unknown',
      'clear_filters': 'Clear Filters',
      'no_results': 'No results found',
      'results_count': 'Found {count} contact(s)',
      'enter_search_term': 'Enter search term...',
      'select_carrier': 'Select Carrier',
      'view_results': 'View Results',
      'select_language': 'Select Language',
      
      // Common
      'cancel': 'Cancel',
      'apply': 'Apply',
      'reset': 'Reset',
      'close': 'Close',
      'loading': 'Loading...',
    },
    'ne': {
      // Dashboard
      'dashboard': 'ड्यासबोर्ड',
      'welcome': 'स्वागत छ',
      'manage_campaigns': 'तपाईंको SMS अभियानहरू कुशलतापूर्वक व्यवस्थापन गर्नुहोस्',
      'sms_sent': 'SMS पठाइयो',
      'today': 'आज',
      'quick_actions': 'छिटो कार्यहरू',
      'load_contacts': 'सम्पर्कहरू लोड गर्नुहोस्',
      'send_sms': 'SMS पठाउनुहोस्',
      'image_share': 'छवि साझेदारी',
      'share_connect': 'साझेदारी र जडान',
      'share_app': 'एप साझेदारी गर्नुहोस्',
      'settings': 'सेटिङहरू',
      'logout': 'लगआउट',
      'contacts': 'सम्पर्कहरू',
      'statistics': 'तथ्याङ्क',
      
      // Search
      'search': 'खोज',
      'advanced_search': 'उन्नत खोज',
      'search_contacts': 'सम्पर्कहरू खोज्नुहोस्',
      'search_by_name': 'नामले खोज्नुहोस्',
      'search_by_phone': 'फोनले खोज्नुहोस्',
      'search_by_carrier': 'क्यारियरले खोज्नुहोस्',
      'filter_by_carrier': 'क्यारियरले फिल्टर गर्नुहोस्',
      'all_carriers': 'सबै क्यारियरहरू',
      'ntc': 'एनटीसी',
      'ncell': 'एनसेल',
      'smart': 'स्मार्ट',
      'unknown': 'अज्ञात',
      'clear_filters': 'फिल्टरहरू खाली गर्नुहोस्',
      'no_results': 'कुनै परिणाम फेला परेन',
      'results_count': '{count} सम्पर्क(हरू) फेला पर्यो',
      'enter_search_term': 'खोज शब्द प्रविष्ट गर्नुहोस्...',
      'select_carrier': 'क्यारियर छान्नुहोस्',
      'view_results': 'परिणामहरू हेर्नुहोस्',
      'select_language': 'भाषा छान्नुहोस्',
      
      // Common
      'cancel': 'रद्द गर्नुहोस्',
      'apply': 'लागू गर्नुहोस्',
      'reset': 'रीसेट गर्नुहोस्',
      'close': 'बन्द गर्नुहोस्',
      'loading': 'लोड हुँदैछ...',
    },
    'hi': {
      // Dashboard
      'dashboard': 'डैशबोर्ड',
      'welcome': 'स्वागत है',
      'manage_campaigns': 'अपने SMS अभियानों को कुशलतापूर्वक प्रबंधित करें',
      'sms_sent': 'SMS भेजे गए',
      'today': 'आज',
      'quick_actions': 'त्वरित कार्य',
      'load_contacts': 'संपर्क लोड करें',
      'send_sms': 'SMS भेजें',
      'image_share': 'छवि साझाकरण',
      'share_connect': 'साझाकरण और कनेक्ट',
      'share_app': 'ऐप साझा करें',
      'settings': 'सेटिंग्स',
      'logout': 'लॉगआउट',
      'contacts': 'संपर्क',
      'statistics': 'आंकड़े',
      
      // Search
      'search': 'खोज',
      'advanced_search': 'उन्नत खोज',
      'search_contacts': 'संपर्क खोजें',
      'search_by_name': 'नाम से खोजें',
      'search_by_phone': 'फोन से खोजें',
      'search_by_carrier': 'कैरियर से खोजें',
      'filter_by_carrier': 'कैरियर से फ़िल्टर करें',
      'all_carriers': 'सभी कैरियर',
      'ntc': 'एनटीसी',
      'ncell': 'एनसेल',
      'smart': 'स्मार्ट',
      'unknown': 'अज्ञात',
      'clear_filters': 'फ़िल्टर साफ़ करें',
      'no_results': 'कोई परिणाम नहीं मिला',
      'results_count': '{count} संपर्क मिले',
      'enter_search_term': 'खोज शब्द दर्ज करें...',
      'select_carrier': 'कैरियर चुनें',
      'view_results': 'परिणाम देखें',
      'select_language': 'भाषा चुनें',
      
      // Common
      'cancel': 'रद्द करें',
      'apply': 'लागू करें',
      'reset': 'रीसेट करें',
      'close': 'बंद करें',
      'loading': 'लोड हो रहा है...',
    },
  };

  static Future<String> getCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? defaultLanguage;
  }

  static Future<void> setLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, languageCode);
  }

  static String translate(String key, {String? language}) {
    final lang = language ?? defaultLanguage;
    return _translations[lang]?[key] ?? _translations[defaultLanguage]?[key] ?? key;
  }

  static String translateWithParams(String key, Map<String, String> params, {String? language}) {
    String text = translate(key, language: language);
    params.forEach((key, value) {
      text = text.replaceAll('{$key}', value);
    });
    return text;
  }

  static List<Map<String, String>> getAvailableLanguages() {
    return [
      {'code': 'en', 'name': 'English', 'native': 'English'},
      {'code': 'ne', 'name': 'Nepali', 'native': 'नेपाली'},
      {'code': 'hi', 'name': 'Hindi', 'native': 'हिन्दी'},
    ];
  }
}

