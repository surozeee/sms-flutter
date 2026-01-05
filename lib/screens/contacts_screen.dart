import 'package:flutter/material.dart';
import '../models/contact_model.dart';
import 'sms_compose_screen.dart';

class ContactsScreen extends StatefulWidget {
  final Map<String, List<ContactModel>> groupedContacts;

  const ContactsScreen({
    super.key,
    required this.groupedContacts,
  });

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  late Map<String, List<ContactModel>> _groupedContacts;
  int _totalSelected = 0;

  @override
  void initState() {
    super.initState();
    _groupedContacts = Map.fromEntries(
      widget.groupedContacts.entries.map((entry) => MapEntry(
            entry.key,
            entry.value.map((c) => ContactModel(
                  name: c.name,
                  phoneNumber: c.phoneNumber,
                  carrier: c.carrier,
                  isSelected: c.isSelected,
                )).toList(),
          )),
    );
    _totalSelected = _calculateSelectedCount();
  }

  int _calculateSelectedCount() {
    int count = 0;
    for (var contacts in _groupedContacts.values) {
      count += contacts.where((c) => c.isSelected).length;
    }
    return count;
  }

  void _toggleContactSelection(String carrier, int index) {
    setState(() {
      _groupedContacts[carrier]![index].isSelected =
          !_groupedContacts[carrier]![index].isSelected;
      _totalSelected = _calculateSelectedCount();
    });
  }

  void _toggleCarrierSelection(String carrier, bool select) {
    setState(() {
      for (var contact in _groupedContacts[carrier]!) {
        contact.isSelected = select;
      }
      _totalSelected = _calculateSelectedCount();
    });
  }

  List<ContactModel> _getSelectedContacts() {
    List<ContactModel> selected = [];
    for (var contacts in _groupedContacts.values) {
      selected.addAll(contacts.where((c) => c.isSelected));
    }
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    final carriers = ['NTC', 'Ncell', 'Smart', 'Unknown'];
    final carrierColors = {
      'NTC': Colors.blue,
      'Ncell': Colors.green,
      'Smart': Colors.orange,
      'Unknown': Colors.grey,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts by Carrier'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_totalSelected > 0)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Selected: $_totalSelected',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          if (_totalSelected > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$_totalSelected contact(s) selected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final selected = _getSelectedContacts();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SmsComposeScreen(
                            selectedContacts: selected,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.send),
                    label: const Text('Send SMS'),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: carriers.length,
              itemBuilder: (context, index) {
                final carrier = carriers[index];
                final contacts = _groupedContacts[carrier] ?? [];
                final selectedCount =
                    contacts.where((c) => c.isSelected).length;
                final allSelected = contacts.isNotEmpty &&
                    selectedCount == contacts.length;

                if (contacts.isEmpty) return const SizedBox.shrink();

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      backgroundColor: carrierColors[carrier],
                      child: Text(
                        carrier[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      carrier,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '${contacts.length} contacts (${selectedCount} selected)',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: allSelected,
                          tristate: true,
                          onChanged: (value) {
                            _toggleCarrierSelection(
                              carrier,
                              value ?? false,
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_drop_down),
                          onPressed: null,
                        ),
                      ],
                    ),
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: contacts.length,
                        itemBuilder: (context, contactIndex) {
                          final contact = contacts[contactIndex];
                          return ListTile(
                            leading: Checkbox(
                              value: contact.isSelected,
                              onChanged: (value) {
                                _toggleContactSelection(
                                  carrier,
                                  contactIndex,
                                );
                              },
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.phoneNumber),
                            trailing: Text(
                              contact.carrier,
                              style: TextStyle(
                                color: carrierColors[carrier],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _totalSelected > 0
          ? FloatingActionButton.extended(
              onPressed: () {
                final selected = _getSelectedContacts();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SmsComposeScreen(
                      selectedContacts: selected,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.send),
              label: Text('Send to $_totalSelected'),
            )
          : null,
    );
  }
}

