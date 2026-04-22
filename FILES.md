# Complete Azure DevOps Hello World Repository

## 📁 Repository Structure

```
azurehello/
├── 📄 app.js                    # Main Express.js application
├── 📄 app.test.js              # Jest unit tests
├── 📄 healthcheck.js           # Docker health check script
├── 📄 Dockerfile               # Multi-stage Docker build
├── 📄 docker-compose.yml       # Local Docker Compose setup
├── 📄 azure-pipelines.yml      # Azure DevOps CI/CD pipeline
├── 📄 jest.config.js           # Jest configuration
├── 📄 nginx.conf               # Nginx reverse proxy config
├── 📄 package.json             # Node.js dependencies
├── 📄 .eslintrc.json           # ESLint configuration
├── 📄 .gitignore              # Git ignore patterns
├── 📄 .dockerignore            # Docker ignore patterns
├── 📄 .env.example             # Environment variables template
├── 📄 setup.sh                 # Linux/Mac setup script
├── 📄 setup.bat                # Windows setup script
├── 📄 README.md               # Project documentation
├── 📄 DEPLOYMENT.md           # Azure deployment guide
└── 📄 FILES.md                # This file
```

## 📋 File Descriptions

### Application Files

**app.js** (134 lines)
- Express.js web application
- RESTful API endpoints
- Health and readiness checks
- Graceful shutdown handling
- Security middleware (Helmet, CORS)

**app.test.js** (61 lines)
- Jest unit tests
- Tests for all endpoints
- Status code validation
- Response structure validation

**healthcheck.js** (21 lines)
- Docker health check script
- HTTP GET request to /health endpoint
- Exit codes for container orchestration

### Configuration Files

**package.json** (29 lines)
- Project metadata
- Production dependencies (express, cors, helmet, morgan)
- Development dependencies (nodemon, jest, supertest, eslint)
- NPM scripts (start, dev, test, lint)
- Node.js 18+ requirement

**jest.config.js** (14 lines)
- Test environment configuration
- Coverage settings
- Test file patterns
- Cleanup and reset options

**.eslintrc.json** (42 lines)
- Code linting rules
- ES2021 standards
- Node.js and Jest environments
- Spacing, indentation, semicolon rules

**.env.example** (9 lines)
- Template for environment variables
- PORT, NODE_ENV, APP_VERSION
- CORS and logging settings

**.gitignore** (30 lines)
- Node.js patterns (node_modules, npm-debug.log)
- IDE patterns (.vscode, .idea)
- OS patterns (DS_Store, Thumbs.db)
- Test and build artifacts

**.dockerignore** (18 lines)
- Patterns to exclude from Docker builds
- Reduces image size

### Docker Files

**Dockerfile** (33 lines)
- Multi-stage build (builder + runtime)
- Node 18 Alpine base image
- Non-root user for security
- Health check configuration
- Optimized for production

**docker-compose.yml** (25 lines)
- Local development environment
- Port mapping (3000:3000)
- Environment variables
- Health check configuration
- Volume mounting for development

### Deployment Files

**azure-pipelines.yml** (164 lines)
- Complete CI/CD pipeline
- Build stage: Install, test, package
- Deploy Dev stage: Deploy to development
- Deploy Prod stage: Deploy to production (main branch only)
- Artifact management
- Environment-specific steps

**nginx.conf** (120 lines)
- Reverse proxy configuration
- HTTPS/SSL setup
- Gzip compression
- Rate limiting (API and general)
- Security headers
- Upstream to Node.js app
- Health check routes

### Documentation Files

**README.md** (350+ lines)
- Project overview and features
- Quick start guide
- API endpoint documentation
- Docker setup and usage
- Testing guide
- Project structure
- Deployment instructions
- Troubleshooting guide
- Environment variables
- Security practices

**DEPLOYMENT.md** (400+ lines)
- Step-by-step Azure setup
- Resource group creation
- App Service Plan setup
- App Service creation
- Azure DevOps configuration
- Service connection setup
- Pipeline creation
- Deployment verification
- Monitoring and maintenance
- Troubleshooting
- Useful Azure CLI commands
- Cost estimation

**setup.sh** (60 lines)
- Automated Linux/Mac setup
- Node.js and npm verification
- Dependency installation
- Environment file creation
- Test execution
- Usage instructions

**setup.bat** (70 lines)
- Automated Windows setup
- Node.js and npm verification
- Dependency installation
- Environment file creation
- Test execution
- Usage instructions

---

## 🚀 Quick Start

### 1. Local Development
```bash
# Windows
setup.bat

# Linux/Mac
chmod +x setup.sh
./setup.sh
```

### 2. Run Application
```bash
npm start
# App runs at http://localhost:3000
```

### 3. Run Tests
```bash
npm test
```

### 4. Docker Local Testing
```bash
docker-compose up -d
# App runs at http://localhost:3000
docker-compose logs -f
docker-compose down
```

### 5. Deploy to Azure
See `DEPLOYMENT.md` for complete step-by-step guide

---

## 📊 File Statistics

| Category | Count | Purpose |
|----------|-------|---------|
| Application | 2 | Node.js app + tests |
| Configuration | 6 | Build, test, lint configs |
| Docker | 2 | Containerization |
| Deployment | 2 | Azure CI/CD pipeline |
| Scripts | 2 | Setup automation |
| Documentation | 4 | Guides and references |
| **Total** | **18** | **Complete repo** |

---

## 🔄 Pipeline Flow

```
Code Push (GitHub)
    ↓
Azure DevOps Trigger
    ↓
BUILD STAGE (5-10 min)
    ├─ Install Node.js 18
    ├─ Install dependencies (npm ci)
    ├─ Run unit tests (jest)
    ├─ Publish test results
    ├─ Package application
    └─ Publish artifacts
    ↓
DEPLOY DEV (5 min)
    ├─ Download artifacts
    ├─ Deploy to App Service
    └─ Health check
    ↓
DEPLOY PROD (main branch only)
    ├─ Download artifacts
    ├─ Deploy to production App Service
    └─ Complete!
```

---

## 🔐 Security Features

✅ **Application Security**
- Helmet.js for HTTP headers
- CORS configuration
- Error handling (no stack traces in prod)
- Input validation ready
- Request logging (Morgan)

✅ **Docker Security**
- Non-root user (nodejs)
- Multi-stage build (reduces image size)
- Alpine base (minimal attack surface)
- Health checks enabled

✅ **Pipeline Security**
- Service connection (no hardcoded credentials)
- Environment separation (dev/prod)
- Artifact management
- Private DevOps project

✅ **Azure Security**
- Private resource group
- Network isolation ready
- SSL/TLS support (nginx config included)
- Application Insights integration ready

---

## 📈 Scalability Features

- **Graceful shutdown** handling
- **Health checks** for orchestration
- **Rate limiting** ready (nginx.conf)
- **Load balancing** ready
- **Environment variables** for configuration
- **Non-blocking** async operations
- **Connection pooling** ready

---

## 🧪 Testing Strategy

**Unit Tests**
- API endpoint validation
- Status code verification
- Response structure validation
- Error handling

**Health Checks**
- `/health` - Liveness probe
- `/ready` - Readiness probe
- Docker health check script

**Manual Testing**
```bash
curl http://localhost:3000/
curl http://localhost:3000/api/hello?name=Azure
curl http://localhost:3000/health
curl http://localhost:3000/ready
```

---

## 📝 Configuration Files Purpose

| File | Purpose | When Used |
|------|---------|-----------|
| `.env` | Runtime configuration | Development & Production |
| `package.json` | Dependencies & scripts | Build & Runtime |
| `jest.config.js` | Test configuration | Test execution |
| `.eslintrc.json` | Code quality | Linting |
| `Dockerfile` | Container building | Docker build & deploy |
| `nginx.conf` | Reverse proxy | Advanced deployment |
| `azure-pipelines.yml` | CI/CD automation | Pipeline execution |

---

## 🎯 Next Steps After Setup

1. ✅ Clone/fork this repo
2. ✅ Run `setup.sh` or `setup.bat`
3. ✅ Test locally: `npm start`
4. ✅ Run tests: `npm test`
5. ✅ Follow `DEPLOYMENT.md` for Azure
6. ✅ Push to GitHub
7. ✅ Create Azure DevOps pipeline
8. ✅ Watch automatic deployment!

---

## 📚 Documentation Map

- **Getting Started**: README.md
- **Local Setup**: setup.sh / setup.bat
- **API Reference**: README.md (Endpoints section)
- **Docker Usage**: README.md (Docker section)
- **Azure Deployment**: DEPLOYMENT.md (complete guide)
- **Testing**: README.md (Testing section)
- **Troubleshooting**: README.md + DEPLOYMENT.md

---

## 🎓 Learning Resources

- **Express.js**: https://expressjs.com/
- **Jest Testing**: https://jestjs.io/
- **Docker**: https://docs.docker.com/
- **Azure DevOps**: https://docs.microsoft.com/azure/devops/
- **Node.js Best Practices**: https://nodejs.org/en/docs/guides/

---

## ✨ Key Features Summary

| Feature | Status | Details |
|---------|--------|---------|
| Express.js API | ✅ | Full RESTful endpoints |
| Unit Tests | ✅ | 6 test cases with Jest |
| Docker Support | ✅ | Production-ready image |
| Azure DevOps | ✅ | Complete CI/CD pipeline |
| Health Checks | ✅ | Liveness + Readiness |
| Security | ✅ | Helmet, CORS, validations |
| Logging | ✅ | Morgan request logging |
| Environment Config | ✅ | .env support |
| Nginx Config | ✅ | Reverse proxy ready |
| Setup Automation | ✅ | Both Windows & Unix |

---

**Repository**: Production-Ready ✅  
**Status**: Ready for deployment  
**Version**: 1.0.0  
**Last Updated**: April 22, 2026  

---

## 💡 Pro Tips

1. **Local development**: Use `npm run dev` for auto-reload
2. **Testing**: Run `npm test:watch` for continuous testing
3. **Docker debugging**: Use `docker logs` to check container output
4. **Pipeline debugging**: Check Azure DevOps logs for each stage
5. **Production monitoring**: Enable Application Insights in Azure Portal

---

**Everything you need to deploy a production-ready Hello World app to Azure! 🚀**
