//
//  Alamofire.SessionManager+ephemeralRequest.swift
//  Custed
//
//  Created by faker on 2019/4/12.
//  Copyright © 2019 Toast. All rights reserved.
//

import Foundation
import Alamofire
extension SessionManager {
    public static let ephemeral : SessionManager = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return SessionManager(configuration: configuration)
    }()
}
