const express = require('express')
const router = express.Router();
const { verifyAccessToken } = require('../config/jwt_helper');
const productController = require('../routecontrollers/product_controller');
const receiptController = require('../routecontrollers/receipt_controller');
const userController = require('../routecontrollers/user_controller');
const passport = require('passport')
// import all other controller, example receipt controller, product controller

//all routes will be written here

router.post('/register', userController.register)
router.post('/login', userController.login )
router.get('/getprofile', verifyAccessToken, userController.getprofile)
router.post('/forgotpassword', userController.resetpasswordemail)
router.post('/changepassword/:userId/:token', userController.changepassword)
router.post('/refresh', userController.refreshtoken)
router.delete('/logout', userController.logout )

router.put('/addToShoppingHistory/:userID', receiptController.addHistory)
router.get('/allProducts', productController.getAllPrdoucts)
router.get('/auth/google', passport.authenticate('google', {scope: ['email','profile']}))
router.get('/google/signin', passport.authenticate('google', {
    successRedirect: '/home',
    failureRedirect: '/login'
}))

router.get('/home', (req,res) => {
    res.send("Hello!");
})



// http://localhost:3000/google/signin

module.exports = router