//
//  DocumentManager.swift
//  UtilsKit
//
//  Created by RGMC & RGMC on 23/08/2017.
//  Copyright © 2017 RGMC. All rights reserved.
//

import Foundation

/**
    Manager providing methods to save and retrieve files from local directories.
    This class makes the use of paths abtract and let you manage files with only names.
 */
public struct DocumentManager {
    
    // MARK: Static
    
    /** Instance of the manager based on the document directory. */
    public static let document = DocumentManager(directory: .documentDirectory, mask: .userDomainMask)
    
    /** Instance of the manager based on the cache directory. */
    public static let cache = DocumentManager(directory: .cachesDirectory, mask: .userDomainMask)
    
    // MARK: Variables
    private let fileManager: FileManager = FileManager.default
    private var documentURL: URL?
    
    // MARK: Init
    
    
    /**
        Custom initializer to choose the directory used to manage files.
     
        - parameter directory: search path of the local directory.
     
        - parameter mask: mask domain of the directory.
     */
    public init(directory: FileManager.SearchPathDirectory, mask: FileManager.SearchPathDomainMask) {
        if let url: URL = self.fileManager.urls(for: directory, in: mask).first {
            self.documentURL = url
        }
    }
    
    // MARK: Utils

    // Generate the url of the file with given name, based on the choosen directory.
    private func getURL(forDocumentNamed name: String?) -> URL? {
        guard let name = name else { return nil }
        return self.documentURL?.appendingPathComponent(name)
    }
    
    /**
     Create a directory.
     Intermediate directories creation is possible.
     
     - parameter name: name of the directory.
     
     - parameter withIntermediateDirectories: indicate if the intermediate directories need to be created. Default to true.
     
     - parameter attributes: file attributes.
     */
    public func create(directoryNamed name: String, withIntermediateDirectories: Bool = true, attributes: [FileAttributeKey: Any]? = nil) {
        if let directoryPath: String = self.documentURL?.appendingPathComponent(name).path {
            do {
                try self.fileManager.createDirectory(atPath: directoryPath,
                                                     withIntermediateDirectories: withIntermediateDirectories,
                                                     attributes: attributes)
            } catch {
                log(.file, "Creating directory at path \(directoryPath)", error: error)
            }
        }
    }
    
    // MARK: Save
    
    /**
     Save data in a file.
     
     - parameter data: data to save in the file.
     
     - parameter name: file name.
     */
    public func save(data: Data, forDocumentNamed name: String) {
        if let fullURL: URL = self.getURL(forDocumentNamed: name) {
            do {
                try data.write(to: fullURL, options: .atomicWrite)
            } catch {
                log(.file, "Saving data to document named \(name)", error: error)
            }
        }
    }
    
    // MARK: Get
    
    /**
     Get the content of a file.
     
     - parameter name: file name to retrieve.
     
     - returns: data of the retrieved file or nil.
     */
    public func content(ofDocumentNamed name: String) -> Data? {
        guard let url: URL = self.getURL(forDocumentNamed: name) else { return nil }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            log(.file, "Getting content of document at url \(url)", error: error)
            return nil
        }
    }
    
    // MARK: Remove
    
    /**
     Remove a file.
     
     - parameter name: file name to remove.
     */
    public func remove(documentNamed name: String?) {
        self.remove(documentAtURL: self.getURL(forDocumentNamed: name))
    }
    
    /**
     Remove a file.
     
     - parameter url: file url to remove.
     */
    public func remove(documentAtURL url: URL?) {
        guard let url = url else { return }
        do {
            try self.fileManager.removeItem(at: url)
        } catch {
            log(.file, "Deleting document at url \(url)", error: error)
        }
    }
    
    // MARK: Condition
    
    /**
     Check if the file exists.
     
     - parameter name: name of the file.
     
     - returns: a `boolean` value indicating if the file exists.
     */
    public func exists(documentNamed name: String?) -> Bool {
        self.exists(documentAtURL: self.getURL(forDocumentNamed: name))
    }
    
    /**
     Check if the file exists.
     
     - parameter url: url of the file.
     
     - returns: a `boolean` value indicating if the file exists.
     */
    public func exists(documentAtURL url: URL?) -> Bool {
        guard let url: URL = url else { return false }
        return self.fileManager.fileExists(atPath: url.path)
    }
}
