import { Injectable, InternalServerErrorException } from '@nestjs/common'
import { Client } from '@jeffe/tankille'

@Injectable()
export class TankilleService {
  tankille = new Client()

  constructor() {
    this.tankille.login({
      email: process.env.TANKILLE_EMAIL!,
      password: process.env.TANKILLE_PASSWORD!
    })
  }

  async getStationsByLocation(
    location: { lat: number; lon: number },
    distance: number
  ) {
    if (!this.tankille.tokenCache.data.accessToken)
      throw new InternalServerErrorException('Tankille is not logged in')

    const stations = await this.tankille.getStationsByLocation(
      location,
      distance
    )
    return stations
  }
}
