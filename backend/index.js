import http from 'http';
import PG from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const port = Number(process.env.port) || 3001;
const db_port = Number(process.env.db_port) || 5432;
const user = String(process.env.user);
const pass = String(process.env.pass);
const host = String(process.env.host);
const database = String(process.env.database);

const pool = new PG.Pool({
  user: user,
  password: pass,
  host: host,
  port: db_port,
  database: database
});

http.createServer(async (req, res) => {
  console.log(`Request: ${req.url}`);

  if (req.url === "/api") {
    res.setHeader("Content-Type", "application/json");
    res.writeHead(200);

    let result;
    let dbConnected = false;

    try {
      result = (await pool.query("SELECT * FROM users")).rows[0];
      dbConnected = true;
    } catch (error) {
      console.error('Database error:', error);
      dbConnected = false;
    }

    const data = {
      database: dbConnected,
      userAdmin: result?.role === "admin"
    }

    res.end(JSON.stringify(data));
  } else {
    res.writeHead(503);
    res.end("Internal Server Error");
  }

}).listen(port, () => {
  console.log(`Server is listening on port ${port}`);
});