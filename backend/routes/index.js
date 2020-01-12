import { database } from "../app";
import express from "express";

const router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  const { username } = req;

  database.open("Plants", "PlantCollection")
    .then((collection) => {
      collection.insertOne({ username: username });
      res.json({ message: "Success!" });
    })
    .catch((err) => {
      res.status(422).send({ error: err });
    })
});

export { router }; 
