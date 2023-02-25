//const { gateway } = require('../config/braintree')

// var gateway = new braintree.BraintreeGateway({
//     environment: braintree.Environment.Sandbox,
//     merchantId: braintreeConfig.merchantId,
//     publicKey: braintreeConfig.publicKey,
//     privateKey: braintreeConfig.privateKey
// })

// module.exports = {
//     ping: async (req, res, next) => {
//         gateway.
//         res.send("Braintree is connected.")
//     },

//     getToken: async (req, res, next) => {
//         try {
//             gateway.clientToken.generate({
                
//             }, (err, response) => {
//                 if (err) {
//                     res.status(500).send(err);
//                 } else {
//                     res.send(response);
//                 }
//             });
//         } catch (err) {
//             res.status(500).send(err);
//         }
//     },

//     makePayment: async (req, res, next) => {
//         try {
//             // Use the payment method nonce here
//             var nonceFromTheClient = req.body.paymentMethodNonce;
//             // Create a new transaction for $10
//             var newTransaction = gateway.transaction.sale(
//                 {
//                     amount: req.body.amount,
//                     paymentMethodNonce: nonceFromTheClient,
//                     options: {
//                         // This option requests the funds from the transaction once it has been
//                         // authorized successfully
//                         submitForSettlement: true,
//                     },
//                 },
//                 function (error, result) {
//                     if (result) {
//                         res.send(result);
//                     } else {
//                         res.status(500).send(error);
//                     }
//                 }
//             );
//         } catch (err) {
//             // Deal with an error
//             console.log(err);
//             res.send(err);
//         }

//     }
// }