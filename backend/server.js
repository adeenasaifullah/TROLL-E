const express = require('express')
const { default: mongoose } = require('mongoose')
const port = process.env.PORT || 3000
const app = express()

mongoose.set("strictQuery", false);

mongoose
    .connect("mongodb+srv://aahms:aahms@troll-e-db.wysi7xk.mongodb.net/test", {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    }).then(() => {
        console.log("MongoDB connection successful")
    }).catch((e) => {
        console.log(e)
    })

app.listen(port, "0.0.0.0", () => {
    console.log(`Connected at port ${port}`)
})

