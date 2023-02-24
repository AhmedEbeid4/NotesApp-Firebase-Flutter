class Note{

  String? id;
  late String title;
  late String content;

  Note({required this.title,required this.content,this.id});

  factory Note.fromJson(String id,Map<String, dynamic> item){
    return Note(
        id:id,
        title: item['title'],
        content: item['content']
    );
  }


  Map<String,dynamic> toJson() => {
    'title' : title,
    'content' : content
  };
}