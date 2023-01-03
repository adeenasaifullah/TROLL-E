const express = require('express')
const router = express.Router();
const { verifyAccessToken } = require('../config/jwt_helper');
const productController = require('../routecontrollers/product_controller');
const receiptController = require('../routecontrollers/receipt_controller');
const userController = require('../routecontrollers/user_controller');
// import all other controller, example receipt controller, product controller

//all routes will be written here

router.post('/register', userController.register)
router.put('/addToShoppingHistory/:userID', receiptController.addHistory)
router.get('/allProducts', productController.getAllPrdoucts)


module.exports = router