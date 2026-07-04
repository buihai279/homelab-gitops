import Fastify from 'fastify';
import cors from '@fastify/cors';

const app = Fastify({ logger: true });
const port = Number(process.env.PORT ?? 3000);
const version = process.env.APP_VERSION ?? 'dev';

await app.register(cors, { origin: true });

app.get('/healthz', async () => ({ ok: true }));

app.get('/', async () => ({
  service: 'ts-demo',
  message: 'Hello from TypeScript CI/CD on k3s',
  version,
  time: new Date().toISOString(),
}));

await app.listen({ port, host: '0.0.0.0' });
