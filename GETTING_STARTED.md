# Getting Started - Quick Guide

## 🚀 First Time? Start Here!

### Step 1: Setup (5 minutes)

**Windows:**
```bash
setup.bat
```

**Linux/Mac:**
```bash
chmod +x setup.sh
./setup.sh
```

This will:
- ✅ Check Node.js is installed
- ✅ Install all dependencies
- ✅ Run tests
- ✅ Create .env file

### Step 2: Run Locally (1 minute)

```bash
npm start
```

Open browser: **http://localhost:3000/**

You should see:
```json
{
  "message": "Hello World!",
  "version": "1.0.0",
  "environment": "development",
  "timestamp": "2026-04-22T...",
  "hostname": "..."
}
```

### Step 3: Test the API

```bash
# Default greeting
curl http://localhost:3000/

# Custom greeting
curl http://localhost:3000/api/hello?name=Azure

# Health check
curl http://localhost:3000/health

# Readiness check
curl http://localhost:3000/ready
```

## 📦 Docker (Local Testing)

```bash
# Build image
docker build -t hello-world-azure .

# Run container
docker run -p 3000:3000 hello-world-azure:latest

# Or use Docker Compose
docker-compose up -d
docker-compose logs -f
docker-compose down
```

## 🧪 Run Tests

```bash
npm test          # Run once
npm test:watch    # Watch mode
npm test -- --coverage  # With coverage
```

## 🌐 Deploy to Azure

**Complete guide**: See `DEPLOYMENT.md`

Quick version:
1. Create Azure subscription (free tier available)
2. Create App Services in Azure Portal
3. Create Azure DevOps organization
4. Create service connection
5. Push code to GitHub
6. Create pipeline in Azure DevOps
7. Watch it deploy! 🎉

## 📚 Documentation

- **README.md**: Full project documentation
- **DEPLOYMENT.md**: Step-by-step Azure setup
- **FILES.md**: All files explained
- **This file**: Quick start guide

## 🔧 Available Commands

```bash
npm start              # Run app
npm run dev           # Run with auto-reload (nodemon)
npm test              # Run tests once
npm test:watch        # Run tests in watch mode
npm run lint          # Run ESLint
npm run healthcheck   # Check app health
```

## 🛠️ Project Structure

```
azurehello/
├── app.js           # Main application
├── app.test.js      # Tests
├── Dockerfile       # Docker config
├── azure-pipelines.yml  # CI/CD
├── package.json     # Dependencies
└── README.md        # Full docs
```

## ⚡ Next Steps

1. ✅ Explore the API endpoints
2. ✅ Run the tests: `npm test`
3. ✅ Try Docker: `docker-compose up`
4. ✅ Read DEPLOYMENT.md
5. ✅ Deploy to Azure DevOps
6. ✅ Monitor your live app

## ❓ Common Questions

**Q: How do I change the port?**  
A: Set `PORT` in `.env` file (default is 3000)

**Q: How do I add more endpoints?**  
A: Edit `app.js`, add route, write test in `app.test.js`

**Q: How do I deploy changes?**  
A: Push to GitHub, pipeline runs automatically

**Q: Where are the logs?**  
A: `npm run dev` shows logs in terminal, Docker: `docker logs`

**Q: Is it production ready?**  
A: Yes! Includes security, health checks, tests, and CI/CD

## 🆘 Troubleshooting

**Port already in use?**
```bash
# Linux/Mac: Kill process on port 3000
lsof -i :3000 | grep LISTEN | awk '{print $2}' | xargs kill -9

# Windows: Kill process on port 3000
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

**npm install fails?**
```bash
rm -rf node_modules package-lock.json
npm install
```

**Tests failing?**
```bash
npm test -- --verbose
npm test -- --detectOpenHandles
```

## 📞 Getting Help

1. Check README.md for detailed docs
2. Check DEPLOYMENT.md for Azure help
3. Check app logs: `npm run dev`
4. Check pipeline logs in Azure DevOps

## 📋 Checklist for First Deploy

- [ ] Run `npm test` - All pass?
- [ ] Run `npm start` - Works locally?
- [ ] Docker image builds? `docker build -t hello-world-azure .`
- [ ] Azure account created?
- [ ] App Services created?
- [ ] Service connection created?
- [ ] Code pushed to GitHub?
- [ ] Pipeline created in Azure DevOps?
- [ ] Pipeline runs successfully?
- [ ] App accessible at https://your-app.azurewebsites.net?

---

**You're all set! 🎉**

For detailed information, see:
- Full setup: **DEPLOYMENT.md**
- API docs: **README.md**
- File descriptions: **FILES.md**

**Happy coding! 🚀**
