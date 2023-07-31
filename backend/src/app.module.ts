import { Module } from '@nestjs/common'

import { HelloworldModule } from './modules/helloworld/helloworld.module'
import { CacheModule } from '@nestjs/cache-manager'
import { StationsModule } from './modules/stations/stations.module'
import { ConfigModule } from '@nestjs/config'

@Module({
  imports: [
    ConfigModule.forRoot(),
    // CacheModule.register({ isGlobal: true }),
    HelloworldModule,
    StationsModule
  ]
})
export class AppModule {}
