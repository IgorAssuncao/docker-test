import express from 'express';

const app = express();

app.get('/', (req, res) => {
  return res.json({ message: 'Hi' })
})

app.listen(3000);
