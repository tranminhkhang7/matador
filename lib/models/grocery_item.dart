class GroceryItem {
  final int? id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final int quantity;
  GroceryItem({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });
}

var demoItems = [
  GroceryItem(
    id: 1,
    name: "Komi - Nữ Thần Sợ Giao Tiếp",
    description: "7pcs, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 1,
  ),
  GroceryItem(
    id: 2,
    name: "Đắc Nhân Tâm",
    description: "1kg, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 2,
  ),
  GroceryItem(
    id: 3,
    name: "Bell Pepper",
    description: "1kg, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 3,
  ),
  GroceryItem(
    id: 4,
    name: "Ginger",
    description: "250gm, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 4,
  ),
  GroceryItem(
    id: 5,
    name: "Meat",
    description: "250gm, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 5,
  ),
  GroceryItem(
    id: 6,
    name: "Chikken",
    description: "250gm, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 6,
  ),
  GroceryItem(
    id: 7,
    name: "Chikken2",
    description: "250gm, Priceg",
    price: 4.99,
    imagePath:
        "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
    quantity: 7,
  ),
];

var exclusiveOffers = [demoItems[0], demoItems[1], demoItems[2]];

var bestSelling = [demoItems[6], demoItems[3]];

var groceries = [demoItems[4], demoItems[5]];

var beverages = [
  GroceryItem(
      id: 7,
      name: "Dite Coke",
      description: "355ml, Price",
      price: 1.99,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 8),
  GroceryItem(
      id: 8,
      name: "Sprite Can",
      description: "325ml, Price",
      price: 1.50,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 9),
  GroceryItem(
      id: 8,
      name: "Apple Juice",
      description: "2L, Price",
      price: 15.99,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 10),
  GroceryItem(
      id: 9,
      name: "Orange Juice",
      description: "2L, Price",
      price: 1.50,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 11),
  GroceryItem(
      id: 10,
      name: "Coca Cola Can",
      description: "325ml, Price",
      price: 4.99,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 12),
  GroceryItem(
      id: 11,
      name: "Pepsi Can",
      description: "330ml, Price",
      price: 4.99,
      imagePath:
          "https://images.unsplash.com/photo-1592496431122-2349e0fbc666?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Ym9vayUyMGNvdmVyfGVufDB8fDB8fA%3D%3D&w=1000&q=80",
      quantity: 13),
];
