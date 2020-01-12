import { database } from "../app";
import express from "express";

const router = express.Router();

const dbName = "Users";
const collectionName = "Users";

router.get("/", function(req, res, next) {
  const { username, password } = req.body;

  if (username === undefined || password === undefined) {
    res.status(422).send({ error: "Username or password must be specified" });
  } else {
    doesUserExist(username, password)
      .then(userExists => {
        if (userExists) {
          res.status(200).send({ message: "Successfully logged in!" });
        } else {
          res.status(404).json({ error: "Could not find a user that matches the given username or password" });
        }
      })
      .catch((err) => {
        res.status(422).send({ error: err });
      });
  } 
});

router.post("/", function(req, res, next) {
  const { username, password } = req.body;

  if (username === undefined || password === undefined) {
    res.status(422).send({ error: "Username or password must be specified" });
  } else {
    doesUserExist(username, password)
      .then(userExists => {
        if (userExists) {
          res.status(404).send({ error: "A user with the same username already exists"});
        } else {
          return database.open(dbName, collectionName)
            .then(userCollection => {
              userCollection.insertOne({ username, password });
              res.status(201).send({ message: "User was successfully created!" });
            })
            .catch(err => {
              res.status(422).send({ error: err });
            })
        }
      })
      .catch(err => {
        res.status(422).send({ error: err });
      })
  }
})

async function doesUserExist(username, password) {
  return database.open(dbName, collectionName)
    .then(collection => collection.find({ username, password }))
    .then(cursor => cursor.count())
    .then(count => {
      if (count) {
        return true;
      } else {
        return false;
      }
    });
}

export { router }; 
