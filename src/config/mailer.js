require("dotenv").config()
const nodemailer = require('nodemailer')


const MailService = async (email,content)=>{
  const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 587,
    secure: false, // Use `true` for port 465, `false` for all other ports
    auth: {
      user: process.env.EMAIL_NAME,
      pass: process.env.EMAIL_PASS,
    },
  });

  let info = await transporter.sendMail({
    from: '"Shopbee 👻" <fosher50@gmail.com>', // sender address
    to: email, // list of receivers
    subject: "Hello ✔", // Subject line
    text: "", // plain text body
    html: content, // html body
  });
  return info
}
module.exports = MailService
