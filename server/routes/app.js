const express = require('express')
const router = express.Router();
const { verifyAccessToken } = require('../config/jwt_helper');
const braintree_controller = require('../routecontrollers/braintree_controller');
const productController = require('../routecontrollers/product_controller');
const receiptController = require('../routecontrollers/receipt_controller');
const tempReceiptController = require('../routecontrollers/temp_receipt_controller');
const userController = require('../routecontrollers/user_controller');
// import all other controller, example receipt controller, product controller

//all routes will be written here

router.post('/register', userController.register)
router.post('/login', userController.login)
router.get('/getprofile', verifyAccessToken, userController.getprofile)
router.post('/forgotpassword', userController.resetpasswordemail)
router.post('/changepassword/:userId/:token', userController.changepassword)
router.post('/refresh', userController.refreshtoken)
router.delete('/logout', userController.logout)
router.put('/addToShoppingHistory/:userID',verifyAccessToken, receiptController.addHistory)
router.get('/getHistory/:userID', verifyAccessToken, receiptController.getHistory)
router.get('/allProducts', verifyAccessToken, productController.getAllPrdoucts)
router.post('/addTempReceipt', tempReceiptController.addTempReceipt)
router.put('/addItemToCart/:userID', tempReceiptController.addItem)
router.put('/decreaseQuantity/:userID', tempReceiptController.decreaseQuantity)



module.exports = router