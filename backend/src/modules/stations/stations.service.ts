import { Injectable } from '@nestjs/common'
import { DateTime } from 'luxon'
import { TankilleService } from '../../services/tankille/tankille.service'
import { fuelTypes } from '../../types/tankille'
import { Asema } from '@jeffe/tankille/build/main/types/client'

@Injectable()
export class StationsService {
  constructor(private tankilleService: TankilleService) {}
  async getStationsByLocationSorted(
    location: { lat: number; lon: number },
    fuelType: fuelTypes
  ): Promise<Asema[]> {
    const stations = await this.tankilleService.getStationsByLocation(
      location,
      15000
    )

    const stationsWithFuel = stations.filter(
      station =>
        station.fuels.includes(fuelType) &&
        station.price.findIndex(price => price.tag === fuelType) !== -1
    )

    const stationsSortedByPrice = stationsWithFuel.sort((a, b) => {
      const aPrice = a.price.find(price => price.tag === fuelType)!
      const bPrice = b.price.find(price => price.tag === fuelType)!
      return aPrice.price - bPrice.price
    })

    const swiftCompatibleFormat = stationsSortedByPrice.map(station => {
      station.price = station.price.map(price => ({ ...price, id: price._id }))

      return { ...station, id: station._id }
    })

    console.log(swiftCompatibleFormat, 'form')

    return swiftCompatibleFormat
  }
}
