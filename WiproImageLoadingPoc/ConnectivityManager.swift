//
//  ConnectivityManager.swift
//  WiproImageLoadingPoc
//
//  Created by Mushaffiq on 7/10/18.
//  Copyright © 2018 Vijay. All rights reserved.
//

import Foundation

import Alamofire

class ConnectivityManager {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
