
class AcceptTerms{
  int? id;
  int? isAccepted;
  AcceptTerms({
    this.id,
    this.isAccepted,
  });
  AcceptTerms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAccepted = json['isAccepted']; 
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['isAccepted']=this.isAccepted;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isAccepted': isAccepted,
    };
  }
}