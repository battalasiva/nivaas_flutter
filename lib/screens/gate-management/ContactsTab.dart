import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:nivaas/core/constants/colors.dart';
import 'package:nivaas/core/constants/text_styles.dart';
import 'package:nivaas/screens/gate-management/preview/SelectedGuestsPreview.dart';
import 'package:nivaas/widgets/elements/AppLoaderWidget.dart';
import 'package:nivaas/widgets/elements/CustomSnackbarWidget.dart';
import 'package:nivaas/widgets/elements/button.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsTab extends StatefulWidget {
  final Map<String, Object?>? payload;
  const ContactsTab({super.key, this.payload});

  @override
  _ContactsTabState createState() => _ContactsTabState();
}

class _ContactsTabState extends State<ContactsTab> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  List<Map<String, String>> selectedContacts = [];
  TextEditingController searchController = TextEditingController();
  bool permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    if (await FlutterContacts.requestPermission()) {
      List<Contact> fetchedContacts = await FlutterContacts.getContacts(
        withProperties: true,
        withThumbnail: true,
      );
      setState(() {
        contacts = fetchedContacts;
        filteredContacts = contacts;
        permissionDenied = false;
      });
    } else {
      setState(() => permissionDenied = true);
    }
  }

  void _filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _toggleSelection(Contact contact) {
    String phoneNumber = contact.phones.isNotEmpty
        ? contact.phones.first.number
        : "No phone number";
    Map<String, String> contactData = {
      "name": contact.displayName,
      "number": phoneNumber,
    };

    setState(() {
      if (selectedContacts.any((c) => c["number"] == phoneNumber)) {
        selectedContacts.removeWhere((c) => c["number"] == phoneNumber);
      } else {
        selectedContacts.add(contactData);
      }
    });
  }

  Future<void> _addNewContact() async {
    final created = await FlutterContacts.openExternalInsert();
    if (created != null) {
      _fetchContacts();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Selected Contacts: $contacts');
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTitleAndSearch(),
            Expanded(child: _buildContactList()),
            if (selectedContacts.isNotEmpty) ...[
              _buildSelectedContacts(),
              _buildNextButton(),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildTitleAndSearch() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Search contacts...",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: Icon(Icons.person_add_alt_1, color: AppColor.primaryColor1),
              onPressed: _addNewContact,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: _filterContacts,
        ),
      ),
    ],
  );
}


  Widget _buildContactList() {
    if (permissionDenied) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "Permission Required\n",
                style: txt_16_600.copyWith(color: AppColor.black),
                children: [
                  TextSpan(
                    text:
                        "To access your contacts and provide a seamless experience, please enable contact permissions in your device settings.",
                    style: txt_14_500.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => openAppSettings(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor1,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                "Open Settings",
                style: txt_14_500.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }

    return contacts.isEmpty
        ? const Center(child: AppLoader())
        : ListView.builder(
            itemCount: filteredContacts.length,
            itemBuilder: (context, index) {
              Contact contact = filteredContacts[index];
              bool isSelected = selectedContacts.any((c) =>
                  c["number"] ==
                  (contact.phones.isNotEmpty
                      ? contact.phones.first.number
                      : "No phone numbers found"));
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: contact.thumbnail != null
                      ? MemoryImage(contact.thumbnail!)
                      : null,
                  backgroundColor: AppColor.greyBackground,
                  child: contact.thumbnail == null
                      ? Icon(Icons.person, color: AppColor.white)
                      : null,
                ),
                title: Text(contact.displayName,
                    style: txt_15_500.copyWith(color: AppColor.black1)),
                subtitle: contact.phones.isNotEmpty
                    ? Text(contact.phones.first.number,
                        style: txt_13_500.copyWith(color: AppColor.black))
                    : const Text("No phone numbers found"),
                trailing: Checkbox(
                  value: isSelected,
                  activeColor: AppColor.blue,
                  onChanged: (value) {
                    _toggleSelection(contact);
                  },
                ),
              );
            },
          );
  }

  Widget _buildSelectedContacts() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Wrap(
        spacing: 8,
        children: selectedContacts
            .map((contact) => Chip(
                  backgroundColor: AppColor.blueShade,
                  label: Text(contact["name"]!),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    setState(() {
                      selectedContacts.remove(contact);
                    });
                  },
                ))
            .toList(),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      color: AppColor.white,
      padding: const EdgeInsets.only(bottom: 15),
      child: CustomizedButton(
        label: 'Next',
        style: txt_15_500.copyWith(color: AppColor.white),
        onPressed: selectedContacts.isNotEmpty
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectedGuestsPreview(
                        selectedContacts: selectedContacts,
                        payload: widget.payload),
                  ),
                );
              }
            : () {
                CustomSnackbarWidget(
                  context: context,
                  title: 'Please Add or Select Contacts',
                  backgroundColor: AppColor.red,
                );
              },
      ),
    );
  }
}
