const express = require("express")
const cors = require('cors')
const mongoose = require('mongoose')
const connectDB = require('./config/db')
const bodyParser = require("body-parser")
const routes = require('./routes/app')


connectDB()

const app = express();

app.use(cors());
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(routes) // the server now has access to all the routes defined in app.js and can use them



mongoose.set('strictQuery', true);



const PORT = process.env.PORT || 3000;
app.listen(PORT,  console.log(`connected at port ${PORT}`))
