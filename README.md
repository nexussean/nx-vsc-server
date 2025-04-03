# Code-Server with Go 1.24 and Caddy Reverse Proxy

This repository provides a Docker Compose setup for a customized code-server environment with Go 1.24 installed. It uses Caddy as a reverse proxy to automatically manage HTTPS certificates and proxy traffic to code-server.

## Folder Structure

```
my-code-server/
├── Dockerfile
├── docker-compose.yml
├── .env
├── Caddyfile
└── README.md
```

## Files Overview

- **Dockerfile:**  
  Extends the base image, installs Go 1.24, and optionally configures sudo access.

- **docker-compose.yml:**  
  Orchestrates the code-server and Caddy containers, sets environment variables, and mounts volumes.

- **.env:**  
  Contains environment variables such as the time zone, a bcrypt hashed password, and the workspace directory.  
  **Note:** For security, avoid committing plain text passwords.

- **Caddyfile:**  
  Configures Caddy to reverse proxy requests to code-server and to handle HTTPS with automatic certificate management.  
  For local development, you can use a configuration for `localhost` or use your domain name.

- **README.md:**  
  Provides documentation and instructions for setup.

## Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/my-code-server.git
   cd my-code-server
   ```

2. **Configure Environment Variables:**
   - Edit the `.env` file to set your timezone, hashed password, and workspace directory.
   - For the password, generate a bcrypt hash using:
     ```bash
     htpasswd -bnBC 10 "" yourpassword | tr -d ':\n'
     ```
   - Replace `YOUR_HASHED_PASSWORD_HERE` with your generated hash.

3. **Update the Caddyfile:**
   - Replace `example.com` with your domain name if deploying publicly.
   - For local development, you might use:
     ```caddyfile
     localhost:80 {
         reverse_proxy code-server:8080
     }
     ```
   - For local HTTPS testing with Caddy’s internal TLS:
     ```caddyfile
     localhost {
         tls internal
         reverse_proxy code-server:8080
     }
     ```

4. **Start the Containers:**
   Build and run the containers using Docker Compose:
   ```bash
   docker-compose up --build
   ```

5. **Accessing Code-Server:**
   - Navigate to `https://example.com` (or your configured domain/localhost) in your browser.
   - Log in using the password you set (the password is stored as a bcrypt hash).

## Additional Recommendations

- **Security:**  
  Consider using Docker secrets or another secure method for managing sensitive data.
  
- **Data Persistence:**  
  Ensure that your configuration and workspace data persist across container restarts by using the defined volumes. Optionally, persist Caddy certificate data by uncommenting the relevant volumes in `docker-compose.yml`.

- **Monitoring & Updates:**  
  Regularly update your images and monitor access to your service for enhanced security.

Enjoy your secure, automated, and containerized development environment!
