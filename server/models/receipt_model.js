const mongoose = require('mongoose');
const shoppingHistoryItemsSchema = require('./shopping_history_items');
const Schema = mongoose.Schema;

//var shoppingHistoryItems = require('./shopping_history_items')

var receiptSchema = new Schema({
    date: {
        type: Date,
        required: true
    },
    netTotal: {
        type: Number,
        required: true
    },
    gst: {
        type: Number,
        required: true
    },
    isDeleted: {
        type: Boolean,
        default: false
    },
    items: [shoppingHistoryItemsSchema]
})

// const receipt = mongoose.model('Receipt', receiptSchema)
// module.exports = receipt

module.exports = receiptSchema