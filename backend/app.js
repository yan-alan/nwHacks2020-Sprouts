const express = require('express');
const indexRouter = require('./routes/index');

const app = express();
const port = process.env.PORT || '8000';

app.use(express.json());

app.use('/api/', indexRouter);

app.listen(port);
