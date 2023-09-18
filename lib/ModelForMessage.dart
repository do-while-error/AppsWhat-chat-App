class Message {
  Message({
    required this.msg,
    required this.read,
    required this.form,
    required this.to,
    required this.type,
    required this.sent,
  });
  late final String msg;
  late final String read;
  late final String form;
  late final String to;
  late final Type type;
  late final String sent;

  Message.fromJson(Map<String, dynamic> json){
    msg = json['msg'].toString();
    read = json['read'].toString();
    form = json['form'].toString();
    to = json['to'].toString();
    type = json['type'].toString() == Type.image.name? Type.image : Type.text;
    sent = json['sent'].toString();
  }

  // get timestamp => '${timestamp.year}-${timestamp.month}-${timestamp.day} ${timestamp.hour}:${timestamp.minute}:${timestamp.second}';

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['msg'] = msg;
    data['read'] = read;
    data['form'] = form;
    data['to'] = to;
    data['type'] = type.name;
    data['sent'] = sent;
    return data;
  }
}

enum Type {
  text, image
}