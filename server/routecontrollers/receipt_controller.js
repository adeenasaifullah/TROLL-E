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
            //console.log(User)
            const {
                productID,
                productQuantity,
                grossTotal,
                netTotal,
                gst
            } = req.body
            // const Receipt = new User.shoppingHistory.receipt({
            //     productID,
            //     productQuantity,
            //     date: Date.now(),
            //     grossTotal,
            //     netTotal,
            //     gst
            // })
            //console.log(Receipt)
            User.shoppingHistory.receipt.push({
                productID,
                productQuantity,
                date: Date.now(),
                grossTotal,
                netTotal,
                gst
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
    }
}