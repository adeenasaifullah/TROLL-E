const JWT = require('jsonwebtoken')
const createError = require('http-errors')

module.exports = {
    signAccessToken: (userID)=>{
        return new Promise((resolve,reject)=>{
            const payload ={}
            const secret = "f54079367f2207aa794e526d2e7acad03d274996cae20c8623309263b105cb31"
            const options = {
                expiresIn: "1h",
                issuer: 'pickurpage.com',
                audience: userID

            }
            JWT.sign(payload,secret,options,(err,token)=>{
                if(err){
                    console.log(err.message)
                    reject(createError.InternalServerError())
                } 
                resolve(token)
            })
        })
    },

    verifyAccessToken: (req,res,next)=>{

        if(!req.headers['authorization']) return next(createError.Unauthorized())
        const authHeader = req.headers['authorization']
        const bearerToken = authHeader.split(' ')
        const token = bearerToken[1]
        JWT.verify(token, "f54079367f2207aa794e526d2e7acad03d274996cae20c8623309263b105cb31", (err,payload)=>{
            if(err)
            {
                if(err.name === 'JsonWebTokenError')
                {
                    return next(createError.Unauthorized())
                }
                else{
                    return next(createError.Unauthorized(err.message))
                }
                
            }
            req.payload = payload
            next()
        })

    },
    signRefreshToken :  (userID)=>{
        return new Promise((resolve,reject)=>{
            const payload ={}
            const secret = "dedb4a76e1dd59198199d9452d73568e827cc924398f6724c6cf2fc31324393b"
            const options = {
                expiresIn: "1y",
                issuer: 'pickurpage.com',
                audience: userID

            }
            JWT.sign(payload,secret,options,(err,token)=>{
                if(err){
                    console.log(err.message)
                    reject(createError.InternalServerError())
                } 
                resolve(token)
            })
        })
    },

    verifyRefreshToken : (refreshToken)=>{
        
        return new Promise((resolve,reject) => {

            JWT.verify(refreshToken, "dedb4a76e1dd59198199d9452d73568e827cc924398f6724c6cf2fc31324393b", (err, playload) => {
                if (err) return reject(createError.Unauthorized())
                const userId = payload.audience

                resolve(userId)

            })



        })

    },
}