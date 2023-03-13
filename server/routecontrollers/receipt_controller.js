// const mongoose = require('mongoose');
// const Schema = mongoose.Schema;

// const {receiptSchema} = require('../models/receipt_model');
//const shoppingHistorySchema = require('../models/shopping_history_model');
const user = require('../models/user_model')

// const shoppingHistory = mongoose.model('ShoppingHistory', shoppingHistorySchema);
// const ReceiptModel = mongoose.model('Receipt', receiptSchema);


module.exports = {
    addHistory: async (req, res, next) => {
        try {
            const User = await user.findById(req.params.userID)
            if (!User) {
                return res.status(500).json({
                    success: false,
                    message: "Invalid user"
                })
            }
            const {
                items,
                netTotal,
                gst
            } = req.body
            User.shoppingHistory
                .receipt
                .push({
                    netTotal,
                    gst,
                    date: Date.now(),
                    items,
                    isDeleted: false
                })
            await User.save({
                validateBeforeSave: false
            })
            res.status(204).json({
                success: true,

            })
        } catch (err) {
            next(err)
        }
    },

    getHistory: async (req, res, next) => {
        try {
            const User = await user.findById(req.params.userID)
            res.status(200).json(User.shoppingHistory.receipt)

        } catch (err) {
            next(err)
        }
    },

}