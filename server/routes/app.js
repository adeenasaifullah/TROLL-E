const express = require('express')
const router = express.Router();
const { verifyAccessToken } = require('../config/jwt_helper');
const product_controller = require('../routecontrollers/product_controller');
const userController = require('../routecontrollers/user_controller');
// import all other controller, example receipt controller, product controller

//all routes will be written here

router.post('/register', userController.register)
router.get('/allProducts', product_controller.getAllPrdoucts)


module.exports = router