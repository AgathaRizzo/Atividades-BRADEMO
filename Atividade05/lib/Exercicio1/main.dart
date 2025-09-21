import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: MainApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Flutter Form Demo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _formExample(context),
      ),
    );
  }

  Widget _formExample(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) =>
                value!.isEmpty ? "Digite seu nome" : null,
          ),

          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: "Phone",
              prefixIcon: Icon(Icons.phone),
            ),
            validator: (value) =>
                value!.isEmpty ? "Digite seu telefone" : null,
          ),

          TextFormField(
            controller: _dobController,
            decoration: const InputDecoration(
              labelText: "Dob",
              prefixIcon: Icon(Icons.calendar_today),
            ),
            validator: (value) =>
                value!.isEmpty ? "Digite sua data de nascimento" : null,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              backgroundColor: Colors.grey,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final name = _nameController.text;
                final phone = _phoneController.text;
                final dob = _dobController.text;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Name: $name | Phone: $phone | Dob: $dob"),
                  ),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
