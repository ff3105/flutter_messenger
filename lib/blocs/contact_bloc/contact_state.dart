part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();
}

class ContactInitial extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactSuccess extends ContactState {
  final List<User> contacts;

  const ContactSuccess(this.contacts);

  @override
  List<Object> get props => [contacts];
}

class ContactProgress extends ContactState {
  @override
  List<Object> get props => [];
}

class ContactFail extends ContactState {
  @override
  List<Object> get props => [];
}

