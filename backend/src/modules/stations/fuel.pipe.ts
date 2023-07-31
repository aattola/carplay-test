import {
  PipeTransform,
  Injectable,
  ArgumentMetadata,
  BadRequestException
} from '@nestjs/common'

@Injectable()
export class ParseFuelTypePipe implements PipeTransform {
  transform(value: string, metadata: ArgumentMetadata) {
    console.log(value)
    if (value === 'diesel') return 'diesel'
    if (value === '95') return '95'
    if (value === '98') return '98'

    throw new BadRequestException('Invalid fuel type', {
      description: "Must be one of 'diesel', '95' or '98'"
    })
  }
}
