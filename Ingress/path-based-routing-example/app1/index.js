const express = require('express');
const app = express();
app.get('*', (req, res) => res.send('Hello from App1'));
app.listen(3000);
