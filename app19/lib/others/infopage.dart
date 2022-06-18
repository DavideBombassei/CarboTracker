import 'package:app19/database/entities/carboEntity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app19/repository/databaseRepository.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  void populatefields_calandstep() async {
    List<carboEntity?> check3 =
        await Provider.of<DatabaseRepository>(context, listen: false)
            .show_data();
    print(check3);
  }

  @override
  void initState() {
    super.initState();
    populatefields_calandstep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InfoPage'),
        centerTitle: true,
      ),
      body: Center(
        child: Consumer<DatabaseRepository>(builder: (context, dbr, child) {
          return FutureBuilder(
            initialData: null,
            future: dbr.show_data(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data as List<carboEntity?>;
                return data.length == 0
                    ? Text('No day register in database')
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          double? temporarycheck = data[index]?.value;
                          return /*Card(
                                elevation: 5,
                                child:*/
                              ListTile(
                            title: Text('Data: ${data[index]?.dataString}'),
                            leading: Text(' ${data[index]?.id}'),
                            subtitle: Text('Click to show info'),
                            /*trailing: Text(
                                '${data[index]?.value.toString().substring(1, 6)}'),
                            //Text('CHO : ${data[mealIndex].fitbitCals}'),
                            subtitle: Text(
                              'STEPS : ${data[index]?.fitbitSteps}   CAL : ${data[index]?.fitbitCals}',
                            ),*/
                            onTap: () {
                              showDialog<void>(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Resume'),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: <Widget>[
                                          (temporarycheck! >= 0)
                                              ? Text(
                                                  'CarboCounter: ${temporarycheck.toString().substring(0, 5)}')
                                              : Text('CarboCounter: 0.0'),
                                          Text(
                                              'Steps: ${data[index]?.fitbitSteps}'),
                                          Text(
                                            'Calories: ${data[index]?.fitbitCals}',
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        });
              } //if
              else {
                return CircularProgressIndicator();
              } //else
            }, //FutureBuilder builder
          );
        } //Consumer-builder
            ),
      ),
    );
  }
}
