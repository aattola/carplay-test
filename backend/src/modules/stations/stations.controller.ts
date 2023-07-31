import {
  Controller,
  Get,
  Param,
  ParseFloatPipe,
  ParseIntPipe,
  Query,
  Version
} from '@nestjs/common'
import { StationsService } from './stations.service'
import { fuelTypes } from '../../types/tankille'
import { ParseFuelTypePipe } from './fuel.pipe'

@Controller('/stations')
export class StationsController {
  constructor(private readonly stationsService: StationsService) {}

  @Get('location/sorted')
  @Version('1')
  getByLocationStorted(
    @Query('lat', ParseFloatPipe) lat: number,
    @Query('lon', ParseFloatPipe) lon: number
  ) {
    console.log(lat, lon)
    return this.stationsService.getStationsByLocationSorted(
      {
        lat,
        lon
      },
      '95'
    )
  }
}
