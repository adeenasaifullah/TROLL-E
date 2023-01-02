const mongoose = require('mongoose')
const dbConfig = require('./dbConfig')


const connectDB = async () => {

    try {
        mongoose.set('strictQuery', true);
        const conn = mongoose.connect(dbConfig.database, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        })

        console.log(`MongoDB Connected`)
    }
    catch (err) {
        console.log(err)
        process.exit(1)
    }
}

module.exports = connectDB