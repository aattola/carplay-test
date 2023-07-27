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
  
  public func getPointOfInterestTemplate() -> CPPointOfInterestTemplate {
    let location = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(61.492295), longitude: CLLocationDegrees(23.771604))))
    
    location.name = "Neste K Hatanpää"
    location.pointOfInterestCategory = .gasStation
  
    
    let POI = CPPointOfInterest(location: location, title: "Neste K Hatanpää", subtitle: "Tankki", summary: "Mene tänne tankkaamaan", detailTitle: "Neste K Hatanpää", detailSubtitle: "", detailSummary: "95: 1.85€\n85: 2.19€\nD: 1.54€", pinImage: UIImage(systemName: "hand.point.down"))
    
    POI.primaryButton = CPTextButton(title: "Navigoi", textStyle: .confirm, handler: {_ in
      print("NAVIGATE")
      
      location.openInMaps(from: self.templateApplicationScene, completionHandler: {_ in return})
    
    })
    
    let POITemplate = CPPointOfInterestTemplate(title: "Huoltoasemat", pointsOfInterest: [POI], selectedIndex: 0)
    
    return POITemplate
  }

}
