//
//  PointOfInterest.swift
//  tankille
//
//  Created by Leevi Aattola on 27.7.2023.
//

import CarPlay

class JFPointOfInterest {
  private var interfaceController: CPInterfaceController
  private var templateApplicationScene: CPTemplateApplicationScene?
  
  init(interfaceController: CPInterfaceController, templateApplicationScene: CPTemplateApplicationScene? = nil) {
    self.interfaceController = interfaceController
    self.templateApplicationScene = templateApplicationScene
  }
  
  public func getPointOfInterestTemplate(points: Stations) -> CPPointOfInterestTemplate {
    let location = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(61.492295), longitude: CLLocationDegrees(23.771604))))
    
    location.name = "Neste K Hatanpää"
    location.pointOfInterestCategory = .gasStation
    
    
    let PointsOfInterest = points.map { (station) -> CPPointOfInterest in
      
      let location = CLLocationCoordinate2D(latitude: station.location.coordinates[1], longitude: station.location.coordinates[0])
      let placemark = MKPlacemark(coordinate: location)
      let mapItem = MKMapItem(placemark: placemark)
      
      let title = station.name
      let subtitle = station.chain
      
      let prices = station.price.map { (price) -> String in
        return "\(price.tag): \(price.price)€"
      }
      
      let detailSummary = prices.joined(separator: "\n")
      let image = UIImage(systemName: "fuelpump.circle.fill")
      
      let poi = CPPointOfInterest(location: mapItem, title: title, subtitle: subtitle, summary: detailSummary, detailTitle: nil, detailSubtitle: nil, detailSummary: nil, pinImage: image)
      
      
      let navigateButton = CPTextButton(title: "Navigoi", textStyle: .confirm) {_ in
        mapItem.openInMaps(from: self.templateApplicationScene, completionHandler: {_ in return})
      }
      
      poi.primaryButton = navigateButton
      
      return poi
    }
    

    
    let POITemplate = CPPointOfInterestTemplate(title: "Huoltoasemat", pointsOfInterest: PointsOfInterest, selectedIndex: 0)
    
    return POITemplate
  }

}
