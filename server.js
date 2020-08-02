require('dotenv').config()
const express = require('express')
const mongoose = require('mongoose')

const app = express()
const port = 3000

console.log('DB_URL: ', process.env.DB_URL)
mongoose.connect(process.env.DB_URL, { useNewUrlParser: true , useUnifiedTopology: true })
const db = mongoose.connection
db.on('error', (error) => console.error('Error: ' + error))
db.once('open', () => console.log('Connected to DB ' ))

app.use(express.json())

const personRoutes = require('./routes/processPerson')
app.use('/Person', personRoutes)

//app.get('/', (req, res) => res.send('Hello World!'))
app.listen(port, () => console.log(`App listening on port port 3000!`))