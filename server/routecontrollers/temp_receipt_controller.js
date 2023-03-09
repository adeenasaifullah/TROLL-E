var tempReceipt = require("../models/temp_receipt")
const Products = require("../models/product_model")
const User = require("../models/user_model")

module.exports = {

    addTempReceipt: async (req, res) => {
        try {
            const User = await tempReceipt.findOne({
                userID: req.body.userID
            })
            if (User) {
                return res.status(409).json({
                    success: false,
                    message: "User is already shopping"
                })
            }
            const tempreceipt = new tempReceipt({
                userID: req.body.userID,
                UID: req.body.UID
            })
            await tempreceipt.save({ validateBeforeSave: false })
            res.status(204).send({
                success: true,
                message: "User has been added"
            })
        } catch (err) {
            res.status(401).json({
                success: false,
                message: "Scan again",
                error: err.message
            })
        }
    },

    addItem: async (req, res) => {
        try {
            const user = await User.findById(req.params.userID)
            if (!user) {
                return res.status(500).json({
                    success: false,
                    message: "Invalid user"
                })
            }
            const shoppingUser = await tempReceipt.findOne({
                userID: req.params.userID
            })
            if (!shoppingUser) {
                return res.status(409).json({
                    success: false,
                    message: "User is not shopping"
                })
            }
            const {
                productID,
                productQuantity
            } = req.body
            const product = await Products.findById(productID)
            if (!product) {
                return res.status(409).json({
                    success: false,
                    message: "Invalid product"
                })
            }
            var netTotal;
            var totalWeight;
            // HAVE TO DISCUSS DISCOUNT
            const grossTotal = productQuantity * product.price * (1 - product.discount)
            netTotal = shoppingUser.receipt.netTotal + grossTotal

            // WEIGHT IS IN GRAMS. /1000 TO CONVERT INTO KGS
            totalWeight = (shoppingUser.receipt.totalWeight) + (product.weight / 1000 * productQuantity)
            //  const totalDiscount = 
            shoppingUser.receipt.items.push({
                productID,
                productQuantity,
                grossTotal,
                isDeleted: false
            })
            shoppingUser.receipt.netTotal = netTotal
            shoppingUser.receipt.totalWeight = totalWeight
            await shoppingUser.save()
            res.status(204).send({
                success: true,
                message: "Product added to shopping cart"
            })
        } catch (err) {
            res.status(401).json({
                success: false,
                message: "Failed to add product",
                error: err.message
            })
        }
    },

    increaseQuantity: async (req, res) => {
        try {
            const user = await User.findById(req.params.userID)
            if (!user) {
                return res.status(500).json({
                    success: false,
                    message: "Invalid user"
                })
            }
            const shoppingUser = await tempReceipt.findOne({
                userID: req.params.userID
            })
            if (!shoppingUser) {
                return res.status(409).json({
                    success: false,
                    message: "User is not shopping"
                })
            }
            const {
                cartProductID,
                increaseProductQuantity
            } = req.body
            var product = await Products.findById(cartProductID)
            
            if (!product) {
                return res.status(409).json({
                    success: false,
                    message: "Invalid product"
                })
            }
           
            var cartProductIndex = shoppingUser.receipt?.items.findIndex(element => element.productID == cartProductID)
            if (cartProductIndex == -1){
                return res.status(409).json({
                    success: false,
                    message: "You do not have this product in your cart."
                })
            }
            var cartProduct = shoppingUser.receipt?.items[cartProductIndex]
            var grossTotal = (parseInt(cartProduct.productQuantity) + parseInt(increaseProductQuantity)) * product.price * (1 - product.discount)
            shoppingUser.receipt.items[cartProductIndex].grossTotal = grossTotal
            var increaseGrossTotal = increaseProductQuantity * product.price * (1 - product.discount)
            shoppingUser.receipt.netTotal = shoppingUser.receipt.netTotal + increaseGrossTotal
            shoppingUser.receipt.totalWeight = (shoppingUser.receipt.totalWeight) + (product.weight / 1000 * (increaseProductQuantity))
            shoppingUser.receipt.items[cartProductIndex].productQuantity = parseInt(cartProduct.productQuantity) + parseInt(increaseProductQuantity)
            await shoppingUser.save()
            res.status(204).send({
                success: true,
                message: "Product quantity increase in the shopping cart"
            })

        } catch (err) {
            res.status(400).json({
                success: false,
                message: "Failed to increase quantity",
                error: err.message
            })
        }

    },

    decreaseQuantity: async (req, res) => {
        try {
            const user = await User.findById(req.params.userID)
            if (!user) {
                return res.status(500).json({
                    success: false,
                    message: "Invalid user"
                })
            }
            const shoppingUser = await tempReceipt.findOne({
                userID: req.params.userID
            })
            if (!shoppingUser) {
                return res.status(409).json({
                    success: false,
                    message: "User is not shopping"
                })
            }
            const {
                cartProductID,
                removeProductQuantity
            } = req.body
            var product = await Products.findById(cartProductID)
            
            if (!product) {
                return res.status(409).json({
                    success: false,
                    message: "Invalid product"
                })
            }
           
    
            var cartProductIndex = shoppingUser.receipt?.items.findIndex(element => element.productID == cartProductID)
            if (cartProductIndex == -1){
                return res.status(409).json({
                    success: false,
                    message: "You do not have this product in your cart."
                })
            }
            var cartProduct = shoppingUser.receipt?.items[cartProductIndex]

            if (removeProductQuantity == 1 && cartProduct.productQuantity == 1) {
                shoppingUser.receipt?.items.splice(cartProductIndex, 1)
                shoppingUser.receipt.netTotal = shoppingUser.receipt.netTotal - cartProduct.grossTotal
                shoppingUser.receipt.totalWeight = (shoppingUser.receipt.totalWeight) - (product.weight / 1000 )
                await shoppingUser.save()
                res.status(204).send({
                    success: true,
                    message: "Product removed from shopping cart"
                })

            }
            else if (cartProduct.productQuantity < removeProductQuantity) {
                res.status(409).send({
                    success: false,
                    message: "You have less items in your cart than you want to remove"
                })
            }
            else {
                var grossTotal = (cartProduct.productQuantity - removeProductQuantity) * product.price * (1 - product.discount)
                shoppingUser.receipt.items[cartProductIndex].grossTotal = grossTotal
                var removeGrossTotal = removeProductQuantity * product.price * (1 - product.discount)
                shoppingUser.receipt.netTotal = shoppingUser.receipt.netTotal - removeGrossTotal
                shoppingUser.receipt.totalWeight = (shoppingUser.receipt.totalWeight) - (product.weight / 1000 * (removeProductQuantity))
                shoppingUser.receipt.items[cartProductIndex].productQuantity = cartProduct.productQuantity - removeProductQuantity
                await shoppingUser.save()
                res.status(204).send({
                    success: true,
                    message: "Product quantity decreased from shopping cart"
                })
            }
        } catch (err) {
            res.status(400).json({
                success: false,
                message: "Failed to decrease quantity",
                error: err.message
            })
        }
    },

}

