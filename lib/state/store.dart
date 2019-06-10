import 'reducers/appReducer.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'middlewares/navigationMiddleware.dart';
import 'package:redux/redux.dart';
import 'appState.dart';


final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [thunkMiddleware, navigationMiddleware]
);
