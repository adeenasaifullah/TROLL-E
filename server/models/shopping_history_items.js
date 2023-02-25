const mongoose = require('mongoose');
const Schema = mongoose.Schema;

var shoppingHistoryItemsSchema = new Schema({
    productID: {
        type: String,
        required: true
    },
    productQuantity: {
        type: Number,
        required: true
    },
    grossTotal: {
        type: Number,
        required: true
    },
    // for soft delete
    isDeleted: {
        type: Boolean,
        default: false
    }
})

// const shoppingHistoryItems = mongoose.model('ShoppingHistoryItems', shoppingHistoryItemsSchema)
// module.exports = shoppingHistoryItems

module.exports = shoppingHistoryItemsSchema