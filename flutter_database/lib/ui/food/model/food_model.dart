class Food {
    int id;
    String name;
    double price;
    int qty;
    String img_name;

    Food({this.id, this.name, this.price, this.qty,this.img_name});

    factory Food.fromJson(Map<String, dynamic> json) {
        return Food(
            id: json['id'],
            name: json['name'],
            price: json['price'],
            qty: json['qty'],
            img_name: json['img_name'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['name'] = this.name;
        data['price'] = this.price;
        data['qty'] = this.qty;
        data['img_name']=this.img_name;
        return data;
    }
}