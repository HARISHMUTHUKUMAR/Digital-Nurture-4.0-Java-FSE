import React from 'react';

const UserPage = () => {
  return (
    <div>
      <h2>User Page</h2>
      <p>Welcome! You can now book your flight tickets.</p>
      <h3>Book Your Flight:</h3>
      <ul>
        <li>Chennai ✈️ Delhi - <button>Book</button></li>
        <li>Mumbai ✈️ Bangalore - <button>Book</button></li>
        <li>Hyderabad ✈️ Kolkata - <button>Book</button></li>
      </ul>
    </div>
  );
};

export default UserPage;
