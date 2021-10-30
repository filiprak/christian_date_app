import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/pages/home/edit_xprofile_group_page.dart';
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

  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.dispatch(FetchXProfileGroupsAction().thunk(context));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                title: Text('Edytuj profil'),
                leading: IconButton(icon:Icon(Icons.arrow_back),
                    onPressed:() => store.dispatch(NavigatePopAction())
                ),
              ),
              body: ListView.separated(
                separatorBuilder: (context, index) => Divider(height: 0),
                itemCount: store.state.xProfileGroups.length,
                itemBuilder: (context, index) {
                  var group = store.state.xProfileGroups[index];
                  return ListTile(
                    leading: Text(group.name),
                    trailing: Icon(Icons.keyboard_arrow_right_sharp),
                    onTap: () {
                      store.dispatch(NavigatePushPageAction(EditXProfileGroupPage(group)));
                    },
                  );
                }
              )
          );
        });
  }
}
