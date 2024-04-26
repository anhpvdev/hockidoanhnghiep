const express = require("express");
const path = require("path");

const handlebars = require("express-handlebars")


const config = (app) => {
  app.use( express.urlencoded({ extended: true }));
  app.use(express.json());
  
  // setup views for server using handlebars template
  app.engine("handlebars", handlebars.engine);
  app.set("view engine", "handlebars");
  app.set("views", [
    path.join(__dirname, "../resources/views/user")
    // path.join(__dirname, "../resources/views/admin"),
    // path.join(__dirname, "../resources/views/commics"),
    // path.join(__dirname, "../resources/views/api-ajax")
  ]);

  // set static public folder
  app.use("/public", express.static(path.join(__dirname, "../public")));

  // setup session and cookie storage
  // const session = require("express-session");
  // app.use(
  //   session({
  //     secret: process.env.SECRET || "keyboard cat",
  //     resave: false,
  //     saveUninitialized: false,
  //     cookie: { maxAge: 60000, secure: false },
  //   })
  // );

};

module.exports = config;
