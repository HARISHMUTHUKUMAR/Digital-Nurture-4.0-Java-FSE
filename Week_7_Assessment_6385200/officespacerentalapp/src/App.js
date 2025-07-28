import React from 'react';
import './App.css';

function App() {
  const heading = <h1 style={{ textAlign: 'center' }}>Office Space Rental App</h1>;

  // ✅ Fully working image (no download, direct load)
  const image = (
    <img
      src="https://images.pexels.com/photos/380769/pexels-photo-380769.jpeg
"
      alt="Office Space"
      className="office-image"
      style={{
        display: 'block',
        margin: '20px auto',
        width: '100%',
        maxWidth: '600px',
        borderRadius: '12px',
        boxShadow: '0 0 6px rgba(0, 0, 0, 0.15)'
      }}
    />
  );

  const office = {
    name: 'Tech Park HQ',
    rent: 75000,
    address: '123 Main Street, Bangalore'
  };

  const officeList = [
    { name: 'StartHub', rent: 55000, address: 'MG Road, Bangalore' },
    { name: 'CloudWorks', rent: 68000, address: 'Whitefield, Bangalore' },
    { name: 'OfficeBay', rent: 45000, address: 'Koramangala, Bangalore' },
    { name: 'NextSpace', rent: 72000, address: 'Indiranagar, Bangalore' }
  ];

  const getRentStyle = (rent) => {
    return {
      color: rent < 60000 ? 'red' : 'green',
      fontWeight: 'bold'
    };
  };

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      {heading}
      {image}

      <h2>Featured Office</h2>
      <p><strong>Name:</strong> {office.name}</p>
      <p><strong>Address:</strong> {office.address}</p>
      <p>
        <strong>Rent:</strong>{' '}
        <span style={getRentStyle(office.rent)}>{office.rent}</span>
      </p>

      <h2>Available Office Spaces</h2>
      {officeList.map((off, index) => (
        <div key={index} style={{ marginBottom: '15px', borderBottom: '1px solid #ccc' }}>
          <p><strong>Name:</strong> {off.name}</p>
          <p><strong>Address:</strong> {off.address}</p>
          <p>
            <strong>Rent:</strong>{' '}
            <span style={getRentStyle(off.rent)}>{off.rent}</span>
          </p>
        </div>
      ))}
    </div>
  );
}

export default App;
