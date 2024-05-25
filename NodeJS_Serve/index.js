// A minimal and flexible Node.js web application framework
const express = require('express');
// Middleware to parse incoming request bodies in a middleware before you handlers, availale under the req.body parser
const bodyParser = require('body-parser');
// Middleware for enabling Cross-Origin Resourse Sharing 
const cors = require('cors');
const { Datastore } = require('@google-cloud/datastore');
const WebSocket = require('ws');

// Initialize Express app and WebSocket server
const app = express();
const wss = new WebSocket.Server({ port: 8081 });

// Initialize Google Cloud Datastore
const datastore = new Datastore({
  projectId: 'test-24-05-24',
  keyFilename:'./service-account-key.json'
});

// Use CORS middleware
app.use(cors());
app.use(bodyParser.json());

// Define a POST route at /data to save incoming data 
// req.body: Contains the parsed JSON data from the clinet 
app.post('/data', async (req, res) => {
  // The data request 
// req.body is used to access the data sent by the client to the request body. 
  const { name, message, article, } = req.body; //access the data sent by the client. 
  // This is from the clients POST request (of course)
  console.log('Received POST request:', req.body);

  // This defines the constant 'entity' object that will be used to represen the data you want to store in Datastore. 
  const entity = {
    // Defines the unique identifier for the Datastore
    // This successfully sent to a new 'Kind' (Like an SQL table); 
    key: datastore.key('Message_Two'),
    data: {
      name,
      message,
      article,
      timestamp: new Date()
    }
  };

  // The server response
  try {
    await datastore.save(entity);
    console.log('Entity saved:', entity);
    res.status(201).send('Entity saved');

    wss.clients.forEach(client => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(JSON.stringify(entity.data));
      }
    });
  } catch (error) {
    console.error('Error saving entity:', error);
    res.status(500).send('Error saving entity');
  }
});
// Message: Kind is SQL table, Entity: Similar to SQL row, Property: SQL column, but can hold a list of value rather than just a single value. 

// app.get: Defines a GET route at '/data' to fetch data 
app.get('/data', async (req, res) => {
  console.log('Received GET request');
  // Creates a query for the 'Message' kind (which is like an SQL table), and order
  const query = datastore.createQuery('Message_Two').order('timestamp', { descending: true });

  try {
    const [messages] = await datastore.runQuery(query);
    console.log('Fetched messages:', messages);
    // response.json(messages)
    res.json(messages);
  } catch (error) {
    console.error('Error fetching messages:', error);
    res.status(500).send('Error fetching messages');
  }
});

// The WebSocket connection 
wss.on('connection', (ws) => {
  console.log('Client connected');
  ws.on('close', () => {
    console.log('Client disconnected');
  });
});

// The NodeJs port 
app.listen(3000, () => {
  console.log('Server listening on port 3000');
});