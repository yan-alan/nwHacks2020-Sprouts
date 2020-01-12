import express from "express";
import { Database } from "./database/Database";
import { router as plantRouter } from "./routes/plants";
import { router as userRouter } from "./routes/users";

const app = express();
const port = process.env.PORT || "8000";
const database = new Database();

app.use(express.json());

app.use("/api/users", userRouter);
app.use("/api/plants", plantRouter);

app.listen(port);

export { database };
