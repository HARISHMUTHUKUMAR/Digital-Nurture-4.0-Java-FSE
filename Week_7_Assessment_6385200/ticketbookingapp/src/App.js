import React, { useState } from 'react';
import GuestPage from './GuestPage';
import UserPage from './UserPage';
import './App.css';

function App() {
  const [isLoggedIn, setIsLoggedIn] = useState(false);

  const toggleLogin = () => {
    setIsLoggedIn(prev => !prev);
  };
  
  let page;
  if (isLoggedIn) {
    page = <UserPage />;
  } else {
    page = <GuestPage />;
  }

  return (
    <div className="App">
      <h1>✈️ Ticket Booking App</h1>
      <button onClick={toggleLogin}>
        {isLoggedIn ? 'Logout' : 'Login'}
      </button>
      <hr />
      {page}
    </div>
  );
}

export default App;
