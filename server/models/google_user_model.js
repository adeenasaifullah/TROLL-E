const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt')

var googleUserSchema = new Schema({

    email: {
        type: String,
        require: true
    },

    first_name: {
        type: String,
        require: true
    },

    last_name: {
        type: String,
        require: true
    },

    phone_number: {
        type: String,
        
    },

    image: {
        type: String
    },

    password: {
        type: String,
        require: true
    },

    shoppingHistory: {
        receipt: [{
            productID: {
                type: String,
                required: true
            },
            productQuantity: {
                type: Number,
                required: true
            },
            date: {
                type: Date,
                required: true
            },
            grossTotal: {
                type: Number,
                required: true
            },
            netTotal: {
                type: Number,
                required: true
            },
            gst: {
                type: Number,
                required: true
            }
        }]
    }

})

googleUserSchema.pre('save', async function (next) {
    var user = this;
    try {

        if (this.isModified('password') || this.isNew) {
            const salt = await bcrypt.genSalt(10)
            const hashedPassword = bcrypt.hash(user.password, salt)
            user.password = hashedPassword
            next()
        }
    }
    catch (error) {
        next(error)
    }

})


googleUserSchema.post('save', async function (next) {
    try {
        console.log("called after saving a user")
    }
    catch (error) {
        next(error)
    }

})
const GoogleUser = mongoose.model('googleuser', googleUserSchema);
module.exports = GoogleUser; // this is done so you can use User inside any of your files