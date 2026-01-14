//
//  Extensions.swift
//  JesterTwistKit
//
//  Created by Роман Главацкий on 29.10.2025.
//

import Foundation
import AppsFlyerLib

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        guard let data = conversionInfo as? [String: Any] else { return }
        print("📦 AppsFlyer data received: \(data)")

        let appsflyerID = AppsFlyerLib.shared().getAppsFlyerUID()
        
        let isOrganic = (data["af_status"] as? String)?.lowercased() == "organic"
        let rawCampaign = isOrganic ? "organic" : (data["campaign"] as? String ?? "")
        
        var campaign = rawCampaign
        var sub1 = ""
        var sub2 = ""
        var sub3 = ""
        var sub4 = ""
        var sub5 = ""
        var sub6 = ""

        if !isOrganic {
            let parts = rawCampaign.components(separatedBy: "_")
            
            if parts.count >= 2 {
                campaign = parts[0]
                
                sub1 = parts.indices.contains(1) ? parts[1] : ""
                sub2 = parts.indices.contains(2) ? parts[2] : ""
                sub3 = parts.indices.contains(3) ? parts[3] : ""
                sub4 = parts.indices.contains(4) ? parts[4] : ""
                sub5 = parts.indices.contains(5) ? parts[5] : ""
                sub6 = parts.indices.contains(6) ? parts[6] : ""
            }
        }

        
        let finalURL = """
        appsflyer_id=\(appsflyerID)&campaign=\(campaign)&sub1=\(sub1)&sub2=\(sub2)&sub3=\(sub3)&sub4=\(sub4)&sub5=\(sub5)&sub6=\(sub6)
        """

        print("✅ Final URL: \(finalURL)")
        UserDefaults.standard.set(finalURL, forKey: "finalAppsflyerURL")
        NotificationCenter.default.post(name: Notification.Name("AppsFlyerDataReceived"), object: nil)
    }

    func onConversionDataFail(_ error: Error) {
        print("❌ Conversion data error: \(error.localizedDescription)")
    }
}


