//
//  GeneralProvider.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation
import Moya

final class GeneralProvider {
    
    // MARK: - Public Variables
    var provider: MoyaProvider<GeneralService>
    var stubProvider: MoyaProvider<GeneralService>
    
    // MARK: - Private Variables
    private var networkLoggerPlugin = NetworkLoggerPlugin(configuration: .init(formatter: .init(), output: { (target, array) in
        if let log = array.first {
            print(log)
        }
    }, logOptions: .formatRequestAscURL))

    
    // MARK: - Init
    init() {
        let plugins: [PluginType] = [networkLoggerPlugin]
        
        self.provider = MoyaProvider(plugins: plugins)
        self.stubProvider = MoyaProvider(stubClosure: MoyaProvider<GeneralService>.immediatelyStub)
    }
}
