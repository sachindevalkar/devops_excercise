const express = require('express');
const { Pool } = require('pg');  // PostgreSQL client

const app = express();
const port = 3000;

// Create a new PostgreSQL pool with environment variables
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: 5432,
});

// Test the database connection
pool.connect()
  .then(client => {
    console.log("Connected to PostgreSQL database successfully!");
    client.release();
  })
  .catch(err => console.error('Database connection error:', err));

// Simple API route
app.get('/', (req, res) => {
  res.send('Hello from the backend API!');
});

app.listen(port, () => {
  console.log(`Backend API running at http://localhost:${port}`);
});

