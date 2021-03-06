part of 'pages.dart';

class ChatInfo extends StatefulWidget {
  @override
  _ChatInfoState createState() => _ChatInfoState();
}

class _ChatInfoState extends State<ChatInfo> {
  UserRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: FutureBuilder<List<User>>(
        future: _repository
            .getMembersByChatID(ModalRoute.of(context).settings.arguments),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (contextB, index) {
                  return ListTile(
                      title: snapshot.data[index] != null
                          ? Text("${snapshot.data[index].name}")
                          : Text("null"));
                });
          } else {
            return Container();
          }
        },
      )),
    );
  }
}
