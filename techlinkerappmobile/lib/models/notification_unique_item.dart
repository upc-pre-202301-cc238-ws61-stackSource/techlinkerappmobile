class NotificationUniqueItem {
  String? id;
  String? content;
  String? emitterIcon;
  String? date;
  String? emitter;

  NotificationUniqueItem(
      {required this.id,
      required this.emitterIcon,
      required this.content,
      required this.date,
      required this.emitter});

  static List<NotificationUniqueItem> notificationItems() {
    return [
      NotificationUniqueItem(
          id: "01",
          emitterIcon:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          content: "John Doe has sent you a message",
          date: "2021-10-10",
          emitter: "John Doe"),
      NotificationUniqueItem(
          id: "02",
          emitterIcon:
              "https://images.pexels.com/photos/749091/pexels-photo-749091.jpeg",
          content: "Jane Smith has applied for the position ",
          date: "2021-10-10",
          emitter: "Jane Smith"),
      NotificationUniqueItem(
          id: "03",
          emitterIcon:
              "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg",
          content: "Robert Johnson has sent you a message",
          date: "2021-10-10",
          emitter: "Robert Johnson"),
      NotificationUniqueItem(
          id: "04",
          emitterIcon:
              "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          content: "Shao Leen has applied for the position",
          date: "2021-10-10",
          emitter: "Shao Leen"),
      NotificationUniqueItem(
          id: "05",
          emitterIcon:
              "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          content: "John Doe has applied for the position ",
          date: "2021-10-10",
          emitter: "John Doe"),
      NotificationUniqueItem(
          id: "06",
          emitterIcon:
              "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          content: "Jane Smith has sent you a message",
          date: "2021-10-10",
          emitter: "Jane Smith"),
    ];
  }
}
