const express = require('express')
const router = express.Router()
const Person = require('../model/Person')
//const Person = require('../model/Person')

// Get All
router.get('/', async (req, res) => {
//res.send('Hai')
try {
    const persons = await Person.find()
    res.json(persons)
} catch (error) {
    res.status(500).json({message: error.message})
}
})
// Get one
router.get('/:id', getPerson, (req, res) => {
    //res.send(req.params.name)
    //console.log('get by id: ',res.person);
    
    res.send('The name is '+res.person.name)
})

// Create One
router.post('/', async (req, res) => {

    const personOb = new Person({
        "name": req.body.name, 
        "nickName": req.body.nickName,
        "gender": req.body.gender,
        "occupation": req.body.occupation,
        "company": req.body.company,    
        "address": req.body.addr
    });
    console.log(' req.body: ', req.body);
    console.log(' name: ', req.body.name);
    console.log('Person: ', personOb);
try {
    const newPerson = await personOb.save()
    res.status(201).json(newPerson)
} catch (error) {
    res.status(400).json({message: error.message})
}
})

// Update One
router.patch('/:id',(req, res) => {

})

// Delete One
router.delete('/:id',(req, res) => {

})

async function getPerson(req, res, next) {
    let per
    try {
        per = await Person.findById(req.params.id)
        if(per == null) {
            return res.status(404).json({
                meassge: 'No document exist for the specified id '
                + req.params.id
            })
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({meassge: error.meassge})
        
    }
    console.log('Person: <> ',per)
    res.person = per;
    next();
}

module.exports = router