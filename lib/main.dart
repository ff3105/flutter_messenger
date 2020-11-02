import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'utils/utils.dart';
import 'config/config.dart';
import 'pages/pages.dart';
import 'simple_bloc_observer.dart';

// ignore: avoid_void_async
void main() async {
  // Bloc.observer = SimpleBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPres.prefsInstance();

  final _sharePrefs = SharedPres();
  final _authRepository = AuthRepository();
  final _conversationRepository = ConversationRepository();
  final _contactRepository = ContactRepository();
  final _messageRepository = MessageRepository();
  final _userRepository = UserRepository();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<AuthBloc>(create: (context) {
        return AuthBloc(_authRepository, _userRepository, _sharePrefs)
          ..add(AppLaunchAuthEvent());
      }),
      BlocProvider<ConversationBloc>(create: (context) {
        return ConversationBloc(_conversationRepository)
          ..add(FetchConversationEvent());
      }),
      BlocProvider<ContactBloc>(create: (context) {
        return ContactBloc(_contactRepository)..add(FetchContactEvent());
      }),
      BlocProvider<MessagesBloc>(create: (context) {
        return MessagesBloc(_messageRepository);
      }),
      BlocProvider<SettingBloc>(create: (context) {
        return SettingBloc();
      }),
    ], child: MainApp()),
  );
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

// ignore: prefer_mixin
class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  Key restartKey = UniqueKey(); //todo: cant rebuild widget when logout ???

  @override
  void initState() {
    super.initState();
    restartKey = UniqueKey();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    print("out");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive:
        print("Inactive");
        // offline
        break;
      case AppLifecycleState.paused:
        print("Paused");
        break;
      case AppLifecycleState.resumed:
        print("Resumed");
        // online
        break;
      case AppLifecycleState.detached:
        print("Suspending");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, state) {
        if (state is RestartAppState) {
          restartKey = UniqueKey();
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          key: restartKey,
          home: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthSuccess) {
              return HomePage();
            } else if (state is AuthFail) {
              return LoginPage();
            } else if (state is AuthProgress) {
              return const CircularProgressIndicator();
            } else {
              return const Text("data");
            }
          }),
          routes: Routes.routes,
        );
      },
    );
  }
}
