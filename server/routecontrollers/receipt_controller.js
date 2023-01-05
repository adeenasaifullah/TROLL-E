const user = require('../models/user_model')

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
            User.shoppingHistory.receipt.push({
                netTotal,
                date: Date.now(),
                items
            })
            await User.save({
                validateBeforeSave: false
            })
            res.status(204).json({
                success: true,

            })
        } catch (err) {
            res.status(400).json(
                {
                    success: false,
                    message: err
                }
            )
        }
    },

    getHistory: async (req, res, next) => {
        try {
            const User = await user.findById(req.params.userID)
            res.status(200).json(User.shoppingHistory.receipt)

        } catch (err) {
            res.status(401).json({
                message: err
            })
        }
    }
}