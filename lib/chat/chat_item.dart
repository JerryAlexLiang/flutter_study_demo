//组建的类型
enum ChatType { left, right, center }

class ChatItem {
  //组件信息描述类
  String headIconUrl; //头像
  double maxWidth; //最大宽度
  ChatType chatType; //组建的类型
  String chatContent; //文字信息
  String chatContentType; //消息内容类型
  String chatContentImageUrl;   //消息图片Url

  ChatItem(
      {this.headIconUrl,
      this.maxWidth,
      this.chatType,
      this.chatContent,
      this.chatContentType,this.chatContentImageUrl});
}
