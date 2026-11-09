const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 8080;
const DB_HOST = process.env.DB_HOST || 'localhost';

app.use(cors());
app.use(express.json());

app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'UP',
    timestamp: new Date().toISOString(),
    service: 'ai-ecommerce-core',
    db_connected: true
  });
});

app.get('/api/products', (req, res) => {
  res.json([
    { id: 1, name: 'Cloud Native T-Shirt', price: 29.99, stock: 120 },
    { id: 2, name: 'DevOps Automation Mug', price: 14.50, stock: 75 },
    { id: 3, name: 'Kubernetes Cluster Cap', price: 22.00, stock: 40 }
  ]);
});

app.get('/', (req, res) => {
  res.send('<h1>AI-Powered E-Commerce Platform Online</h1>');
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`E-Commerce Core Service listening on port ${PORT}`);
  console.log(`Configured Database Target: ${DB_HOST}`);
});
