const mongoose = require('mongoose');
const Schema = mongoose.Schema;
const bcrypt = require('bcrypt');
//const shoppingHistory = require('./shopping_history_model');
const shoppingHistoryItemsSchema = require('./shopping_history_items');

var userSchema = new Schema({

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
        require: true
    },

    password: {
        type: String,
        require: true
    },

    shoppingHistory: shoppingHistoryItemsSchema //{
    // receipt: [{
    // date: {
    //     type: Date,
    //     required: true
    // },
    // netTotal: {
    //     type: Number,
    //     required: true
    // },
    // gst: {
    //     type: Number,
    //     required: true
    // },
    // isDeleted: {
    //     type: Boolean,
    //     defaults: false
    // },
    //items: [{
    //     productID: {
    //         type: String,
    //         required: true
    //     },
    //     productQuantity: {
    //         type: Number,
    //         required: true
    //     },
    //     grossTotal: {
    //         type: Number,
    //         required: true
    //     },
    //     isDeleted: {
    //         type: Boolean,
    //         defaults: false
    //     }
    // }]
    //     }]
    // }

})

userSchema.pre('save', async function (next) {
    var user = this;
    try {

        if (this.isModified('password') || this.isNew) {
            const salt = await bcrypt.genSalt(10)
            const hashedPassword = await bcrypt.hash(user.password, salt)
            user.password = hashedPassword
            next()
        }
    }
    catch (error) {
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