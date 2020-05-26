// Allows the connect to the SQL Database and give us back a connection object for queries.about-img
const mysql = require('mysql2');

const pool = mysql.createPool({
    host: 'localhost',
    user: 'root',
    database: 'node-complete',
    password: 'r00T$12r00T$12'
});

// Use Promise for Async Data. rather than callbacks
module.exports = pool.promise();