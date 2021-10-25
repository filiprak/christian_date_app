import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/actions/asyncMessageActions.dart';
import 'package:christian_date_app/state/actions/messageActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:christian_date_app/state/store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class EditMyProfilePage extends StatefulWidget {
  final UserModel user;

  EditMyProfilePage(this.user);

  @override
  _EditMyProfilePageState createState() => _EditMyProfilePageState(this.user);
}

class _EditMyProfilePageState extends State<EditMyProfilePage> {

  final UserModel user;

  _EditMyProfilePageState(this.user);

  final Map<String, String> visiblityTranslateMap = {
    'public': 'Widoczne dla wszystkich',
    'adminsonly': 'Widoczne tylko dla administratorów',
    'loggedin': 'Widoczne dla zalogowanych użytkowników',
    'friends': 'Widoczne tylko dla znajomych'
  };

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.dispatch(FetchXProfileFieldsAction().thunk(context));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          store.state.xProfileFields.forEach((field) {
            print(field.name + ': ' + field.type);
          });
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text('Edytuj profil'),
                leading: IconButton(icon:Icon(Icons.arrow_back),
                    onPressed:() => store.dispatch(NavigatePopAction())
                ),
              ),
              body: Padding(
                padding: EdgeInsets.all(1.0),
                child: ListView.separated(
                  separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(0.0)
                  ),
                  itemCount: store.state.xProfileFields.length,
                  itemBuilder: (context, index) {
                    var field = store.state.xProfileFields[index];

                    if (field.type == 'datebox' && dateController.text.isEmpty) {
                      dateController.text = DateFormat('dd-MM-yyyy').format(DateTime.parse(field.value));
                    }

                    return Column(
                        children: [
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            color: Colors.black12,
                            child: Text(field.name),
                          ),
                          if (field.description.isNotEmpty)
                            Container(
                              width: double.infinity,
                              alignment: Alignment.centerLeft,
                              color: Colors.black12,
                              child: Text(
                                field.description,
                                style: TextStyle(
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                          if (field.type == 'textbox')
                            TextFormField(
                                initialValue: field.value,
                                onChanged: (value) {
                                  store.dispatch(UpdateXProfileFieldAction(field.id, [value]).thunk(context));
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                )
                            ),
                          if (field.type == 'datebox')
                            TextFormField(
                              onTap: () async {
                                DateTime dateTime = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.parse(field.value),
                                    initialDatePickerMode: DatePickerMode.day,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100));
                                if (dateTime != null) {
                                  dateController.text =
                                      DateFormat('dd-MM-yyyy').format(dateTime);
                                  store.dispatch(UpdateXProfileFieldAction(
                                      field.id, [
                                    DateFormat('yyyy-MM-dd HH:mm:ss').format(
                                        dateTime)
                                  ]).thunk(context));
                                }
                              },
                              controller: dateController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                            ),
                          if (field.type == 'selectbox' || field.type == 'radio')
                            DropdownButtonFormField(
                                value: field.value,
                                onChanged: (value) {
                                  store.dispatch(UpdateXProfileFieldAction(field.id, [value == '--' ? '' : value]).thunk(context));
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  border: OutlineInputBorder(borderSide: BorderSide.none),
                                ),
                                items: field.options.map((option) {
                                  return DropdownMenuItem(
                                      value: option,
                                      child: Text(option.isNotEmpty ? option : '--')
                                  );
                                }).toList()
                            ),
                          if (field.type == 'textarea')
                            TextFormField(
                              initialValue: field.value,
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                              onChanged: (value) {
                                store.dispatch(UpdateXProfileFieldAction(field.id, [value]).thunk(context));
                              },
                            ),
                          if (field.type == 'checkbox')
                            ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: field.options.length,
                              itemBuilder: (context, index) {
                                var option = field.options[index];
                                return CheckboxListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(option),
                                  value: false,
                                );
                              }
                            ),
                          Divider(height: 0),
                          DropdownButtonFormField(
                              value: field.visibilityLevel,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: OutlineInputBorder(borderSide: BorderSide.none),
                              ),
                              items: visiblityTranslateMap.entries.map((visibility) {
                                return DropdownMenuItem(
                                    value: visibility.key,
                                    child: Text(visibility.value)
                                );
                              }).toList()
                          ),
                        ]
                    );
                  }
                )
              )
          );
        });
  }
}
