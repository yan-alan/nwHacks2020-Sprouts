import { database } from "../app";
import express from "express";

const router = express.Router();

const userDB = "Users", userCollection = "Users";
const plantDB = "Plants", plantCollection = "PlantCollection";

/**
 * GET /api/users/
 * 
 * If user does not exist in database, returns 404.
 * If user does exist in database with a matching username and password, authenticates user and returns 200.
 * 
 * @param {string} username - the user's username
 * @param {string} password - the user's password
 * 
 * @returns (200) message - login was successful
 */
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

/**
 * POST /api/users/
 * 
 * If user with same username exists in database, returns 404.
 * If user does not exist in database, creates entry for user in userDB and plantDB and returns 201.
 * 
 * @param {string} username - the user's username
 * @param {string} password - the user's password
 * 
 * @returns (201) message - user creation was successful
 */
router.post("/", function(req, res, next) {
  const { username, password } = req.body;

  if (username === undefined || password === undefined) {
    res.status(422).send({ error: "Username or password must be specified" });
  } else {
    doesUserExist(username)
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
      })
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
