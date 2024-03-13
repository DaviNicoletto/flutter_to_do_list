import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_to_do_list/lembrete.dart';
import 'package:flutter_to_do_list/todo_constants.dart';
import 'package:grouped_list/grouped_list.dart';

class HomePage extends StatefulWidget {
  @override
  // ignore: overridden_fields
  final Key? key;
  const HomePage({this.key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  static const fontTitle = 26.00;
  static const fontLabel = 23.00;
  static const fontBody = 20.00;

  final TextEditingController reminderInputController = TextEditingController();
  final TextEditingController dateInputController = TextEditingController();

  DateTime reminderDate = DateTime(2024, 12, 14);
  DateTime nowDate = DateTime.now();

  List<Reminder> myReminds = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? dateSelected = await showDatePicker(
      context: context,
      initialDate: nowDate,
      firstDate: DateTime(nowDate.year),
      lastDate: DateTime(2100),
    );

    if (dateSelected == null) return;

    setState(() {
      reminderDate = dateSelected;
      String formattedDate = formatDateBR(reminderDate);
      DateTime data =
          DateFormat('dd/MM/yyyy', 'pt_BR').parse(formattedDate, true);
      dateInputController.text = DateFormat('dd/MM/yyyy').format(data);
    });
  }

  String formatDateBR(data) {
    return DateFormat('dd/MM/yyyy', 'pt_BR').format(data);
  }

  void removeReminder(index) {
    setState(() {
      myReminds.removeAt(index);
    });
  }

  //Build do corpo do app
  @override
  Widget build(BuildContext context) {
    final TodoConstants constants = TodoConstants();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(constants.appTitle,
            style: const TextStyle(fontSize: 35, color: Colors.white)),
        leading: const Icon(Icons.fact_check_outlined),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              constants.addNewReminder,
              style: const TextStyle(fontSize: fontTitle),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  //Campo "Nome do lembrete"
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      key: const Key("NameTextFieldKey"),
                      controller: reminderInputController,
                      style: const TextStyle(
                          fontSize: fontBody, color: Colors.black87),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          labelText: constants.reminderInputLabel,
                          labelStyle: const TextStyle(fontSize: 23),
                          hintText: constants.reminderInputHint,
                          hintStyle: const TextStyle(fontSize: 20)),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value?.trim().isEmpty ?? false) {
                          return constants.errorInput;
                        }
                        return null;
                      },
                    ),
                  ),

                  //Campo "Data do lembrete"
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    child: TextFormField(
                      key: const Key("DateTextFieldKey"),
                      readOnly: true,
                      controller: dateInputController,
                      style: const TextStyle(
                          fontSize: fontBody, color: Colors.black87),
                      onTap: () => {selectDate(context)},
                      decoration: InputDecoration(
                        suffixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.calendar_month_rounded),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        labelText: constants.dateInputLabel,
                        labelStyle: const TextStyle(fontSize: fontLabel),
                        hintText: constants.dateInputHint,
                      ),
                      validator: (value) {
                        if (value?.trim().isEmpty ?? false) {
                          return constants.errorInput;
                        } else if (reminderDate.isBefore(nowDate)) {
                          return constants.errorInvalidDate;
                        }
                        return null;
                      },
                    ),
                  ),

                  //Botão "Adicionar"
                  ElevatedButton(
                    key: const Key("ButtonCreateKey"),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        setState(() {
                          Reminder newReminder = Reminder();
                          newReminder.name = reminderInputController.text;
                          newReminder.date = reminderDate;
                          myReminds.add(newReminder);
                        });

                        reminderInputController.clear();
                        dateInputController.clear();
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                    child: Text(
                      constants.create,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ]),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: const Divider(),
          ),
          Text(
            constants.myReminds,
            style: const TextStyle(fontSize: fontTitle),
          ),
          Expanded(
              child: GroupedListView<Reminder, String>(
                  elements: myReminds,
                  groupBy: (reminder) => formatDateBR(reminder.date),
                  groupSeparatorBuilder: (String date) => Container(
                        margin: const EdgeInsets.only(top: 5),
                        child: Text('Dia $date',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: fontLabel,
                              color: Color.fromARGB(255, 1, 132, 150),
                            )),
                      ),
                  itemBuilder: (context, reminder) => Card(
                        child: ListTile(
                          title: Text(reminder.name),
                          subtitle: Text(formatDateBR(reminder.date)),
                          trailing: IconButton(
                            onPressed: () {
                              removeReminder(myReminds.indexOf(reminder));
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 236, 73, 62),
                            ),
                          ),
                        ),
                      )
                    )
                  )
          ]
        ),
      ),
    );
  }
}
