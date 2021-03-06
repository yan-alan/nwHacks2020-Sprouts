import { database } from "../app";
import express from "express";

const router = express.Router();

const dbName = "Plants";
const collectionName = "PlantCollection";

/**
 * GET /api/plants/
 * 
 * If user with matching username exists in database, returns list of plants associated with user.
 * 
 * @param {string} username - the user's username
 * 
 * @returns (200) plants - the array of plants associated with a user
 */
router.get("/:username", function(req, res, next) {
    const username = String(req.params.username);

    database.open(dbName, collectionName)
        .then(collection => collection.findOne({ username }))
        .then(document => res.status(200).send({ plants: document.plants }))
        .catch(err => res.status(404).send({ error: err }));
});

/**
 * POST /api/plants/
 * 
 * If user with matching username exists in database, updates array of plants to now include the plant passed in.
 * 
 * @param {string} username - the user's username
 * @param {Plant} plant - the plant object to record
 * 
 * @returns (201) plant - the plant object that was successfully saved
 */
router.post("/:username", function(req, res, next) {
    const username = String(req.params.username);
    const plant = req.body;

    console.log("POST: " + JSON.stringify(req.body));
    database.open(dbName, collectionName)
        .then(collection => {
            return collection.updateOne(
                { username: username },
                { $push: { plants: plant } }
            );
        })
        .then(writeResult => {
            if (writeResult.matchedCount > 0) {
                return res.status(201).send({ 
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

/**
 * PUT /api/plants
 * 
 * If user with matching username exists in database, finds given plant in the user's list of plants by its id
 * and then replaces the plant with the plant passed in.
 * 
 * @param {string} username - the user's username
 * @param {Plant} plant - the plant object to be modified
 * 
 * @returns (200) plants - the array of plants associated with a user, after modifying the target plant
 */
router.put("/:username", function(req, res, next) {
    const username = String(req.params.username);
    const plant = req.body;

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

/**
 * DELETE /api/plants
 * 
 * If user with matching username exists in database, finds given plant in user's list of plants by its id and then removes the plant.
 * 
 * @param {string} username - the user's username
 * @param {number} plant - the plant to be deleted
 * 
 * @returns (200) plants - the array of plants associated with a user, after deleting the target plant
 */
router.delete("/:username", function(req, res, next) {
    const username = String(req.params.username);
    const plant = req.body;

    let plantCollection, plants;
    database.open(dbName, collectionName)
        .then(collection => {
            plantCollection = collection;
            return collection.findOne({ username });
        })
        .then(user => {
            plants = user.plants;
            const plantToRemove = plants.find(element => element.scientificName === plant.scientificName);
            const indexToRemove = plants.indexOf(plantToRemove);
            if (indexToRemove < 0) {
                return res.status(422).send({
                    error: "No matching plant could be found." 
                });
            } 
            plants.splice(indexToRemove, 1);
            return plantCollection.replaceOne(
                { username: username }, 
                { 
                    username: username,
                    plants: plants,
                }
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

/**
 * GET /api/plants/:id
 * 
 * If user with matching username exists in database, finds given plant in user's list of plants by its id and returns the plant.
 * 
 * @param {string} username - the user's username
 * 
 * @returns (200) plant - the plant object matching the given plantId
 */
router.get("/:username/:id", function(req, res, next) {
    const username = String(req.params.username);
    const plantId = Number(req.params.id);

    database.open(dbName, collectionName)
        .then(collection => collection.findOne({ username }))
        .then(document => document.plants.find(element => element._id ? element._id === plantId : false))
        .then(plant => res.status(200).send({ plant }))
        .catch(err => res.status(404).send({ error: err }));
});

export { router };

