import React, { useEffect, useState } from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
  const [dbVersion, setDbVersion] = useState('Loading...');
  const [error, setError] = useState(null);

  useEffect(() => {
    // Fetch the database version from the backend API
    fetch('/api') // This will be proxied by Nginx or during development by `proxy.js`
      .then(response => response.json())
      .then(data => {
        setDbVersion(data.message);
      })
      .catch(err => {
        setError('Failed to fetch database version.');
        console.error('Error fetching database version:', err);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <p>
          Database Version: {error ? error : dbVersion}
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default App;
