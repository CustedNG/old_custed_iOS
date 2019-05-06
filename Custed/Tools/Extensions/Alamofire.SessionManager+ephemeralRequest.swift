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
        configuration.timeoutIntervalForRequest = TimeInterval.init(5.0)
        configuration.timeoutIntervalForResource = TimeInterval.init(10.0)
        configuration.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.never
        configuration.httpShouldSetCookies = false // Don't set cookies for request through this property
        return SessionManager(configuration: configuration)
    }()
    public static let timeOut : SessionManager = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        config.timeoutIntervalForRequest = TimeInterval.init(5.0)
        config.timeoutIntervalForResource = TimeInterval.init(10.0)
        config.httpCookieAcceptPolicy = HTTPCookie.AcceptPolicy.onlyFromMainDocumentDomain // default setting
        config.httpShouldSetCookies = true
        return SessionManager(configuration: config)
    }()
}
