class DatabaseHelper {
  static List<Map<String, String>> _contacts = [];


  static List<Map<String, String>> getContacts() {
    return List.unmodifiable(_contacts);
  }


  static void addContact(String name, String email, String contactNumber) {
    _contacts.add({
      'name': name,
      'email': email,
      'contactNumber': contactNumber,
    });
  }


  static void updateContact(int index, String name, String email, String contactNumber) {
    if (index >= 0 && index < _contacts.length) {
      _contacts[index] = {
        'name': name,
        'email': email,
        'contactNumber': contactNumber,
      };
    }
  }


  static void deleteContact(int index) {
    if (index >= 0 && index < _contacts.length) {
      _contacts.removeAt(index);
    }
  }
}

