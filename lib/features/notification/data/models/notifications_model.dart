import 'package:fcm_notification/features/notification/data/models/notification_model.dart';
import 'package:fcm_notification/features/notification/domain/entities/notification_entity.dart';

class NotificationsModel {
  List<NotificationEntity> notifications = [];

  NotificationsModel({required this.notifications});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['notifications'] != null) {
      json['notifications'].forEach((v) {
        notifications.add(NotificationModel.fromJson(v));
      });
    }
  }

  List<Object?> get props => [notifications];
}


// class ContactsModel {
//   List<Contact> contacts = [];

//   ContactsModel({required this.contacts});

//   ContactsModel.fromJson(Map<String, dynamic> json) {
//     if (json['contacts'] != null) {
//       json['contacts'].forEach((v) {
//         contacts.add(ContactModel.fromJson(v));
//       });
//     }
//   }

//   ContactsModel.fromXml(XmlDocument xmlDocument) {
//     contacts = [];
//     for (XmlElement xmlElement in xmlDocument.findAllElements('contact')) {
//       contacts.add(ContactModel.fromXml(xmlElement));
//     }
//   }

//   @override
//   List<Object?> get props => [contacts];
// }
