const express = require("express")
const cors = require('cors')
const mongoose = require('mongoose')
const connectDB = require('./config/db')
const bodyParser = require("body-parser")
const routes = require('./routes/app')
const passport = require('passport')
const session = require('express-session');

require('./config/googleauth')(passport)
connectDB()

const app = express();

app.use(cors());
app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())
app.use(session({
  secret: 'aahms',
  resave: false,
  saveUninitialized: false,
 // store: new SQLiteStore({ db: 'sessions.db', dir: './var/db' })
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(routes) // the server now has access to all the routes defined in app.js and can use them








const PORT = process.env.PORT || 3000;
app.listen(PORT,  console.log(`connected at port ${PORT}`))
