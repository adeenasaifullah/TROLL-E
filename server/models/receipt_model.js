const { array } = require('@hapi/joi');
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
    totalDiscount: {
        type: Number,
        required: true
    },
    gst: {
        type: Number,  
    },
    isDeleted: {
        type: Boolean,
        default: false
    },
    items: [
        {
            type: shoppingHistoryItemsSchema
        }
    ]
})

module.exports = receiptSchema