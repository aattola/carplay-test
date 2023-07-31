import { Module } from '@nestjs/common'
import { StationsController } from './stations.controller'
import { StationsService } from './stations.service'
import { TankilleService } from '../../services/tankille/tankille.service'

@Module({
  imports: [],
  controllers: [StationsController],
  providers: [StationsService, TankilleService]
})
export class StationsModule {}
