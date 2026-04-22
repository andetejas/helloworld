# Azure Deployment Guide

Complete step-by-step guide to deploy Hello World app to Azure using Azure DevOps.

## Prerequisites

- Azure subscription (free tier available at https://azure.microsoft.com/free/)
- Azure DevOps account (free at https://dev.azure.com)
- GitHub account or Azure Repos
- Azure CLI (optional, for advanced setup)

## Step 1: Create Azure Resources

### 1.1 Create Resource Group

```bash
az group create \
  --name hello-world-rg \
  --location eastus
```

Or via Azure Portal:
1. Go to https://portal.azure.com
2. Click "+ Create a resource"
3. Search "Resource group"
4. Click Create
5. Enter name: `hello-world-rg`
6. Click Review + Create → Create

### 1.2 Create App Service Plan

```bash
az appservice plan create \
  --name hello-world-plan \
  --resource-group hello-world-rg \
  --sku Free \
  --is-linux
```

Or via Azure Portal:
1. Search "App Service plans"
2. Click "+ Create"
3. Select Resource group: `hello-world-rg`
4. Name: `hello-world-plan`
5. OS: Linux
6. Sku: Free F1
7. Click Review + Create → Create

### 1.3 Create App Services

**For Development:**
```bash
az webapp create \
  --resource-group hello-world-rg \
  --plan hello-world-plan \
  --name hello-world-azure-dev \
  --runtime "node|18-lts"
```

**For Production:**
```bash
az webapp create \
  --resource-group hello-world-rg \
  --plan hello-world-plan \
  --name hello-world-azure-prod \
  --runtime "node|18-lts"
```

Or via Azure Portal:
1. Search "App Service"
2. Click "+ Create"
3. Select Resource group: `hello-world-rg`
4. Name: `hello-world-azure-dev`
5. Runtime: Node 18 LTS
6. OS: Linux
7. Region: East US (or your region)
8. Click Review + Create → Create
9. Repeat for `hello-world-azure-prod`

### 1.4 Configure App Settings

```bash
# Set Node environment
az webapp config appsettings set \
  --resource-group hello-world-rg \
  --name hello-world-azure-dev \
  --settings NODE_ENV=production APP_VERSION=1.0.0

az webapp config appsettings set \
  --resource-group hello-world-rg \
  --name hello-world-azure-prod \
  --settings NODE_ENV=production APP_VERSION=1.0.0
```

Or via Azure Portal:
1. App Service → Settings → Configuration
2. Click "New application setting"
3. Add settings:
   - Name: `NODE_ENV` | Value: `production`
   - Name: `APP_VERSION` | Value: `1.0.0`
4. Click Save

## Step 2: Setup Azure DevOps

### 2.1 Create Azure DevOps Organization

1. Go to https://dev.azure.com
2. Click "Create new organization"
3. Accept terms and continue
4. Enter organization name: `MyHelloWorldOrg`
5. Select region (closest to you)
6. Click Continue

### 2.2 Create Project

1. Click "+ New project"
2. Project name: `hello-world-deployment`
3. Visibility: Private
4. Click Create

### 2.3 Create Service Connection

1. Go to Project Settings (⚙️ bottom left)
2. Click "Service connections" (under Pipelines)
3. Click "New service connection"
4. Select "Azure Resource Manager"
5. Choose "Service principal (automatic)"
6. Fill in:
   - Subscription: Select your subscription
   - Resource Group: `hello-world-rg`
   - Service connection name: `Azure Service Connection`
7. Click "Save"

## Step 3: Setup Repository

### 3.1 Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `hello-world-deployment`
3. Description: `Simple Hello World app for Azure DevOps`
4. Public or Private (Private recommended)
5. Click "Create repository"

### 3.2 Push Code to GitHub

```bash
# Clone your repo
git clone https://github.com/YOUR_USERNAME/hello-world-deployment.git
cd hello-world-deployment

# Copy files from azurehello folder
cp -r ../azurehello/* .

# Commit and push
git add .
git commit -m "Initial commit: Hello World Azure DevOps app"
git push -u origin main
```

## Step 4: Create Azure DevOps Pipeline

### 4.1 Connect Repository

1. In Azure DevOps project, go to "Pipelines"
2. Click "Create Pipeline"
3. Select code location: "GitHub"
4. Authorize Azure Pipelines to access GitHub
5. Select your repository: `hello-world-deployment`

### 4.2 Configure Pipeline

1. Choose "Existing Azure Pipelines YAML file"
2. Select branch: `main`
3. Path: `/azure-pipelines.yml`
4. Click "Continue"
5. Review YAML
6. Click "Save and run"

A commit will be made to enable the pipeline.

### 4.3 Configure Pipeline Variables (Optional)

1. In Pipelines, select your pipeline
2. Click "Edit" (top right)
3. Click "Variables" (top right)
4. Add variable: `SUBSCRIPTION_ID` = Your Subscription ID
5. Click "Save"

## Step 5: Run Pipeline

### 5.1 Trigger Pipeline

1. Go to Pipelines
2. Select your pipeline
3. Click "Run pipeline"
4. Select branch: `main`
5. Click "Run"

### 5.2 Monitor Execution

Watch the pipeline stages:
- **Build & Test** (5-10 min)
  - Installs Node.js
  - Installs dependencies
  - Runs tests
  - Publishes artifacts

- **Deploy to Dev** (5 min)
  - Downloads artifacts
  - Deploys to App Service
  - Runs health check

- **Deploy to Production** (main branch only)
  - Deploys to production App Service

## Step 6: Verify Deployment

### 6.1 Check Application

After deployment succeeds:

```bash
# Test Dev
curl https://hello-world-azure-dev.azurewebsites.net/
curl https://hello-world-azure-dev.azurewebsites.net/health

# Test Production (if deployed)
curl https://hello-world-azure-prod.azurewebsites.net/
```

### 6.2 Check Azure Portal

1. Go to https://portal.azure.com
2. Search "App Services"
3. Select `hello-world-azure-dev`
4. Check:
   - Status: "Running"
   - Default domain: Note the URL
   - Log stream: View application logs

### 6.3 API Testing

```bash
# Get greeting
curl https://hello-world-azure-dev.azurewebsites.net/

# Get custom greeting
curl https://hello-world-azure-dev.azurewebsites.net/api/hello?name=Azure

# Health check
curl https://hello-world-azure-dev.azurewebsites.net/health

# Readiness check
curl https://hello-world-azure-dev.azurewebsites.net/ready
```

## Step 7: Monitor & Maintain

### View Logs

```bash
# Via Azure CLI
az webapp log tail --name hello-world-azure-dev --resource-group hello-world-rg

# Via Azure Portal
App Service → Log stream → Enable Application Logs → Refresh
```

### Check Deployment History

```bash
az webapp deployment list --name hello-world-azure-dev --resource-group hello-world-rg
```

### Restart Application

```bash
az webapp restart --name hello-world-azure-dev --resource-group hello-world-rg
```

### View Application Insights

1. Go to Azure Portal
2. Search "Application Insights"
3. Create new or link existing
4. Monitor performance, errors, and dependencies

## Step 8: Enable Continuous Deployment (Optional)

### Auto-Deploy on Push

1. In Pipeline, click "Edit"
2. Go to "Triggers"
3. Enable "Continuous integration"
4. Select branches: `main`, `develop`
5. Click "Save"

Now pipeline runs automatically when code is pushed!

### Branch Policies

Protect main branch:
1. In Repo, go to Settings → Branches
2. Click "..." on main branch
3. Enable "Require pull request reviews"
4. Require "Successful builds"
5. Save

## Troubleshooting

### Pipeline Fails

**Check service connection:**
- Project Settings → Service connections
- Verify name: `Azure Service Connection`
- Click "Test connection"

**Check app names:**
- Verify App Services exist in Azure Portal
- Update names in `azure-pipelines.yml` if needed

### Deployment Fails

**App not starting:**
- Check logs: `az webapp log tail ...`
- Verify startup command: `npm start`
- Check NODE_ENV is `production`

**404 Error:**
- Wait 2-3 minutes for cold start
- Check health endpoint: `/health`
- Restart app: `az webapp restart ...`

### Health Check Failing

**Common causes:**
- App not started yet (wait 30 seconds)
- Port not accessible
- Health endpoint not available

**Fix:**
- Check logs for errors
- Verify app.js has `/health` endpoint
- Ensure PORT environment variable is set

## Useful Commands

```bash
# List all resources
az resource list --resource-group hello-world-rg

# Check app status
az webapp show --name hello-world-azure-dev --resource-group hello-world-rg

# View app settings
az webapp config appsettings list --name hello-world-azure-dev --resource-group hello-world-rg

# Get deployment details
az webapp deployment show --name hello-world-azure-dev --resource-group hello-world-rg --slot production

# Stop app
az webapp stop --name hello-world-azure-dev --resource-group hello-world-rg

# Start app
az webapp start --name hello-world-azure-dev --resource-group hello-world-rg

# Delete resource group (cleanup)
az group delete --name hello-world-rg
```

## Cost Estimation

**Free Tier (for testing):**
- App Service Plan: $0/month
- App Service: $0/month (first 12 months, limited)
- Total: Free

**Basic Tier (recommended for production):**
- App Service Plan (B1): $11.50/month
- App Service: Included
- Total: ~$12/month

## Next Steps

1. ✅ Setup complete!
2. Add more endpoints to app.js
3. Implement database integration
4. Add authentication/authorization
5. Setup monitoring with Application Insights
6. Configure custom domain name
7. Enable SSL/TLS certificate
8. Setup auto-scaling

## Support

- Azure Portal: https://portal.azure.com
- Azure DevOps: https://dev.azure.com
- Documentation: https://docs.microsoft.com/azure
- Support: https://support.microsoft.com

---

**Last Updated**: April 22, 2026  
**Version**: 1.0.0
