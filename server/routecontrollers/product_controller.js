const Products = require('../models/product_model')

module.exports = {
    getAllPrdoucts: async (req, res, next) => {
        Products.find({})
            .exec((error, products) => {
                if (error)
                    return res.status(400).json({ error })
                if (products) {
                    res.status(200).json({ products })
                }
            })
    },

    decreaseStockQuantity: async (productID, quantity) => {
        productID.quantity -= quantity
        await productID.save({ validateBeforeSave: false });
        res.status(201).json({
            message: "Success"
        })
    }
}