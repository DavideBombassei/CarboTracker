import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:date_format/date_format.dart';
import 'package:app19/others/profile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

Profile _editProfile =
    Profile(name: '${profile.name}', email: '${profile.email}');

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: EditProfileState(),
    );
  }
}

class EditProfileState extends StatefulWidget {
  @override
  State<EditProfileState> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfileState> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(27.0),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AvatarGlow(
                  endRadius: 70.0,
                  child: Material(
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Image.asset('assets/images/profile5.png',
                          width: 250, height: 250),
                      radius: 50.0,
                    ),
                  ),
                ),
                _modifyProfile(context),
              ]),
        ));
  }

  TextEditingController _nameControll =
      TextEditingController(text: profile.name);
  TextEditingController _emailControll =
      TextEditingController(text: profile.email);

  DateTime? _date = DateTime(2000, 1, 1);
  TextEditingController _weightControll =
      TextEditingController(text: profile.weight.toString());
  TextEditingController _heightControll =
      TextEditingController(text: profile.height.toString());

  Widget _modifyProfile(BuildContext context) {
    //developer.log('LOG:${_editProfile.name}');
    final format = DateFormat("yyyy-MM-dd");
    return Form(
        key: _formKey,
        child: Container(
          margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Name *',
                    labelText: 'Insert your name: ',
                  ),
                  controller: _nameControll,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProfile.name = _nameControll.text;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.email,
                    ),
                    hintText: 'Email *',
                    labelText: 'Insert your email',
                  ),
                  controller: _emailControll,
                  validator: (value) {
                    if (!isValidEmail(value)) return 'Enter VALID email';
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProfile.email = _emailControll.text;
                  }),
              DateTimeField(
                  initialValue: profile.dateTime,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_month),
                    hintText: 'yyyy-MM-dd *',
                    labelText: 'Insert your birthday',
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: DateTime(2000),
                        lastDate: DateTime.now());
                    _date = date;
                    return date;
                  },
                  validator: (value) {
                    if (value == null) {
                      return null;
                    }
                  },
                  onSaved: (value) {
                    if (value == null) {
                      _editProfile.dateTime = profile.dateTime;
                    } else {
                      _editProfile.dateTime = _date;
                    }
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.height),
                    hintText: 'Height *',
                    labelText: 'Insert your height: ',
                  ),
                  controller: _heightControll,
                  validator: (value) {
                    if (value.toString().isNotEmpty) {
                      if (!isValid(value.toString()))
                        return 'Enter VALID height';
                    }
                  },
                  onSaved: (value) {
                    if (value == null || value.isEmpty) {
                      _editProfile.height = profile.height;
                    } else {
                      _editProfile.height = double.parse(_heightControll.text);
                    }
                  }),
              TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.line_weight,
                    ),
                    hintText: 'Weight *',
                    labelText: 'Insert your weight: ',
                  ),
                  controller: _weightControll,
                  validator: (value) {
                    if (value.toString().isNotEmpty) {
                      if (!isValid(value.toString()))
                        return 'Enter VALID weight';
                    }
                  },
                  onSaved: (value) {
                    if (value == null || value.isEmpty) {
                      _editProfile.weight = profile.weight;
                    } else {
                      _editProfile.weight = double.parse(_weightControll.text);
                    }
                  }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  developer.log('LOG:${_date}');
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    _saveChanges(context);
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('The changes have been applied')),
                    );
                  }
                },
                child: Text('Save'),
              ),
            ],
          ),
        ));
  }

  void _saveChanges(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<Profile>(context, listen: false).editProfile(_editProfile);
    }
    //Then push the HomePage
    Navigator.pop(context);
  }

  bool isValid(String? val) {
    if (val == null) return false;
    final regExp = RegExp(r"^[0-9]");
    return regExp.hasMatch(val);
  }

  bool isValidEmail(String? val) {
    if (val == null) return false;
    final regExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regExp.hasMatch(val);
  }
}
