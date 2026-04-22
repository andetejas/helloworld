# Hello World App - Azure DevOps Deployment

A simple Node.js Hello World application ready to deploy to Azure using Azure DevOps CI/CD pipelines.

## 📋 Features

- ✅ Simple Express.js Hello World API
- ✅ Health check endpoints (`/health`, `/ready`)
- ✅ Full unit test coverage with Jest
- ✅ Docker containerization
- ✅ Azure DevOps CI/CD pipeline (Build → Dev → Prod)
- ✅ Multi-stage Docker build
- ✅ Non-root user security
- ✅ Graceful shutdown handling
- ✅ Request logging with Morgan
- ✅ CORS and security headers (Helmet)

## 🚀 Quick Start (Local)

### Prerequisites
- Node.js 18+ installed
- npm or yarn
- Docker (optional, for containerized deployment)

### Installation

```bash
# Install dependencies
npm install

# Run app locally
npm start

# Run tests
npm test

# Run in development mode with auto-reload
npm run dev
```

Visit `http://localhost:3000` in your browser.

### API Endpoints

#### `GET /`
Returns greeting with version info:
```json
{
  "message": "Hello World!",
  "version": "1.0.0",
  "environment": "development",
  "timestamp": "2026-04-22T...",
  "hostname": "..."
}
```

#### `GET /api/hello?name=Azure`
Returns custom greeting:
```json
{
  "message": "Hello, Azure!",
  "timestamp": "2026-04-22T..."
}
```

#### `GET /health`
Health check endpoint:
```json
{
  "status": "healthy",
  "timestamp": "2026-04-22T...",
  "uptime": 123.45
}
```

#### `GET /ready`
Readiness check:
```json
{
  "status": "ready",
  "version": "1.0.0"
}
```

## 🐳 Docker

### Build and Run Locally
```bash
# Build Docker image
docker build -t hello-world-azure:latest .

# Run container
docker run -p 3000:3000 hello-world-azure:latest

# With environment variables
docker run -p 3000:3000 \
  -e NODE_ENV=production \
  -e APP_VERSION=1.0.0 \
  hello-world-azure:latest
```

### Using Docker Compose
```bash
# Start service
docker-compose up -d

# View logs
docker-compose logs -f

# Stop service
docker-compose down
```

## 🧪 Testing

```bash
# Run all tests
npm test

# Run tests in watch mode
npm test:watch

# Run with coverage report
npm test -- --coverage
```

## 🔧 Project Structure

```
azurehello/
├── app.js                    # Main Express application
├── app.test.js              # Jest unit tests
├── healthcheck.js           # Docker health check script
├── Dockerfile               # Multi-stage Docker build
├── docker-compose.yml       # Local Docker setup
├── azure-pipelines.yml      # Azure DevOps CI/CD pipeline
├── jest.config.js           # Jest test configuration
├── package.json             # Dependencies and scripts
├── .env.example             # Environment variables template
├── .gitignore              # Git ignore patterns
├── .dockerignore            # Docker ignore patterns
└── README.md               # This file
```

## 📦 Dependencies

### Production
- **express**: Web framework
- **cors**: CORS middleware
- **helmet**: Security headers
- **morgan**: HTTP request logger

### Development
- **nodemon**: Auto-reload on file changes
- **jest**: Testing framework
- **supertest**: HTTP assertion library
- **eslint**: Code linting

## 🔄 Azure DevOps Pipeline

The `azure-pipelines.yml` defines a complete CI/CD pipeline:

### Stages
1. **Build & Test**
   - Install Node.js 18
   - Install dependencies
   - Run unit tests
   - Publish test results and coverage
   - Package application

2. **Deploy to Dev**
   - Download artifacts
   - Deploy to Azure App Service (Dev)
   - Health check verification

3. **Deploy to Production** (main branch only)
   - Deploy to Azure App Service (Prod)

### Requirements
- Azure subscription with App Services created
- Service connection named `Azure Service Connection`
- App Services: `hello-world-azure-dev` and `hello-world-azure-prod`

## ⚙️ Environment Variables

Create `.env` file (copy from `.env.example`):
```env
PORT=3000
NODE_ENV=production
APP_VERSION=1.0.0
LOG_LEVEL=info
CORS_ORIGIN=*
```

## 🚢 Deployment to Azure

### Prerequisites
1. Azure subscription
2. Azure DevOps organization and project
3. App Services created in Azure Portal
4. Service connection configured

### Steps

1. **Create Azure App Services**
   ```bash
   # Create resource group
   az group create -n hello-world-rg -l eastus

   # Create App Service Plan
   az appservice plan create -n hello-world-plan \
     -g hello-world-rg --sku Free --is-linux

   # Create Dev App Service
   az webapp create -g hello-world-rg -p hello-world-plan \
     -n hello-world-azure-dev --runtime "node|18-lts"

   # Create Prod App Service
   az webapp create -g hello-world-rg -p hello-world-plan \
     -n hello-world-azure-prod --runtime "node|18-lts"
   ```

2. **Create Service Connection in Azure DevOps**
   - Project Settings → Service connections → New
   - Select Azure Resource Manager
   - Choose Service principal (automatic)
   - Name: `Azure Service Connection`
   - Save

3. **Create Pipeline**
   - Go to Pipelines → Create Pipeline
   - Select GitHub/repository
   - Choose existing YAML: `azure-pipelines.yml`
   - Run

4. **Monitor Deployment**
   - Watch pipeline progress
   - Check app at `https://hello-world-azure-dev.azurewebsites.net`

## 📊 Monitoring

After deployment, monitor your app:

```bash
# View logs
az webapp log tail -n hello-world-azure-dev -g hello-world-rg

# Check app status
az webapp show -n hello-world-azure-dev -g hello-world-rg

# Restart app
az webapp restart -n hello-world-azure-dev -g hello-world-rg
```

## 🔒 Security

- ✅ Non-root Docker user
- ✅ Helmet security headers
- ✅ CORS configured
- ✅ Graceful error handling
- ✅ Health checks
- ✅ Environment variable isolation

## 📝 Logs

Application logs are available at:
- **Local**: stdout/stderr
- **Docker**: `docker logs <container-id>`
- **Azure App Service**: Log stream in Azure Portal

## 🐛 Troubleshooting

### App won't start
- Check logs: `npm run dev`
- Verify port is available
- Check environment variables

### Tests failing
- Run `npm test` locally
- Check Node.js version: `node --version`
- Clear node_modules: `rm -rf node_modules && npm install`

### Docker build fails
- Check Dockerfile syntax
- Verify Docker installed: `docker --version`
- Check image size: `docker image ls`

### Azure deployment fails
- Verify service connection exists
- Check app name matches exactly
- Ensure resource group exists
- View pipeline logs for details

## 📚 Documentation

- [Express.js Documentation](https://expressjs.com/)
- [Azure DevOps Pipelines](https://docs.microsoft.com/azure/devops/pipelines/)
- [Docker Documentation](https://docs.docker.com/)
- [Node.js on Azure](https://docs.microsoft.com/nodejs/azure)

## 📄 License

MIT License - see LICENSE file

## 👤 Author

Your Name

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

---

**Version**: 1.0.0  
**Last Updated**: April 22, 2026  
**Status**: Production Ready ✅
