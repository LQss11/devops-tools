import React, { useEffect, useState } from 'react';
import './UsersPage.css'; // Optional: Add styles for the UsersPage component

function UsersPage() {
  const [users, setUsers] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    // Fetch the list of users from the backend API
    fetch('/api/examples/users')
      .then(response => response.json())
      .then(data => {
        setUsers(data);
      })
      .catch(err => {
        setError('Failed to fetch users.');
        console.error('Error fetching users:', err);
      });
  }, []);

  return (
    <div className="UsersPage">
      <h1>User List</h1>
      {error && <p>{error}</p>}
      {users.length > 0 ? (
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Name</th>
              <th>Email</th>
              <th>Age</th>
            </tr>
          </thead>
          <tbody>
            {users.map(user => (
              <tr key={user.id}>
                <td>{user.id}</td>
                <td>{user.name}</td>
                <td>{user.email}</td>
                <td>{user.age}</td>
              </tr>
            ))}
          </tbody>
        </table>
      ) : (
        <p>No users found.</p>
      )}
    </div>
  );
}

export default UsersPage;
