import 'package:christian_date_app/components/dialogs.dart';
import 'package:christian_date_app/state/actions/actions.dart';
import 'package:christian_date_app/state/actions/asyncActions.dart';
import 'package:christian_date_app/state/actions/asyncMessageActions.dart';
import 'package:christian_date_app/state/actions/messageActions.dart';
import 'package:christian_date_app/state/appState.dart';
import 'package:christian_date_app/state/models/userModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:redux/redux.dart';

class UserProfilePage extends StatefulWidget {
  static String tag = 'user-profile-page';
  final UserModel user;

  UserProfilePage(this.user);

  @override
  _UserProfilePageState createState() => _UserProfilePageState(this.user);
}

class _UserProfilePageState extends State<UserProfilePage> {

  final UserModel user;
  final _sendTextController = TextEditingController(text: '');

  _UserProfilePageState(this.user);

  Widget _buildChip(String text, IconData iconData, {double iconSize = 25.0}) {
    return Chip(
      labelPadding: EdgeInsets.fromLTRB(10, 2, 5, 2),
      avatar: Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: Icon(iconData, size: iconSize),
      ),
      label: Text(text),
      backgroundColor: Colors.black12,
      padding: EdgeInsets.all(5.0),
    );
  }

  Widget _buildDescription(String label, String text) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Text(
              label,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[400],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Html(
              data: text,
              defaultTextStyle: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Store<AppState>>(
        converter: (store) => store,
        builder: (context, store) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: Text(user.name + (user.xProfile.age != null ? ', ' + user.xProfile.age.toString() : '')),
              leading: IconButton(icon:Icon(Icons.arrow_back),
                  onPressed:() => store.dispatch(NavigatePopAction())
              ),
            ),
            body: Column(
              children: [
                Flexible(
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Image.network(user.avatar)
                      ),
                      if (user.xProfile.about != null && user.xProfile.about.isNotEmpty)
                        _buildDescription('O mnie', user.xProfile.about),
                      if (user.xProfile.describeYourself != null && user.xProfile.describeYourself.isNotEmpty)
                        _buildDescription('Opisz siebie', user.xProfile.describeYourself),
                      if (user.xProfile.city != null && user.xProfile.city.isNotEmpty)
                        _buildDescription('Lokalizacja', user.xProfile.city + (user.xProfile.district != null ? ', ' + user.xProfile.district : '')),
                      if (user.xProfile.willingToMove != null && user.xProfile.willingToMove.isNotEmpty)
                        _buildDescription('Zmiana miejsca zamieszkania', user.xProfile.willingToMove),
                      if (user.xProfile.hobby != null && user.xProfile.hobby.isNotEmpty)
                        _buildDescription('Hobby', user.xProfile.hobby),
                      if (user.xProfile.favouriteBibleVerses != null && user.xProfile.favouriteBibleVerses.isNotEmpty)
                        _buildDescription('Ulubione wersety biblijne', user.xProfile.favouriteBibleVerses),
                      if (user.xProfile.jesusIsforMe != null && user.xProfile.jesusIsforMe.isNotEmpty)
                        _buildDescription('Jezus jest dla mnie...', user.xProfile.jesusIsforMe),
                      if (user.xProfile.bestPoint != null && user.xProfile.bestPoint.isNotEmpty)
                        _buildDescription('Najlepsza cecha', user.xProfile.bestPoint),

                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
                        child: Wrap(
                          spacing: 5.0,
                          children: [
                            if (user.xProfile.maritalStatus != null && user.xProfile.maritalStatus.isNotEmpty)
                              _buildChip(user.xProfile.maritalStatus, Icons.people),
                            if (user.xProfile.religion != null && user.xProfile.religion.isNotEmpty)
                              _buildChip(user.xProfile.religion, FontAwesomeIcons.pray, iconSize: 20),
                            if (user.xProfile.religiousAffiliation != null && user.xProfile.religiousAffiliation.isNotEmpty)
                              _buildChip(user.xProfile.religiousAffiliation, FontAwesomeIcons.church, iconSize: 20),
                            if (user.xProfile.smoking != null && user.xProfile.smoking.isNotEmpty)
                              _buildChip(user.xProfile.smoking, FontAwesomeIcons.smoking, iconSize: 20),
                            if (user.xProfile.alcohol != null && user.xProfile.alcohol.isNotEmpty)
                              _buildChip(user.xProfile.alcohol, FontAwesomeIcons.glassCheers, iconSize: 20),
                            if (user.xProfile.education != null && user.xProfile.education.isNotEmpty)
                              _buildChip(user.xProfile.education, FontAwesomeIcons.graduationCap, iconSize: 20),
                            if (user.xProfile.workOrStudy != null && user.xProfile.workOrStudy.isNotEmpty)
                              _buildChip(user.xProfile.workOrStudy, Icons.engineering),
                            if (user.xProfile.hasChildren != null && user.xProfile.hasChildren.isNotEmpty)
                              _buildChip("Czy mam: " + user.xProfile.hasChildren, FontAwesomeIcons.baby, iconSize: 20),
                            if (user.xProfile.wantsChildren != null && user.xProfile.wantsChildren.isNotEmpty)
                              _buildChip("Czy chcę: " + user.xProfile.wantsChildren, FontAwesomeIcons.baby, iconSize: 20),
                            if (user.xProfile.height != null)
                              _buildChip(user.xProfile.height.toString() + "cm", Icons.height),
                            if (user.xProfile.weight != null)
                              _buildChip(user.xProfile.weight.toString() + "kg", FontAwesomeIcons.balanceScaleLeft, iconSize: 20),
                            if (user.xProfile.eyesColor != null && user.xProfile.eyesColor.isNotEmpty)
                              _buildChip(user.xProfile.eyesColor.toString(), FontAwesomeIcons.eye, iconSize: 20),
                            if (user.xProfile.hairColor != null && user.xProfile.hairColor.isNotEmpty)
                              _buildChip(user.xProfile.hairColor.toString(), Icons.face_retouching_natural_rounded),
                            if (user.xProfile.figure != null && user.xProfile.figure.isNotEmpty)
                              _buildChip(user.xProfile.figure, Icons.accessibility),
                          ],
                        )
                      )
                    ],
                  ),
                ),
                if (user.id != store.state.loggedUser.id)
                  Row(
                    children: <Widget>[
                      Flexible(
                          child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _sendTextController,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 5,
                                maxLength: 2048,
                                autofocus: false,
                                decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Napisz coś',
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(24.0)
                                    )
                                ),
                              )
                          )
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 8.0),
                        child: store.state.messagesState.sendingMessage ? Container(
                          width: 48.0,
                          child: Center(
                            child: SizedBox(
                              width: 24.0,
                              height: 24.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ) : IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(Icons.send),
                          onPressed: store.state.messagesState.sendingMessage ? null : () {
                            if (_sendTextController.text.length > 0) {
                              store.dispatch(SendMessageAction(null, _sendTextController.text, recipients: [user.id]).thunk(context));
                              _sendTextController.text = '';
                            } else {
                              store.dispatch(ShowModalDialogAction().thunk(Dialogs.error(context, params: {
                                'title': '',
                                'content': 'Wiadomość nie może być pusta'
                              })));
                            }
                          },
                        ),
                      )
                    ],
                  ),
              ],
            )
          );
        });
  }
}
