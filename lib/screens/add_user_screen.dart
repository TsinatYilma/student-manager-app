import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class AddUserScreen extends StatefulWidget {
  final int? id;

  const AddUserScreen({super.key, this.id});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (widget.id != null) {
      final provider = Provider.of<UserProvider>(context, listen: false);

      final user = provider.users.firstWhere(
        (u) => u.id == widget.id,
      );

      nameController.text = user.firstName;

      emailController.text = user.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == null ? 'Add User' : 'Edit User',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final provider = Provider.of<UserProvider>(
                  context,
                  listen: false,
                );

                if (widget.id == null) {
                  await provider.addUser(
                    nameController.text,
                    emailController.text,
                  );
                } else {
                  await provider.editUser(
                    widget.id!,
                    nameController.text,
                    emailController.text,
                  );
                }

                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
