import 'package:flutter/material.dart';
import 'package:phone_book/add_contact_page.dart';
import 'package:phone_book/model/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts;

  @override
  void initState() {
    contacts = Contact.contacts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts.sort(
      (Contact a, Contact b) => a.name[0].toLowerCase().compareTo(b.name[0].toLowerCase()),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Book"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddContactPage()));
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (BuildContext context, int index) {
            Contact contact = contacts[index];
            return Dismissible(
              key: Key(contact.name),
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direction) {
                setState(() {
                  contacts.removeAt(index);
                });

                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("${contact.name} deleted"),
                  action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        setState(() {
                          contacts.add(contact);
                        });
                      }),
                ));
              },
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddContactPage(),
                    ),
                  );
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage((contact.avatar == null || contact.avatar.isEmpty) ? "assets/img/person.jpg" : contact.avatar),
                    child: Text(
                      contact.name[0].toUpperCase(),
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.phoneNumber),
                ),
              ),
            );
          }),
    );
  }
}