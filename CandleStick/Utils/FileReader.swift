//
//  FileReader.swift
//  CandleStick
//
//  Created by Maksym Leshchenko on 10.08.2020.
//  Copyright © 2020 Micro-B. All rights reserved.
//

import Foundation

protocol FileReader {
    func readFile(name: String, type: String) throws -> Data
}

enum FileReaderError: Error {
    case fileNotFound(fileName: String)
    case cannotReadFile(fileName: String)
    
    var localizedDescription: String {
        switch self {
        case .cannotReadFile(let fileName):
            return "Cannot read the file \(fileName)."
        case .fileNotFound(let fileName):
            return "File not found \(fileName)."
        }
    }
}

final class JsonFileReader: FileReader {
    func readFile(name: String, type: String) throws -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw FileReaderError.fileNotFound(fileName: name)
        }
        
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
            return jsonData
        } catch {
            throw FileReaderError.cannotReadFile(fileName: name)
        }
    }
}

