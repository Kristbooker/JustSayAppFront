import 'package:flutter/material.dart';
import 'package:justsaying/models/user.dart';
import 'package:justsaying/service/ServiceUser.dart';

class ProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  late User user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // ใช้ข้อมูลที่มีอยู่เพื่อเติมข้อมูลเริ่มต้นใน TextEditingController
    _firstNameController =
        TextEditingController(text: widget.userData['firstName']);
    _lastNameController =
        TextEditingController(text: widget.userData['lastName']);
    _bioController = TextEditingController(text: widget.userData['bio']);
    isLoading = true;
    ServiceUser.getUser(widget.userData["id"]).then((userFromServer) {
      setState(() {
        user = userFromServer;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is removed from the widget tree
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _updateProfile() async {
    // Create a new user object with updated values
    User updatedUser = User()
      ..id = widget.userData["id"]
      ..userName = widget.userData['userName']
      ..firstName = _firstNameController.text
      ..lastName = _lastNameController.text
      ..password = widget.userData['password']
      ..bio = _bioController.text
      ..proImg = widget.userData['proImg'];
    bool success =
        await ServiceUser.updateUser(widget.userData['id'], updatedUser);

    if (success) {
      // If the update is successful, pop the dialog and show a snackbar/message
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully.')));
    } else {
      // If the update failed, show a snackbar/message with error
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to update profile.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.person,
          color: Colors.white,
        ),
        backgroundColor: Color.fromARGB(255, 34, 31, 35),
        title: const Text('Profile'),
        titleTextStyle: TextStyle(color: Colors.white),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit, // The edit icon
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Edit Profile'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          TextField(
                            controller: _firstNameController,
                            decoration:
                                const InputDecoration(labelText: 'First Name'),
                          ),
                          TextField(
                            controller: _lastNameController,
                            decoration:
                                const InputDecoration(labelText: 'Last Name'),
                          ),
                          TextField(
                            controller: _bioController,
                            decoration: const InputDecoration(labelText: 'Bio'),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          _updateProfile();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profile(),
                  // ... the rest of your code
                ],
              ),
      ),
    );
  }

  Widget profile() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Use the minimum space
        crossAxisAlignment: CrossAxisAlignment
            .center, // Center content horizontally for the whole column
        children: <Widget>[
          CircleAvatar(
            radius: 80, // Adjust the radius to the size you need
            backgroundImage: NetworkImage(user.proImg),
          ),
          SizedBox(
              height: 8), // Provide some spacing between the image and the name
          Text(
            "${user.firstName} ${user.lastName}",
            style: TextStyle(
              fontSize: 20, // Adjust the font size as you need
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "@${user.userName}",
            style: TextStyle(
              fontSize: 16, // Adjust the font size as you need
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 16), // Provide spacing before the bio section
          Padding(
            padding: EdgeInsets.only(left: 50), // Add padding to the left
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 300, // Set the fixed width for alignment
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Align children to the start (left)
                  children: <Widget>[
                    Text(
                      "Bio",
                      style: TextStyle(
                        fontSize: 20, // Adjust the font size as you need
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      width: double
                          .infinity, // Ensures the container fills the width within the parent
                      padding:
                          EdgeInsets.all(8), // Padding inside the container
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors
                                .black), // Black border around the container
                        borderRadius:
                            BorderRadius.circular(4), // Rounded corners
                      ),
                      child: Text(
                        "${user.bio}",
                        style: TextStyle(
                          fontSize: 16, // Adjust the font size as you need
                          color: Colors.black,
                        ),
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
