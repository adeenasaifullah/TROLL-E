const express = require("express")
const cors = require('cors')
const mongoose = require('mongoose')
const connectDB = require('./config/db')


connectDB()

const app = express();

app.use(cors);



mongoose.set('strictQuery', true);



const PORT = process.env.PORT || 3000;
app.listen(PORT,  console.log(`connected at port ${PORT}`))
