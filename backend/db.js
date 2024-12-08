const sql = require('mssql');

// Configuration for SQL Server
const config = {
    user: 'admin',                  // SQL Server username
    password: 'admin',              // SQL Server password
   server: 'CRAZY\\SQLEXPRESS', 
    database: 'TravelManagementdb', // Database name
    options: {
        encrypt: false,             // Set to false for local SQL Server
        trustServerCertificate: true // Required for self-signed certificates
    }
};

// Create a connection pool and establish the connection
const pool = new sql.ConnectionPool(config);
const poolConnect = pool.connect(); // Establish the connection

// Test the database connection
poolConnect.then(() => {
    console.log('Database connected successfully!');
}).catch((err) => {
    console.error('Database connection failed:', err.message);
});

// Export the pool and sql module
module.exports = { pool, poolConnect, sql };
