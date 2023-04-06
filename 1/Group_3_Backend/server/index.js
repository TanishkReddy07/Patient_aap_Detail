const express = require('express');
const MongoClient = require('mongodb').MongoClient;


const app = express();
const port = 3000;

//const url = 'mongodb+srv://nodjs:Nodejs@nodejs1.ubyhmwp.mongodb.net';
const url ='mongodb+srv://tanishkreddy97:d0r2blfW8cGrvSyk@cluster0.zogrv6e.mongodb.net/test';
const dbName = 'nodjs';
const collectionName = 'pdm';

app.use(express.json());

app.get('/register', (req, res) => {
    MongoClient.connect(url, function (err, client) {
        if (err) throw err;
        const db = client.db(dbName);
        const collection = db.collection(collectionName);
        collection.find({}).toArray(function (err, data) {
            if (err) throw err;
            res.send(data);
            client.close();
        });
    });
});

app.post('/register', async (req, res) => {
    const { username, age, room, diagnosis, bloodPressure, respiratoryRate, bloodOxygen, heartRate } = req.body;

    try {
        const client = await MongoClient.connect(url);
        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        const existingUser = await collection.findOne({ username });
        if (existingUser) {
            res.status(400).send({ message: 'Username already taken' });
        } else {
           // const hashedPassword = await bcrypt.hash(password, 10);
            await collection.insertOne({ username, age,room,diagnosis });
            res.status(200).send({ message: 'User registered successfully' });
        }

        client.close();
    } catch (error) {
        res.status(500).send({ message: 'Internal server error' });
    }
});
app.post('/patient', async (req, res) => {
    const username = req.body.username;
   
    const result = await collection.findOne({ 'username': username});
    if (result === null) {
        res.status(401).json({ message: 'Invalid credentials' });
    } else {
        res.json({ message: 'Login successful' });
    }
});

// app.post('/register', async (req, res) => {
//     const { username, age, room, diagnosis, bloodPressure, repiratoryRate, bloodOxygen, heartRate } = req.body;

//     try {
//         const client = await MongoClient.connect(url);
//         const db = client.db(dbName);
//         const collection = db.collection(collectionName);

//         const existingUser = await collection.findOne({ username });
//         if (existingUser) {
//             res.status(400).send({ message: 'Username already taken' });
//         } else {
//             // const hashedPassword = await bcrypt.hash(password, 10);
//             await collection.insertOne({ username, age, room, diagnosis });
//             res.status(200).send({ message: 'User registered successfully' });
//         }

//         client.close();
//     } catch (error) {
//         res.status(500).send({ message: 'Internal server error' });
//     }
// });
app.post('/registerdata', async (req, res) => {
    const { username, age, room, diagnosis, bloodPressure, repiratoryRate, bloodOxygen, heartRate } = req.body;

    try {
        const client = await MongoClient.connect(url);
        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        const existingUser = await collection.findOne({ username, bloodPressure,heartRate });
        if (existingUser) {
            res.status(400).send({ message: 'Username already taken' });
        } else {
            // const hashedPassword = await bcrypt.hash(password, 10);
            await collection.insertOne({ username, bloodPressuree, repiratoryRate, bloodOxygen, heartRate });
            res.status(200).send({ message: 'User registered successfully' });
        }

        client.close();
    } catch (error) {
        res.status(500).send({ message: 'Internal server error' });
    }
});

app.listen(port, () => {
    console.log(`API listening at http://localhost:${port}`);
});
