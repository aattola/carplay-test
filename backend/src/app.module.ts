import { Module } from '@nestjs/common'

import { HelloworldModule } from './modules/helloworld/helloworld.module'
import { CacheModule } from '@nestjs/cache-manager'

@Module({
  imports: [
    CacheModule.register({ isGlobal: true }),
    HelloworldModule
  ]
})
export class AppModule {}
