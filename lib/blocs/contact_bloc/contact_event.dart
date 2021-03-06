part of '../blocs.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();
}

class FetchContactEvent extends ContactEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'FetchContactEvent{}';
  }
}

class ReceiveContactEvent extends ContactEvent {
  final List<Contact> contact;

  const ReceiveContactEvent(this.contact);

  @override
  List<Object> get props => [contact];
}

class AddContactEvent extends ContactEvent {
  final String email;

  const AddContactEvent(this.email);

  @override
  List<Object> get props => [email];
}

class RemoveContactEvent extends ContactEvent {
  @override
  List<Object> get props => [];
}
