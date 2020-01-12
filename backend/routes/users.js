import { database } from "../app";
import express from "express";

const router = express.Router();

const userDB = "Users", userCollection = "Users";
const plantDB = "Plants", plantCollection = "PlantCollection";

/**
 * POST /api/users/
 * 
 * @param {string} username - the user's username
 * @param {string} password - the user's password
 * @param {string} requestType - should be either one of "login" or "register"
 * 
 * @returns (201) message - user creation was successful
 */
router.post("/", function(req, res, next) {
  const { username, password, requestType } = req.body;

  if (username === undefined || password === undefined) {
    res.status(422).send({ error: "Username or password must be specified" });
  } else {
    if (requestType === "login") {
      doesUserExist(username, password)
        .then(userExists => {
          if (userExists) {
            res.status(200).send({ 
              message: "Successfully logged in!",
              loginSuccess: true,
            });
          } else {
            res.status(200).json({ 
              error: "Could not find a user that matches the given username or password",
              loginSuccess: false,
            });
          }
        })
        .catch((err) => {
          res.status(422).send({ error: err });
        });
    } else if (requestType === "registration") {
      doesUserExist(username, password)
        .then(userExists => {
          if (userExists) {
            res.status(404).send({ error: "A user with the same username already exists"});
          } else {
            database.open(userDB, userCollection)
              .then(userCollection => {
                userCollection.insertOne({ username, password });
                return database.open(plantDB, plantCollection);
              })
              .then(plantCollection => {
                plantCollection.insertOne({ username, plants: [] });
                res.status(201).send({ message: "User was successfully created!" });
              })
              .catch(err => {
                res.status(422).send({ error: err });
              })
          }
        })
        .catch(err => {
          res.status(422).send({ error: err });
        });
    }
  }
})

async function doesUserExist(username, password = "") {
  return database.open(userDB, userCollection)
    .then(collection => {
      const user = { username };
      if (password !== "") {
        user.password = password;
      }
      return collection.find(user);
    })
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
