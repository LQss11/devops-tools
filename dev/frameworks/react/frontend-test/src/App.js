import React from 'react';
import { BrowserRouter as Router, Route, Routes, Link } from 'react-router-dom';
import logo from './logo.svg';
import './App.css';
import UsersPage from './UsersPage'; // Import the new UsersPage component
import ErrorsPage from './ErrorsPage'; // Import the new ErrorsPage component

function App() {
  return (
    <Router>
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <p>
            Edit <code>src/App.js</code> and save to reload.
          </p>
          <nav>
            <ul>
              <li><Link to="/">Home</Link></li>
              <li><Link to="/users">Users</Link></li>
              <li><Link to="/errors">Errors</Link></li> {/* New link */}
            </ul>
          </nav>
          <Routes>
            <Route path="/" element={<HomePage />} />
            <Route path="/users" element={<UsersPage />} />
            <Route path="/errors" element={<ErrorsPage />} /> {/* New route */}
          </Routes>
        </header>
      </div>
    </Router>
  );
}

function HomePage() {
  const [dbVersion, setDbVersion] = React.useState('Loading...');
  const [error, setError] = React.useState(null);

  React.useEffect(() => {
    fetch('/api')
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
    <div>
      <h1>Home Page</h1>
      <p>Database Version: {error ? error : dbVersion}</p>
    </div>
  );
}

export default App;
