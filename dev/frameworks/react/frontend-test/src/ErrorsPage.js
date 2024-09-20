import React from 'react';

function ErrorsPage() {
  const [errorData, setErrorData] = React.useState(null);
  const [error, setError] = React.useState(null);

  React.useEffect(() => {
    fetch('/api/examples/errors/error2')
      .then(response => response.json())
      .then(data => {
        setErrorData(data);
      })
      .catch(err => {
        setError('Failed to fetch error data.');
        console.error('Error fetching error data:', err);
      });
  }, []);

  return (
    <div>
      <h1>Error Page</h1>
      {error ? (
        <p>{error}</p>
      ) : (
        <div>
          <h2>Error Details:</h2>
          {errorData ? (
            <pre>{JSON.stringify(errorData, null, 2)}</pre>
          ) : (
            <p>Loading error details...</p>
          )}
        </div>
      )}
    </div>
  );
}

export default ErrorsPage;
