// The Cloud Functions for Firebase SDK to create Cloud Functions and triggers.
// const { logger } = require("firebase-functions");
const { onRequest } = require("firebase-functions/v2/https");
const functions = require('firebase-functions');
// const { onDocumentCreated } = require("firebase-functions/v2/firestore");

// The Firebase Admin SDK to access Firestore.
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");

// allows requests from any origin
// TODO: modify this to restrict to only your frontend!
const cors = require('cors')({ origin: true });

const GOOGLE_MAPS_API_KEY = 'AIzaSyBe5P6opkX-XLi4GNKbFTXGcyUB6UtTnyo';

initializeApp();

// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
// ... existing imports ...

// exports.getLenderStatus = onRequest(async (req, res) => {
//     // Wrap the function in CORS middleware
//     return cors(req, res, async () => {
//         try {
//             const response = await getFirestore().collection('users').doc(req.query.uid).collection('lenders').get();
//             res.status(200).json({ result: 'Lender status fetched successfully' });
//             res.json()
//         } catch (error) {
//             console.error('Error:', error);
//             res.status(500).json({ error: 'Internal Server Error' });
//         }
//     });
// });

exports.addUserDetails = onRequest(async (req, res) => {
    // Wrap the function in CORS middleware
    return cors(req, res, async () => {
        try {
            if (req.method !== 'POST') {
                res.status(405).send('Method Not Allowed - Please use POST');
                return;
            }

            if (!req.body) {
                res.status(400).send("Request body is required");
                return;
            }

            const userInfoAndPreferences = req.body;
            const writeResult = await getFirestore()
                .collection("users")
                .add(userInfoAndPreferences);

            res.status(200).json({ result: `User with ID: ${writeResult.id} added.` });
        } catch (error) {
            console.error('Error:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    });
});

// req conatins information about the incoming HTTP request (query params, body, etc)
// res is the response object that we can use to send a response back to the client
exports.placeAutocomplete = functions.https.onRequest(async (req, res) => {
    // cors (cross origin resource sharing) allows web pages in one domain to request 
    // and interact with resources in another domain
    cors(req, res, async () => {
        try {
            const { input } = req.query;
            const url = `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${input}&key=${GOOGLE_MAPS_API_KEY}&components=country:us`;
            const response = await fetch(url); // makes a request to the google maps api
            const data = await response.json(); // parses the response as json
            res.json(data); // sends the json response back to the client
        } catch (error) {
            console.error('Error:', error);
            response.status(500).json({ error: error.message });
        }
    });
});