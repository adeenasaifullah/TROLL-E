const Joi = require('@hapi/joi')
const authSchema = Joi.object({
email: Joi.string().email().lowercase().required(),
first_name: Joi.string().required(),
last_name: Joi.string().required(),
phone_number: Joi.string().length(11).required(),
password: Joi.string().min(2).required()
})

const authLogInSchema = Joi.object({
    email: Joi.string().email().lowercase().required(),
    password: Joi.string().min(2).required()
    })

module.exports = {
    authSchema,
    authLogInSchema
}