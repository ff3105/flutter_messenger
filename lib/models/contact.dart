part of 'models.dart';

class Contact {
  String uID;
  String cID;
  String name;
  String email;
  String avatar;
  bool isOnline;

  Contact(
      this.uID, this.cID, this.name, this.email, this.avatar, this.isOnline);

  factory Contact.fromMap(Map map) {
    return Contact(
        map[Fields.userUID],
        null,
        map[Fields.contactName],
        map[Fields.contactEmail],
        map[Fields.contactAvatar],
        map[Fields.userIsOnline]);
  }

  factory Contact.fromUser(Map map) {
    final _user = User.fromMap(map);
    return Contact(
        _user.uID, null, _user.name, _user.email, _user.avatar, _user.isOnline);
  }

  @override
  String toString() {
    return 'Contact{uID: $uID, cID: $cID, name: $name, email: $email, avatar: $avatar, isOnline: $isOnline}';
  }
}
