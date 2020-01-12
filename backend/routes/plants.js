import { database } from "../app";
import express from "express";

const router = express.Router();

const dbName = "Plants";
const collectionName = "PlantCollection";

router.get("/", function(req, res, next) {
    const { username } = req.body;

    database.open(dbName, collectionName)
        .then(collection => collection.findOne({ username }))
        .then(document => res.status(200).send({ plants: document.plants }))
        .catch(err => res.status(404).send({ error: err }));
});

router.post("/", function(req, res, next) {
    const { plant, username } = req.body;

    database.open(dbName, collectionName)
        .then(collection => {
            return collection.updateOne(
                { username: username },
                { $push: { plants: plant } }
            );
        })
        .then(writeResult => {
            if (writeResult.matchedCount > 0) {
                return res.status(200).send({ 
                    message: "Plant was successfully added.", 
                    plant: plant
                });
            } else {
                return res.status(422).send({
                    error: "Could not add plant. Please try again." 
                });
            }
        })
        .catch(err => res.status(404).send({ error: err }));
});

router.put("/", function(req, res, next) {
    const { username, plant } = req.body;

    let plantCollection, newPlants;
    database.open(dbName, collectionName)
        .then(collection => {
            plantCollection = collection;
            return collection.findOne({ username });
        })
        .then(user => {
            newPlants = user.plants.map(element => {
                return element._id === plant._id ? plant : element;
            });
            return plantCollection.updateOne(
                { username: username },
                { $set: { plants: newPlants } }
            );
        })
        .then(writeResult => {
            if (writeResult.matchedCount > 0) {
                return res.status(200).send({
                    message: "Plant was successfully updated.",
                    plants: newPlants
                });
            } else {
                return res.status(422).send({
                    error: "Could not update plant. Please try again." 
                });
            }
        })
        .catch(err => res.status(404).send({ error: err }));
});

router.delete("/", function(req, res, next) {
    const { username, plantId } = req.body;

    let userCollection, plants;
    database.open(dbName, collectionName)
        .then(collection => {
            userCollection = collection;
            return collection.findOne({ username });
        })
        .then(user => {
            plants = user.plants;
            const plantToRemove = plants.find(element => element._id === plantId);
            const indexToRemove = plants.indexOf(plantToRemove);
            if (indexToRemove < 0) {
                return res.status(422).send({
                    error: "No plant matching the given plantId could be found." 
                });
            } 
            plants.splice(indexToRemove, 1);
            return userCollection.replaceOne(
                { username: username }, 
                { user }
            );
        })
        .then(writeResult => {
            if (writeResult.matchedCount > 0) {
                return res.status(200).send({
                    message: "Plant was successfully deleted.",
                    plants: plants
                });
            } else { 
                return res.status(422).send({
                    error: "Could not delete plant. Please try again." 
                });
            }
        })
        .catch(err => res.status(404).send({ error: err }));
});

router.get("/:id", function(req, res, next) {
    const plantId = Number(req.params.id);
    const { username } = req.body;

    database.open(dbName, collectionName)
        .then(collection => collection.findOne({ username }))
        .then(document => document.plants.find(element => element._id ? element._id === plantId : false))
        .then(plant => res.status(200).send({ plant }))
        .catch(err => res.status(404).send({ error: err }));
});

export { router };

