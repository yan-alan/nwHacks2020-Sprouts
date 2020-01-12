import { database } from "../app";
import express from "express";

const router = express.Router();

/* GET home page. */
router.get("/", function(req, res, next) {
  const { username, password } = req.body;

  if (username === undefined || password === undefined) {
    res.status(422).send({ error: "Username or password must be specified"});
  } else {
    database.open("Plants", "PlantCollection")
    .then(collection => collection.find({ username, password }))
    .then(cursor => cursor.count())
    .then(count => {
      if (count) {
        res.status(201).json({ message: "Successfully logged in!" }).send();
      } else {
        res.status(201).json({ error: "Could not find a user that matches the given username or password!" });
      }
    })
    .catch((err) => {
      res.status(422).send({ error: err });
    });
  }
});

export { router }; 
