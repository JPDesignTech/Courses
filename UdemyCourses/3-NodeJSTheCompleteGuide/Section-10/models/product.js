const ourDatabase = require('../util/database');

const Cart = require('./cart');


module.exports = class Product {
    constructor(id, title, imageUrl, description, price) {
        this.id = id;
        this.title = title;
        this.imageUrl = imageUrl;
        this.description = description;
        this.price = price;
    }

    save() {
        return ourDatabase.execute(
            'INSERT INTO  products (title, price, imageUrl, description) VALUES (?, ?, ?, ?)', [this.title, this.price, this.imageUrl, this.description]);
    }

    static deleteById(id) {

    }

    // Fetch from the Database 
    static fetchAll() {
        return ourDatabase.execute('SELECT * FROM products'); // return Promise
    }

    static findById(id) {
        return ourDatabase.execute('SELECT * FROM products WHERE products.id = ?', [id]);
    }
};