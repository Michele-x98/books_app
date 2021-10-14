
import * as functions from "firebase-functions";
import * as nodemailer from 'nodemailer';
import * as admin from "firebase-admin";
import * as config from "./config";
admin.initializeApp()

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript

var transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true,
    auth: {
        user: 'michelebenx98@gmail.com',
        pass: config.googlePsw
    }
});

export const sendEmail = functions.firestore.document('Users/{userId}').onCreate((snap, context) => {
    const mailOptions = {
        from: `michelebenx98@gmail.com`,
        to: snap.data().email,
        subject: 'Welcome to MyBooks App',
        html: `<h1>Welcome to MyBooksApp</h1>
         <p> <b>Your Email: </b>${snap.data().email} </p>`
    };
    return transporter.sendMail(mailOptions, (error, data) => {
        if (error) {
            console.log(error)
            return
        }
        console.log("Sent!")
    });
});

export const sendMailOverHTTP = functions.https.onRequest((req, res) => {
    const mailOptions = {
        from: `michelebenx98@gmail.com`,
        to: req.body.email,
        subject: 'Welcome to MyBooks App',
        html: `<h1>Welcome to MyBooks App</h1>
        <p> <b>Your Email: </b>${req.body.email}<br> </p>`
    };
    return transporter.sendMail(mailOptions, (error, data) => {
        if (error) {
            return res.send(error.toString());
        }
        var datar = JSON.stringify(data)
        return res.send(`Sent! ${datar}`);
    });
});


