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
  
  private func kissa () async {
    do {
      try await self.interfaceController?.dismissTemplate(animated: true)
    } catch {
      print("Kusi")
    }
  }

  /// 4. Information template
  private func setInformationTemplate() {
    // 5 - Setting the content for the template
    
    guard let interfaceController = self.interfaceController else {return}
    
    let POI = JFPointOfInterest(interfaceController: self.interfaceController!, templateApplicationScene: self.templateApplicationScene).getPointOfInterestTemplate()
    
    
    let actionsheet = CPActionSheetTemplate(title: "Joujou", message: "Oletko testissä", actions: [
      CPAlertAction(title: "Ok", color: .red, handler: {_ in
      
        Task {
          await self.kissa()
        }
   
      }),
      
      CPAlertAction(title: "En", style: .destructive, handler: {_ in
        interfaceController.dismissTemplate(animated: true, completion: {_,_  in
          interfaceController.pushTemplate(POI, animated: true, completion: nil)
        })
      })
    ])
    
    
    let items: [CPInformationItem] = [
      CPInformationItem(
        title: "Kyllä infoa",
        detail: "Detaileja"
      )
    ]
    
    let actions: [CPTextButton] = [
      CPTextButton(title: "Nappula", textStyle: .normal) {_ in
        print("Kissa")
        interfaceController.presentTemplate(actionsheet, animated: true, completion: nil)
      },
      CPTextButton(title: "Suoraan karttaan", textStyle: .confirm) {_ in
        Task {
          try await interfaceController.pushTemplate(POI, animated: true)
        }
      }
    ]

    // 6 - Selecting the template
    let infoTemplate = CPInformationTemplate(title: "Tankille?",
                                             layout: .twoColumn,
                                             items: items,
                                             actions: actions)

    // 7 - Setting the information template as the root template
    interfaceController.setRootTemplate(infoTemplate,
                                         animated: true,
                                         completion: { success, error in
                                           debugPrint("Success: \(success)")

                                           if let error = error {
                                             debugPrint("Error: \(error)")
                                           }
                                         })
  }
}
