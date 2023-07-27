//
//  CarPlaySceneDelegate.swift
//  tankille
//
//  Created by Leevi Aattola on 27.7.2023.
//

import CarPlay
import MapKit

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
  private var interfaceController: CPInterfaceController?
  private var templateApplicationScene: CPTemplateApplicationScene?

  /// 1. CarPlay connected
  func templateApplicationScene(
    _ templateApplicationScene: CPTemplateApplicationScene,
    didConnect interfaceController: CPInterfaceController
  ) {
    // 2
    self.interfaceController = interfaceController
    self.templateApplicationScene = templateApplicationScene

    // 3
    setInformationTemplate()
  }

  /// 4. Information template
  private func setInformationTemplate() {
    // 5 - Setting the content for the template
    
    let location = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(61.492295), longitude: CLLocationDegrees(23.771604))))
    
    let POI = CPPointOfInterest(location: location, title: "Neste K Hatanpää", subtitle: "Tankki", summary: "Mene tänne tankkaamaan", detailTitle: "DTitle", detailSubtitle: "DSubtitle", detailSummary: "DSum", pinImage: UIImage(systemName: "hand.point.down"))
    
    POI.primaryButton = CPTextButton(title: "Navigoi", textStyle: .confirm, handler: {_ in
      print("NAVIGATE")
      
      MKMapItem.openMaps(with: [location])
    
    })
    
    let POITemplate = CPPointOfInterestTemplate(title: "CPPOint", pointsOfInterest: [POI], selectedIndex: 0)
    
    let actionsheet = CPActionSheetTemplate(title: "Joujou", message: "Oletko testissä", actions: [
      CPAlertAction(title: "Ok", color: .red, handler: { [self]_ in
        
        interfaceController?.dismissTemplate(animated: true, completion: nil)
      }),
      
      CPAlertAction(title: "En", style: .destructive, handler: {_ in
        self.interfaceController?.dismissTemplate(animated: true, completion: {_,_  in
          self.interfaceController?.pushTemplate(POITemplate, animated: true, completion: nil)
        })
      })
    ])
    
    
    let items: [CPInformationItem] = [
      CPInformationItem(
        title: "Template type",
        detail: "Information Template (CPInformationTemplate)"
      )
    ]
    
    let actions: [CPTextButton] = [
      CPTextButton(title: "Nappula", textStyle: .normal) {_ in
        print("Kissa")
        self.interfaceController?.presentTemplate(actionsheet, animated: true, completion: nil)
      }
    ]

    // 6 - Selecting the template
    let infoTemplate = CPInformationTemplate(title: "My first template",
                                             layout: .leading,
                                             items: items,
                                             actions: actions)

    // 7 - Setting the information template as the root template
    interfaceController?.setRootTemplate(infoTemplate,
                                         animated: true,
                                         completion: { success, error in
                                           debugPrint("Success: \(success)")

                                           if let error = error {
                                             debugPrint("Error: \(error)")
                                           }
                                         })
  }
}
