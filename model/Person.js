const mongoose = require('mongoose')

const personSchema = new mongoose.Schema({
    "name":  {type: String, required: true}, 
    "nickName": {type: String, required: true},
    "gender": {type: String},
    "occupation": {type: String},
    "company": {type: String},    
    "address": {type: String}
})

module.exports = mongoose.model('Person', personSchema)