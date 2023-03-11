const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt')

var userSchema = new Schema({

    email: {
        type: String,
        require: true
    },

    google_id: {
        type: String
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

});

userSchema.pre('save', async function (next) {
    
    try {

         if (this.isModified('password') || this.isNew) {
            const salt = await bcrypt.genSalt(10)
            const hashedPassword = await bcrypt.hash(this.password, salt)
            this.password = hashedPassword
            next()
         }
    }
    catch (error)
     {
        next(error)
    }

})

userSchema.methods.isValidPassword = async function (password) {
    try {
        return await bcrypt.compare(password, this.password)

    }
    catch (error) {
        throw error
    }
}

userSchema.post('save', async function (next) {
    try {
        console.log("called after saving a user")
    }
    catch (error) {
        next(error)
    }

})
const User = mongoose.model('user', userSchema);
module.exports = User; // this is done so you can use User inside any of your files