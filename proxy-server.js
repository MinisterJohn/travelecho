const express = require('express');
const cors = require('cors');
const axios = require('axios');
const app = express();

app.use(cors());
app.use(express.json());

const AMADEUS_API_URL = 'https://test.api.amadeus.com/v2';

app.get('/api/*', async (req, res) => {
    try {
      const targetUrl = req.originalUrl.replace(/^\/api/, '');
      const response = await axios.get(`${AMADEUS_API_URL}${targetUrl}`, {
        headers: {
          'Authorization': req.headers.authorization,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      res.json(response.data);
    } catch (error) {
      res.status(error.response?.status || 500).json(error.response?.data || { error: 'Internal server error' });
    }
  });
  
app.post('/api/*', async (req, res) => {
    try {
      const targetUrl = req.originalUrl.replace(/^\/api/, '');
      const response = await axios.post(`${AMADEUS_API_URL}${targetUrl}`, req.body, {
        headers: {
          'Authorization': req.headers.authorization,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }
      });
      res.json(response.data);
    } catch (error) {
      res.status(error.response?.status || 500).json(error.response?.data || { error: 'Internal server error' });
    }
  });
  

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Proxy server running on port ${PORT}`);
});