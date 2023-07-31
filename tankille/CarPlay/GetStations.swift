//
//  GetStations.swift
//  tankille
//
//  Created by Leevi Aattola on 28.7.2023.
//

import Alamofire
import Foundation

func getStationsByLocation(lat: Float, lon: Float, fuel: String, _ completion: @escaping (Stations) -> Void) {
  AF.request("https://tankille-api.jeffe.co/v1/stations/location/sorted?lat=\(lat)&lon=\(lon)&fuel=\(fuel)").responseDecodable(of: Stations.self) { response in

    switch response.result {
    case let .success(data):
      print(data)
      completion(data)

    case let .failure(err):
      print("kusi koko vehje")
      print(err)
      return
    }
  }
}
