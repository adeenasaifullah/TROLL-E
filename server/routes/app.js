const express = require('express')
const router = express.Router();
const {verifyAccessToken} = require('../config/jwt_helper')
const userController = require('../routecontrollers/user_controller');
// import all other controller, example receipt controller, product controller

//all routes will be written here

router.post('/register', userController.register)
router.post('/login', userController.login )
router.get('/getprofile', verifyAccessToken, userController.getprofile)
router.post('/forgotpassword', userController.resetpasswordemail)
router.post('/changepassword/:userId/:token', userController.changepassword)
router.post('/refresh', userController.refreshtoken)
router.delete('/logout', userController.logout )


module.exports = router