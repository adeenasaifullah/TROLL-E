const mongoose = require('mongoose');
const receiptSchema = require('./receipt_model');
//const receipt = require('./receipt_model');
const Schema = mongoose.Schema;

var shoppingHistorySchema = new Schema({
    receipt: [receiptSchema]
})

// const shoppingHistory = mongoose.model('ShoppingHistory', shoppingHistorySchema)
// module.exports = shoppingHistory

module.exports = shoppingHistorySchema