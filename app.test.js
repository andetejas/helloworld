const request = require('supertest');
const app = require('./app');

describe('Hello World API', () => {
  describe('GET /', () => {
    it('should return 200 OK', async () => {
      const response = await request(app)
        .get('/')
        .expect(200);

      expect(response.body).toHaveProperty('message');
      expect(response.body.message).toBe('Hello World!');
      expect(response.body).toHaveProperty('version');
      expect(response.body).toHaveProperty('environment');
      expect(response.body).toHaveProperty('timestamp');
    });
  });

  describe('GET /api/hello', () => {
    it('should return greeting with default name', async () => {
      const response = await request(app)
        .get('/api/hello')
        .expect(200);

      expect(response.body).toHaveProperty('message');
      expect(response.body.message).toBe('Hello, World!');
    });

    it('should return greeting with custom name', async () => {
      const response = await request(app)
        .get('/api/hello?name=Azure')
        .expect(200);

      expect(response.body.message).toBe('Hello, Azure!');
    });
  });

  describe('GET /health', () => {
    it('should return healthy status', async () => {
      const response = await request(app)
        .get('/health')
        .expect(200);

      expect(response.body).toHaveProperty('status');
      expect(response.body.status).toBe('healthy');
      expect(response.body).toHaveProperty('uptime');
    });
  });

  describe('GET /ready', () => {
    it('should return ready status', async () => {
      const response = await request(app)
        .get('/ready')
        .expect(200);

      expect(response.body).toHaveProperty('status');
      expect(response.body.status).toBe('ready');
    });
  });

  describe('GET /notfound', () => {
    it('should return 404 for unknown routes', async () => {
      const response = await request(app)
        .get('/notfound')
        .expect(404);

      expect(response.body).toHaveProperty('error');
      expect(response.body.error).toBe('Endpoint not found');
    });
  });
});
