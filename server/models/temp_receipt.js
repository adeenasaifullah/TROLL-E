const mongoose = require('mongoose');
const receiptSchema = require('./receipt_model');

var tempReceiptSchema = new mongoose.Schema({
    userID: {
        type: String,
        required: true,
        unique: true
    },
    receipt: {
        totalWeight: {
            type: Number,
            default: 0,
            required: true
        },
        date: {
            type: Date,
            default: Date.now(),
            required: true
        },
        netTotal: {
            type: Number,
            default: 0,
            required: true
        },
        totalDiscount: {
            type: Number,
            default: 0,
           required: true
        },
        gst: {
            type: Number,
        },
        isDeleted: {
            type: Boolean,
            default: false
        },
        items: [{
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
        }]
    },
    UID: {
        type: String,
        required: true
    }
})

const receipt = mongoose.model('tempReceipt', tempReceiptSchema)
module.exports = receipt