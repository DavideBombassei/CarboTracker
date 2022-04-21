import 'package:app19/main.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:date_format/date_format.dart';
import 'package:app19/others/profile.dart';
import 'package:intl/intl.dart';
import 'package:app19/screens/profilepage.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:developer' as developer;

Profile _editProfile = Profile(name: 'lUCA', email: '${profile.email}');
//Profile profile = Profile(name: 'profile.name', email: 'mario.rossi@gmail.com');

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  backgroundColor: Color.fromARGB(255, 192, 12, 12),
                  child: Image.asset('assets/images/logo.png',
                      width: 250, height: 250),
                  radius: 50.0,
                ),
              ),
            ),
            _modifyProfile(context),
            /*FloatingActionButton(
              onPressed: () => _saveChanges(context),
              child: Icon(Icons.save),
            ),*/
            /*Column(
              children: [
                TextField(
                  controller: _namecontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    hintText: '$_name',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: '$_email',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Save changes'),
                  onPressed: () {
                    Navigator.pop(context);

                    //if (_usercontroller.value.text == 'anna_arnaudo' && _pswcontroller.value.text == 'Biowrbl19'){
                  },
                ),
              ],
            ),*/
          ]),
    );
  }

  TextEditingController _nameControll = TextEditingController();
  TextEditingController _emailControll = TextEditingController();
  DateTime? _date = DateTime(2000, 1, 1);
  TextEditingController _weightControll = TextEditingController();
  TextEditingController _heightControll = TextEditingController();

  Widget _modifyProfile(BuildContext context) {
    //developer.log('LOG:${_editProfile.name}');

    final format = DateFormat("yyyy-MM-dd");
    return Form(
        key: _formKey,
        child: Container(
          margin: new EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.restaurant,
                    ),
                    hintText: 'Name *',
                    //widget.mealIndex == -1 ? 'Carbohydrates *' : 'Carbohydrates *',
                    labelText: 'Insert your name: ',
                  ),
                  controller: _nameControll,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _editProfile.name = _nameControll.text;
                  }),
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.restaurant,
                    ),
                    hintText: 'Email *',
                    //widget.mealIndex == -1 ? 'Carbohydrates *' : 'Carbohydrates *',
                    labelText: 'Insert your email',
                  ),
                  controller: _emailControll,
                  // The validator receives the text that the user has entered.
                  /*validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },*/
                  onSaved: (value) {
                    _editProfile.email = _emailControll.text;
                  }),
              DateTimeField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.alarm),
                    hintText: 'yyyy-MM-dd*',
                    labelText: 'Insert your birthday',
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final _date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    return _date;
                  },
                  onSaved: (value) {
                    _editProfile.dateTime = _date;
                  }),
              ElevatedButton(
                onPressed: () {
                  developer.log('LOG:${_nameControll.text}');
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
                child: const Text('Submit'),
              ),
              /*DateTimeField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.alarm),
                    hintText: 'yyyy-MM-dd HH:mm*',
                    labelText: 'Meal time',
                  ),
                  format: format,
                  onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.fromDateTime(
                            currentValue ?? DateTime.now()),
                      );
                      _datetime = DateTimeField.combine(date, time);
                      return _datetime;
                    } else {
                      _datetime = currentValue;
                      return _datetime;
                    }
                  },
                  onSaved: (value) {
                    profile.dateTime = _datetime;
                  }),*/
              // Add TextFormFields and ElevatedButton here.
            ],
          ),
        ));
  }

  void _saveChanges(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //profile = _editProfile;
      //setState(() {
      Provider.of<Profile>(context, listen: false).editProfile(_editProfile);
      //});
    }
    //Then push the HomePage
    Navigator.pop(context);
    //}
  }
}
