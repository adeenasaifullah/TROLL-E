const createError = require('http-errors')
const {authSchema} = require('../config/validation_schema')
const {authLogInSchema} = require('../config/validation_schema')
const {signAccessToken} = require('../config/jwt_helper')
const config = require('../config/dbConfig')
const jwt = require('jwt-simple')
var User = require('../models/user_model')

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
      res.send({accessToken})


        }

    }

    catch(error)
    {
        if(error.isJoi === true) error.status = 422
        next(error)
    }







    }







}
