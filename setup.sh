#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}=====================================${NC}"
echo -e "${BLUE}Hello World Azure - Setup Script${NC}"
echo -e "${BLUE}=====================================${NC}\n"

# Check Node.js installation
echo -e "${YELLOW}Checking Node.js installation...${NC}"
if ! command -v node &> /dev/null; then
    echo -e "${RED}Node.js is not installed. Please install Node.js 18+${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Node.js $(node --version) found${NC}\n"

# Check npm installation
echo -e "${YELLOW}Checking npm installation...${NC}"
if ! command -v npm &> /dev/null; then
    echo -e "${RED}npm is not installed. Please install npm${NC}"
    exit 1
fi
echo -e "${GREEN}✓ npm $(npm --version) found${NC}\n"

# Install dependencies
echo -e "${YELLOW}Installing dependencies...${NC}"
npm install
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Dependencies installed successfully${NC}\n"
else
    echo -e "${RED}✗ Failed to install dependencies${NC}"
    exit 1
fi

# Copy environment file
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file...${NC}"
    cp .env.example .env
    echo -e "${GREEN}✓ .env file created${NC}\n"
fi

# Run tests
echo -e "${YELLOW}Running tests...${NC}"
npm test
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ All tests passed${NC}\n"
else
    echo -e "${YELLOW}⚠ Some tests failed. Check logs above.${NC}\n"
fi

# Summary
echo -e "${BLUE}=====================================${NC}"
echo -e "${GREEN}Setup Complete!${NC}"
echo -e "${BLUE}=====================================${NC}\n"

echo -e "${YELLOW}Next steps:${NC}"
echo -e "1. Start the app: ${BLUE}npm start${NC}"
echo -e "2. Run in dev mode: ${BLUE}npm run dev${NC}"
echo -e "3. Run tests: ${BLUE}npm test${NC}"
echo -e "4. Build Docker image: ${BLUE}docker build -t hello-world-azure .${NC}"
echo -e "5. Deploy: Push to GitHub and let Azure DevOps handle it!\n"

echo -e "${YELLOW}Access points:${NC}"
echo -e "- Main endpoint: ${BLUE}http://localhost:3000/${NC}"
echo -e "- API endpoint: ${BLUE}http://localhost:3000/api/hello?name=YourName${NC}"
echo -e "- Health check: ${BLUE}http://localhost:3000/health${NC}\n"
