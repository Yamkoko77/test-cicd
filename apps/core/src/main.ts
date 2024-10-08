import { NestFactory } from '@nestjs/core';
import { CoreModule } from './core.module';

async function bootstrap() {
  const app = await NestFactory.create(CoreModule);
  await app.listen(3000, () => console.log('Core listening on port 3000'));
}
bootstrap();
