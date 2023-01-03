const mongoose = require('mongoose');

const productSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true,
    },
    quantity: {
        type: Number,
        required: true
    },
    barcode: {
        type: String,
        required: true
    },
    discount: {
        type: Number,
        required: true
    },
    weight: {
        type: Number,
        required: true
    },
    description: {
        type: String,
        required: true
    },
    SKU: {
        type: String,
        required: true
    }
},)

module.exports = mongoose.model('Products', productSchema);