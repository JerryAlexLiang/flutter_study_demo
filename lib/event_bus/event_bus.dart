import 'package:event_bus/event_bus.dart';

//实例化EventBus库，创建一个事件总线
EventBus eventBus = EventBus();

//定义event事件，既要传递和共享的实体类
class UserEvent {
  String userName;

  UserEvent(this.userName);
}

//可以定义多个实体类
class BookEvent {
  String bookName;

  BookEvent(this.bookName);
}
