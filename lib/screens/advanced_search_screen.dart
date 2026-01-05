import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/contact_model.dart';
import '../services/language_service.dart';
import '../services/contact_service.dart';
import 'contacts_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() => _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState extends State<AdvancedSearchScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedCarrier;
  String _currentLanguage = 'en';
  List<ContactModel> _allContacts = [];
  List<ContactModel> _filteredContacts = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  final List<String> _carriers = ['NTC', 'Ncell', 'Smart', 'Unknown'];

  @override
  void initState() {
    super.initState();
    _loadLanguage();
    _loadContacts();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadLanguage() async {
    final lang = await LanguageService.getCurrentLanguage();
    setState(() {
      _currentLanguage = lang;
    });
  }

  Future<void> _loadContacts() async {
    // Check permissions first
    final contactsPermission = await Permission.contacts.status;
    if (!contactsPermission.isGranted) {
      final status = await Permission.contacts.request();
      if (!status.isGranted) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Contacts permission is required'),
              action: SnackBarAction(
                label: 'Open Settings',
                onPressed: openAppSettings,
              ),
            ),
          );
        }
        return;
      }
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final contacts = await ContactService.getSimContacts();
      setState(() {
        _allContacts = contacts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading contacts: $e')),
        );
      }
    }
  }

  void _performSearch() {
    String nameQuery = _nameController.text.toLowerCase().trim();
    String phoneQuery = _phoneController.text.trim();

    List<ContactModel> results = _allContacts.where((contact) {
      // Name filter
      bool nameMatch = nameQuery.isEmpty ||
          contact.name.toLowerCase().contains(nameQuery);

      // Phone filter
      bool phoneMatch = phoneQuery.isEmpty ||
          contact.phoneNumber.contains(phoneQuery);

      // Carrier filter
      bool carrierMatch = _selectedCarrier == null ||
          _selectedCarrier!.isEmpty ||
          contact.carrier == _selectedCarrier;

      return nameMatch && phoneMatch && carrierMatch;
    }).toList();

    setState(() {
      _filteredContacts = results;
      _hasSearched = true;
    });
  }

  void _clearFilters() {
    _nameController.clear();
    _phoneController.clear();
    setState(() {
      _selectedCarrier = null;
      _filteredContacts = [];
      _hasSearched = false;
    });
  }

  void _viewResults() {
    if (_filteredContacts.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LanguageService.translate('no_results', language: _currentLanguage)),
        ),
      );
      return;
    }

    final groupedContacts = ContactService.groupByCarrier(_filteredContacts);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsScreen(
          groupedContacts: groupedContacts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageService.translate('advanced_search', language: _currentLanguage)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => _showLanguageDialog(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Search Fields Card
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LanguageService.translate('search_contacts', language: _currentLanguage),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Name Search
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: LanguageService.translate('search_by_name', language: _currentLanguage),
                              hintText: LanguageService.translate('enter_search_term', language: _currentLanguage),
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (_) => _performSearch(),
                          ),
                          const SizedBox(height: 16),
                          // Phone Search
                          TextField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              labelText: LanguageService.translate('search_by_phone', language: _currentLanguage),
                              hintText: LanguageService.translate('enter_search_term', language: _currentLanguage),
                              prefixIcon: const Icon(Icons.phone),
                              keyboardType: TextInputType.phone,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (_) => _performSearch(),
                          ),
                          const SizedBox(height: 16),
                          // Carrier Filter
                          DropdownButtonFormField<String>(
                            value: _selectedCarrier,
                            decoration: InputDecoration(
                              labelText: LanguageService.translate('filter_by_carrier', language: _currentLanguage),
                              prefixIcon: const Icon(Icons.sim_card),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            items: [
                              DropdownMenuItem<String>(
                                value: null,
                                child: Text(LanguageService.translate('all_carriers', language: _currentLanguage)),
                              ),
                              ..._carriers.map((carrier) => DropdownMenuItem<String>(
                                    value: carrier,
                                    child: Text(LanguageService.translate(carrier.toLowerCase(), language: _currentLanguage)),
                                  )),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _selectedCarrier = value;
                              });
                              _performSearch();
                            },
                          ),
                          const SizedBox(height: 16),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: _clearFilters,
                                  icon: const Icon(Icons.clear),
                                  label: Text(LanguageService.translate('clear_filters', language: _currentLanguage)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _performSearch,
                                  icon: const Icon(Icons.search),
                                  label: Text(LanguageService.translate('search', language: _currentLanguage)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Results Section
                  if (_hasSearched)
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  LanguageService.translateWithParams(
                                    'results_count',
                                    {'count': _filteredContacts.length.toString()},
                                    language: _currentLanguage,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (_filteredContacts.isNotEmpty)
                                  ElevatedButton.icon(
                                    onPressed: _viewResults,
                                    icon: const Icon(Icons.visibility),
                                    label: Text(LanguageService.translate('view_results', language: _currentLanguage)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            if (_filteredContacts.isEmpty)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.search_off,
                                        size: 64,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        LanguageService.translate('no_results', language: _currentLanguage),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _filteredContacts.length > 10 ? 10 : _filteredContacts.length,
                                itemBuilder: (context, index) {
                                  final contact = _filteredContacts[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: _getCarrierColor(contact.carrier),
                                      child: Text(
                                        contact.name[0].toUpperCase(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    title: Text(contact.name),
                                    subtitle: Text(contact.phoneNumber),
                                    trailing: Chip(
                                      label: Text(contact.carrier),
                                      backgroundColor: _getCarrierColor(contact.carrier).withOpacity(0.2),
                                    ),
                                  );
                                },
                              ),
                            if (_filteredContacts.length > 10)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    '${_filteredContacts.length - 10} more...',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Color _getCarrierColor(String carrier) {
    switch (carrier) {
      case 'NTC':
        return Colors.blue;
      case 'Ncell':
        return Colors.green;
      case 'Smart':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Future<void> _showLanguageDialog() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LanguageService.translate('select_language', language: _currentLanguage)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LanguageService.getAvailableLanguages().map((lang) {
            return ListTile(
              title: Text('${lang['name']} (${lang['native']})'),
              leading: Radio<String>(
                value: lang['code']!,
                groupValue: _currentLanguage,
                onChanged: (value) {
                  Navigator.pop(context, value);
                },
              ),
              onTap: () {
                Navigator.pop(context, lang['code']);
              },
            );
          }).toList(),
        ),
      ),
    );

    if (selected != null) {
      await LanguageService.setLanguage(selected);
      setState(() {
        _currentLanguage = selected;
      });
    }
  }
}

