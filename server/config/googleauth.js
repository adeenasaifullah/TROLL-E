const GoogleStrategy = require('passport-google-oauth20').Strategy;
const passport = require('passport')
const mongoose = require('mongoose')
var User = require('../models/user_model')
const {signAccessToken} = require('../config/jwt_helper')
const {signRefreshToken} = require('../config/jwt_helper')





module.exports = (passport) => {


  passport.use(new GoogleStrategy({
    clientID: '495548594516-lm6q0h79bifcchod2ii9dpl7hrcf3fuk.apps.googleusercontent.com',
    clientSecret: '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',
    callbackURL: "http://localhost:3000/google/signin",
    passReqToCallback: true,
  },
  function(request, accessToken, refreshToken, profile, done) {
    return done(null, profile);
  }));


passport.serializeUser( (user, done) => { 
  console.log(`\n--------> Serialize User:`)
  console.log(user)
   // The USER object is the "authenticated user" from the done() in authUser function.
   // serializeUser() will attach this user to "req.session.passport.user.{user}", so that it is tied to the session object for each session.  

  done(null, user)
} )
  
passport.deserializeUser((user, done) => {
  console.log("\n--------- Deserialized User:")
  console.log(user)
  // This is the {user} that was saved in req.session.passport.user.{user} in the serializationUser()
  // deserializeUser will attach this {user} to the "req.user.{user}", so that it can be used anywhere in the App.

  done (null, user)
}) 


}


