const createError = require('http-errors')
const {authSchema} = require('../config/validation_schema')
const {authLogInSchema} = require('../config/validation_schema')
const {signAccessToken} = require('../config/jwt_helper')
const {signRefreshToken} = require('../config/jwt_helper')
const {verifyRefreshToken} = require('../config/jwt_helper')
const config = require('../config/dbConfig')
const jwt = require('jwt-simple')
const Joi = require('@hapi/joi')
var User = require('../models/user_model')
const client = require('../config/init_redis')
const crypto = require("crypto");
const Token = require('../models/token')
const sendEmail = require('./sendEmail')


module.exports = {

    register: async (req,res,next) => {


        try {
        if((!req.body.email) || (!req.body.first_name) || (!req.body.last_name) || (!req.body.phone_number) || (!req.body.password))
        {
            res.send('Missing field is required')
        }

        else {

        const result = await authSchema.validateAsync(req.body)
    
      const doesExist =  await User.findOne({email: result.email})
      if(doesExist) throw createError.Conflict('${result.email} is already registered' )

      const user = new User(result)
     
      const savedUser = await user.save()
      const accessToken = await signAccessToken(savedUser.id)
      const refreshToken = await signRefreshToken(savedUser.id)
      
      
      res.send({accessToken, refreshToken})


        }

    }

    catch(error)
    {
        if(error.isJoi === true) error.status = 422
        next(error)
    }

    },


    login: async(req,res,next)=>{
        try{
            const result = await authLogInSchema.validateAsync(req.body)
            const user = await User.findOne({email: result.email})
            if(!user) throw createError.NotFound('User not registered')
    
            const isMatched = await user.isValidPassword(result.password)
    
            if(!isMatched) throw createError.Unauthorized('Username/password not valid')
           
            const accessToken = await signAccessToken(user.id)
            const refreshToken = await signRefreshToken(user.id)
            // res.write({user})
            res.send({"accesstoken": accessToken, "refreshtoken": refreshToken,"user": user})
            
        }
        catch(error){
            if(error.isJoi === true) 
            return next(createError.BadRequest('Invalid Username/Password'))
            next(error)
        }
    },


    getprofile: async(req,res,next)=> {

        try{
        User.findById(req.payload.aud).then(result =>{
            res.send(result)
        });
    }
    catch (error){
    next(error)
    }
      
    },

    // this API will be called when user will click on forget password
    resetpasswordemail: async(req,res,next)=> {

        try {
            const schema = Joi.object({ email: Joi.string().email().required() });
            const { error } = schema.validate(req.body);
            if (error) return res.status(400).send(error.details[0].message);
    
            const user = await User.findOne({ email: req.body.email });
            if (!user)
                return res.status(400).send("user with given email doesn't exist");
    
            let token = await Token.findOne({ userId: user._id });
            if (!token) {
                token = await new Token({
                    userId: user._id,
                    token: crypto.randomBytes(32).toString("hex"),
                }).save();
            }
    
            const link = `http://localhost:3000/support/password-reset/${user._id}/${token.token}`;
            await sendEmail(user.email, "Password reset", `Click here to reset your password: ${link}`);
    
            res.send("password reset link sent to your email account");
        } catch (error) {
            res.send("An error occured");
            console.log(error);
        }
    },

    // this API will be called when user will click on the reset password link in the email
    changepassword: async(req,res,next)=> {

        try {
            const schema = Joi.object({ password: Joi.string().required() });
            const { error } = schema.validate(req.body);
            if (error) return res.status(400).send(error.details[0].message);
    
            const user = await User.findById(req.params.userId);
            if (!user) return res.status(400).send("Invalid link or expired");
    
            const token = await Token.findOne({
                userId: user._id,
                token: req.params.token,
            });
            if (!token) return res.status(400).send("Invalid link or expired");
    
            user.password = req.body.password;
            await user.save();
            await token.delete();
    
            res.send("password reset sucessfully.");
        } catch (error) {
            res.send("An error occured");
            console.log(error);
        }
    },

    // the refresh token will be stored in the local storage (shared preferences for Android devices
    // and will be sent to this method when the access token has expired)
    refreshtoken: async(req,res,next) => {

        try {
            const { refreshToken } = req.body
            if(!refreshToken) throw createError.BadRequest()
            const userId = await verifyRefreshToken(refreshToken)

            const accessToken = await signAccessToken(userId)
            const RefreshToken= await  signRefreshToken(userId)

            res.send({accesstoken: accessToken, refreshtoken: RefreshToken})
            

         }

        catch (error){
            next(error)
        }

    },
// delete the access and refresh tokens from the client's local storage as soon as the user makes
//log out requuest
    logout: async(req,res,next) => {

        try {
            const {refreshToken} = req.body
            if(!refreshToken) throw createError.BadRequest()
           const userId = await verifyRefreshToken(refreshToken)
            client.DEL(userId,(err,val)=> {
                if(err)
                {
                    console.log(err.message)
                    throw createError.InternalServerError()
                }

                console.log(val)
                res.sendStatus(204)

            })
         }

        catch (error){
            next(error)
        }

    }




        









}
