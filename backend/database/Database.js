import "dotenv/config";
import { MongoClient } from "mongodb"; 

class Database {
    constructor() {
        this.client = new MongoClient(process.env.MONGO_URI, {useUnifiedTopology: true});
        this.cache = {};
    }

    async open(dbName, collectionName) {
        if (Object.keys(this.cache).length === 0) {
            try {
                this.client = await this.client.connect();
            } catch (err) {
                return Promise.reject(err);
            }
        }

        if (!Object.keys(this.cache).includes(dbName)) {
            this.cache[dbName] = this.client.db(dbName);
        }

        return this.cache[dbName].collection(collectionName);
    }

    async close() {
        if (this.client == null) {
            return Promise.resolve(false);
        } else {
            return this.client.close()
                .then(() => {
                    return Promise.resolve(true);
                })
                .catch((err) => {
                    return Promise.reject(err);
                });
        }
    }
}

export { Database };