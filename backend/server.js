const express = require('express');
const bcrypt = require('bcrypt');
const { pool, poolConnect, sql } = require('./db');

const app = express();
app.use(express.json());

// Login endpoint
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  // Ensure email and password are provided
  if (!email || !password) {
    return res.status(400).json({ error: 'Email and password are required' });
  }

  try {
    await poolConnect; // Ensure the pool is connected
    const request = new sql.Request(pool);

    // Query to find the user by email
    const query = 'SELECT * FROM Users WHERE email = @Email';
    request.input('Email', sql.VarChar, email);

    // Execute the query and get the result
    const result = await request.query(query);

    // If no user found, return an error
    if (result.recordset.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    // Get the user from the result
    const user = result.recordset[0];

    // Logging the retrieved user data for debugging
    console.log('User from DB:', user);

    // Check if the password matches the hash stored in the database
    console.log('Password from request:', password);
    console.log('Stored hash from DB:', user.passwordHash); // Use correct field name

    const isMatch = await bcrypt.compare(password, user.passwordHash); // Compare password with passwordHash

    console.log('Password match result:', isMatch);  // This will tell us if the comparison worked

    // If password matches, return success
    if (isMatch) {
      return res.json({
        success: true,
        message: 'Login successful',
        user: {
          userID: user.userID,
          email: user.email,
          userName: user.userName,
        },
      });
    } else {
      // If password doesn't match
      return res.status(401).json({ error: 'Invalid password' });
    }
  } catch (error) {
    // Catch any errors during the process
    console.error('Error during login:', error.message);  // Log error message
    return res.status(500).json({
      error: 'Error during login',
      details: error.message,
    });
  }
});
// Fetch movies route
app.get('/movies', async (req, res) => {
  try {
    await poolConnect; // Ensure the pool is connected
    const request = new sql.Request(pool); // Use the pool connection to create a request
    const result = await request.query('SELECT * FROM Movies'); // Replace with your actual query
    res.json(result.recordset); // Send the fetched data as JSON
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching movies',
      details: err.message,
    });
  }
});

// Fetch airline tickets route
app.get('/airline_tickets', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM AirTickets');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching airline tickets',
      details: err.message,
    });
  }
});

// Fetch bus tickets route
app.get('/bus_tickets', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM Buses');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching bus tickets',
      details: err.message,
    });
  }
});

// Fetch event tickets route
app.get('/event_tickets', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM Events');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching event tickets',
      details: err.message,
    });
  }
});

// Fetch tour tickets route
app.get('/tour_tickets', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM Tours');
    res.json(result.recordset);
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching tour tickets',
      details: err.message,
    });
  }
});
//////////////////////////////////////////////////////////////////////
// Fetch car rental tickets route
app.get('/cars', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM CarsTable');
    res.json(result.recordset); // Return all car details from CarsTable
  } catch (err) {
    res.status(500).send({
      error: 'Error fetching cars',
      details: err.message,
    });
  }
});

// Add a new car
app.post('/book_car', async (req, res) => {
  const { title, link, price, image_link } = req.body;

  // Ensure required fields are provided
  if (!title || !price || !image_link) {
    return res.status(400).json({ error: 'Title, Price, and Image Link are required' });
  }

  try {
    await poolConnect;
    const request = new sql.Request(pool);

    // Insert the new car into the CarsTable
    const insertQuery = `
      INSERT INTO CarsTable (title, link, price, image_link)
      VALUES (@Title, @Link, @Price, @ImageLink);
    `;
    request.input('Title', sql.NVarChar, title);
    request.input('Link', sql.NVarChar, link);
    request.input('Price', sql.Int, price);
    request.input('ImageLink', sql.NVarChar, image_link);

    await request.query(insertQuery);

    return res.status(201).json({ success: true, message: 'Car added successfully' });
  } catch (error) {
    console.error('Error adding car:', error);
    return res.status(500).json({ error: 'Error adding car', details: error.message });
  }
});


// View all car bookings
app.get('/car_bookings', async (req, res) => {
  try {
    await poolConnect;
    const request = new sql.Request(pool);
    const result = await request.query('SELECT * FROM CarsTickets');
    res.json(result.recordset); // Return all car bookings
  } catch (err) {
    res.status(500).send({ error: 'Error fetching car bookings', details: err.message });
  }
});
//cancel bookings
app.delete('/cancel_booking/:bookingID', async (req, res) => {
  const { bookingID } = req.params;

  try {
    await poolConnect;
    const request = new sql.Request(pool);

    // Input should come before the query
    request.input('ticketID', sql.Int, bookingID);
    const result = await request.query('DELETE FROM CarsTickets WHERE ticketID = @ticketID');

    if (result.rowsAffected[0] > 0) {
      return res.status(200).json({ success: true, message: 'Booking canceled successfully' });
    } else {
      return res.status(404).json({ error: 'Booking not found' });
    }
  } catch (err) {
    res.status(500).send({ error: 'Error canceling booking', details: err.message });
  } 
});



/////////////////////////////////////////////////////////////////////////////
app.get('/searchBuses', async (req, res) => {
  const { departure, arrival } = req.query;
  try {
    let pool = await sql.connect(dbConfig);
    const result = await pool.request()
      .input('departure', sql.NVarChar, departure)
      .input('arrival', sql.NVarChar, arrival)
      .query('SELECT * FROM Buses WHERE departureLocation = @departure AND arrivalLocation = @arrival AND seatsAvailable > 0');
    res.status(200).json(result.recordset);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error searching buses');
  }
});

// Book ticket
app.post('/bookTicket', async (req, res) => {
  const { busID, userID, ticketType, travelDate, no_Passengers } = req.body;
  try {
    let pool = await sql.connect(dbConfig);
    // Reduce seats available
    await pool.request()
      .input('busID', sql.Int, busID)
      .input('no_Passengers', sql.Int, no_Passengers)
      .query('UPDATE Buses SET seatsAvailable = seatsAvailable - @no_Passengers WHERE busID = @busID');

    // Insert into BusTickets
    await pool.request()
      .input('busID', sql.Int, busID)
      .input('userID', sql.Int, userID)
      .input('ticketType', sql.NVarChar, ticketType)
      .input('travelDate', sql.Date, travelDate)
      .input('no_Passengers', sql.Int, no_Passengers)
      .query('INSERT INTO BusTickets (busID, userID, ticketType, travelDate, no_Passengers) VALUES (@busID, @userID, @ticketType, @travelDate, @no_Passengers)');
    
    res.status(200).send('Ticket booked successfully');
  } catch (err) {
    console.error(err);
    res.status(500).send('Error booking ticket');
  }
});

////////////////////////////////////////////////////////////////////////////////////////////
// Sign-Up endpoint
app.post('/signup', async (req, res) => {
  const { userName, email, password } = req.body;

  // Ensure all required fields are provided
  if (!userName || !email || !password) {
    return res.status(400).json({ error: 'All fields (user name, email, password) are required' });
  }

  try {
    await poolConnect; // Ensure the pool is connected
    const request = new sql.Request(pool);

    // Check if the email is already taken
    request.input('Email', sql.VarChar, email); // Declare the 'Email' parameter once

    const checkEmailQuery = 'SELECT * FROM Users WHERE email = @Email';
    const emailCheckResult = await request.query(checkEmailQuery);

    if (emailCheckResult.recordset.length > 0) {
      return res.status(400).json({ error: 'Email is already taken' });
    }

    // Hash the password before saving it to the database
    const hashedPassword = await bcrypt.hash(password, 10);

    // Insert the new user into the database
    const insertQuery = `
      INSERT INTO Users (userName, email, passwordHash)
      VALUES (@UserName, @Email, @PasswordHash);
    `;
    request.input('UserName', sql.NVarChar, userName);  // Declare 'userName' parameter
    request.input('PasswordHash', sql.NVarChar, hashedPassword);  // Declare 'PasswordHash'

    await request.query(insertQuery);

    return res.status(201).json({ success: true, message: 'User registered successfully' });
  } catch (error) {
    console.error('Error during sign-up:', error.message);
    return res.status(500).json({
      error: 'Error during sign-up',
      details: error.message,
    });
  }
});
const nodemailer = require('nodemailer');

// Forgot Password endpoint
app.post('/forgot-password', async (req, res) => {
  const { email } = req.body;

  // Ensure email is provided
  if (!email) {
    return res.status(400).json({ error: 'Email is required' });
  }

  try {
    await poolConnect;
    const request = new sql.Request(pool);

    // Check if the user exists
    request.input('Email', sql.VarChar, email);
    const query = 'SELECT * FROM Users WHERE email = @Email';
    const result = await request.query(query);

    if (result.recordset.length === 0) {
      return res.status(404).json({ error: 'No account found with this email.' });
    }

    const user = result.recordset[0];

    // Generate a reset token (e.g., a random string or JWT)
    const resetToken = Math.random().toString(36).substr(2); // Simple example; use secure methods for production

    // Store the reset token and expiration time in the database
    const expiryTime = new Date(Date.now() + 60 * 60 * 1000); // Token valid for 1 hour
    const updateQuery = `
      UPDATE Users SET resetToken = @ResetToken, resetTokenExpiry = @ExpiryTime
      WHERE email = @Email
    `;
    request.input('ResetToken', sql.VarChar, resetToken);
    request.input('ExpiryTime', sql.DateTime, expiryTime);
    await request.query(updateQuery);

    // Send the reset email
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'your-email@gmail.com', // Replace with your email
        pass: 'your-email-password', // Replace with your password
      },
    });

    const mailOptions = {
      from: 'your-email@gmail.com',
      to: email,
      subject: 'Password Reset Request',
      html: `
        <p>Hello ${user.userName},</p>
        <p>You requested to reset your password. Click the link below to reset it:</p>
        <a href="http://localhost:7000/reset-password/${resetToken}">Reset Password</a>
        <p>If you didn't request this, please ignore this email.</p>
      `,
    };

    await transporter.sendMail(mailOptions);

    res.status(200).json({ success: true, message: 'Password reset instructions sent to your email.' });
  } catch (error) {
    console.error('Error during forgot password:', error.message);
    res.status(500).json({ error: 'An error occurred. Please try again later.' });
  }
});


app.listen(7000, () => {
  console.log('Server is running on http://localhost:7000');
});

