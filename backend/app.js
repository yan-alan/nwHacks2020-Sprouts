import express from "express";
import { Database } from "./database/Database";
import { router as indexRouter } from "./routes/index";

const app = express();
const port = process.env.PORT || '8000';
const database = new Database();

app.use(express.json());

app.use('/api/', indexRouter);

app.listen(port);

export { database };
