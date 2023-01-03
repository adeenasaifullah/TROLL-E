const nodemailer = require("nodemailer");

const sendEmail = async (email, subject, text) => {
    try {
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            type: 'SMTP',
            host: 'smtp.gmail.com',
            port: 587,
            ignoreTLS: false,
            secure: false,
            auth: {
                user: 'trolle.services@gmail.com',
                pass: 'igcabhlwfsdhvsjo',
            },
        });

        await transporter.sendMail({
            from: 'trolle.services@gmail.com',
            to: email,
            subject: subject,
            text: text,
        });

        console.log("email sent sucessfully");
    } catch (error) {
        console.log(error, "email not sent");
    }
};

module.exports = sendEmail;