import * as functions from 'firebase-functions';
import axios from 'axios';

interface AddressSuggestionsData {
    input: string;
}

export const getAddressSuggestions = functions.https.onCall(
    async (data: functions.https.CallableRequest<AddressSuggestionsData>, context) => {
        const { data: { input } } = data;

        if (!input) {
            throw new functions.https.HttpsError(
                'invalid-argument',
                'Input parameter is required'
            );
        }

        try {
            const response = await axios.get(
                `https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${encodeURIComponent(input)}&components=country:us&key=${process.env.GOOGLE_PLACES_API_KEY}`
            );

            return response.data;
        } catch (error) {
            throw new functions.https.HttpsError(
                'internal',
                'Error fetching address suggestions',
                error
            );
        }
    }
);