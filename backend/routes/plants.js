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
            const nModified = writeResult.result.nModified;
            if (nModified > 0) {
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

});

router.delete("/", function(req, res, next) {
    
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

