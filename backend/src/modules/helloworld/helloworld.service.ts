import { Injectable } from '@nestjs/common'
import { DateTime } from 'luxon'

@Injectable()
export class HelloworldService {
  getHello(): string {
    return DateTime.now().toString()
  }
}
