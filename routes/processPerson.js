const express = require('express')
const router = express.Router()
const Person = require('../model/Person')
const { json } = require('express')
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
router.get('/:id', getPerson, async (req, res) => {
    //res.send(req.params.name)
    //console.log('get by id: ',res.person);
    res.json(res.person)
    //res.send('The name is '+res.person.name)
})

// Get by TextSearch
router.get('/search/:searchText', async (req, res) => {
    //res.send('Hai')
    try {
        // { $or: [{ name: { $regex: "tani", $options: "si" } } ]}
        // { $or: [{ name: /tan/i }, { nickName: /tan/i } ] }
        console.log('Search text: '+req.params.searchText);
        // const persons = await Person.find({ $text: { $search: req.params.searchText } })
        // const persons = await Person.find( { $or: [{ name: /${req.params.searchText}/i }, { nickName: /${req.params.searchText}/i } ] })
        const persons = await Person.find( { $or: [
            { name: {$regex : req.params.searchText, $options : "i" }}, 
            { nickName: {$regex : req.params.searchText, $options : "i" }} 
        ] })
        res.json(persons)
    } catch (error) {
        res.status(500).json({message: error.message})
    }
})

// Create One
router.post('/', async (req, res) => {

    const personOb = new Person({
        "name": req.body.name, 
        "nickName": req.body.nickName,
        "gender": req.body.gender,
        "occupation": req.body.occupation,
        "company": req.body.company,    
        "address": req.body.address,
        "dob": req.body.dob,
        "image": req.body.image,
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
router.patch('/:id',getPerson, async (req, res) => {
    if(req.body.name != null) {
        res.person.name = req.body.name;
    }
    if(req.body.nickName != null) {
        res.person.nickName = req.body.nickName;
    }
    if(req.body.address != null) {
        res.person.address = req.body.address;
    }
    if(req.body.dob != null) {
        res.person.dob = req.body.dob;
    }
    if(req.body.company != null) {
        res.person.company = req.body.company;
    }
    if(req.body.occupation != null) {
        res.person.occupation = req.body.occupation;
    }
    if(req.body.image != null) {
        res.person.image = req.body.image;
    }
    try {
        const updatedMember = await res.person.save();
        res.statusCode(200).json(updatedMember);
    } catch (err) {
        console.error(error);
        return res.status(400).json({meassge: error.meassge})
    }
})

// Delete One
router.delete('/:id', getPerson, async (req, res) => {
    try{
        await res.person.remove();
        res.status(200).json({message : "Deleted member", id: req.body.id, }) 
    } catch (err) {
        console.error(error);
        return res.status(400).json({meassge: error.meassge})
    }
})

// upload image
// router.use(bodyParser.urlencoded({ extended: true, limit: "50mb" }));
// router.post("/image", function(req, res) {
//   var name = req.body.name;
//   var img = req.body.image;
//   var realFile = Buffer.from(img,"base64");
//   fs.writeFile(name, realFile, function(err) {
//       if(err)
//          console.log(err);
//    });
//    res.send("OK");
//  });

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