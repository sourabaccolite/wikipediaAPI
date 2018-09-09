//
//  WikiDataModel.swift
//  MoneytapWikiProjectBySourab
//
//  Created by Sourab on 08/09/18.
//  Copyright © 2018 Sourab. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
// let wikiDataModel = try WikiDataModel(json)

import Foundation

class WikiDataModel: Codable {
    let wikiDataModelContinue: Continue?
    let query: Query?
    
    enum CodingKeys: String, CodingKey {
        case wikiDataModelContinue = "continue"
        case query
    }
    
    init(wikiDataModelContinue: Continue?, query: Query?) {
        self.wikiDataModelContinue = wikiDataModelContinue
        self.query = query
    }
}

class Query: Codable {
    let pages: [Page]?
    
    init(pages: [Page]?) {
        self.pages = pages
    }
}

class Page: Codable {
    let pageid, ns: Int?
    let title: String?
    let index: Int?
    let thumbnail: Thumbnail?
    let terms: Terms?
    
    init(pageid: Int?, ns: Int?, title: String?, index: Int?, thumbnail: Thumbnail?, terms: Terms?) {
        self.pageid = pageid
        self.ns = ns
        self.title = title
        self.index = index
        self.thumbnail = thumbnail
        self.terms = terms
    }
}

class Terms: Codable {
    let description: [String]?
    
    init(description: [String]?) {
        self.description = description
    }
}

class Thumbnail: Codable {
    let source: String?
    let width, height: Int?
    
    init(source: String?, width: Int?, height: Int?) {
        self.source = source
        self.width = width
        self.height = height
    }
}

class Continue: Codable {
    let picontinue: Int?
    let continueContinue: String?
    
    enum CodingKeys: String, CodingKey {
        case picontinue
        case continueContinue = "continue"
    }
    
    init(picontinue: Int?, continueContinue: String?) {
        self.picontinue = picontinue
        self.continueContinue = continueContinue
    }
}

// MARK: Convenience initializers and mutators
extension WikiDataModel {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(WikiDataModel.self, from: data)
        self.init(wikiDataModelContinue: me.wikiDataModelContinue, query: me.query)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        wikiDataModelContinue: Continue?? = nil,
        query: Query?? = nil
        ) -> WikiDataModel {
        return WikiDataModel(
            wikiDataModelContinue: wikiDataModelContinue ?? self.wikiDataModelContinue,
            query: query ?? self.query
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Query {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Query.self, from: data)
        self.init(pages: me.pages)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        pages: [Page]?? = nil
        ) -> Query {
        return Query(
            pages: pages ?? self.pages
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Page {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Page.self, from: data)
        self.init(pageid: me.pageid, ns: me.ns, title: me.title, index: me.index, thumbnail: me.thumbnail, terms: me.terms)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        pageid: Int?? = nil,
        ns: Int?? = nil,
        title: String?? = nil,
        index: Int?? = nil,
        thumbnail: Thumbnail?? = nil,
        terms: Terms?? = nil
        ) -> Page {
        return Page(
            pageid: pageid ?? self.pageid,
            ns: ns ?? self.ns,
            title: title ?? self.title,
            index: index ?? self.index,
            thumbnail: thumbnail ?? self.thumbnail,
            terms: terms ?? self.terms
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Terms {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Terms.self, from: data)
        self.init(description: me.description)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        description: [String]?? = nil
        ) -> Terms {
        return Terms(
            description: description ?? self.description
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Thumbnail {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Thumbnail.self, from: data)
        self.init(source: me.source, width: me.width, height: me.height)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        source: String?? = nil,
        width: Int?? = nil,
        height: Int?? = nil
        ) -> Thumbnail {
        return Thumbnail(
            source: source ?? self.source,
            width: width ?? self.width,
            height: height ?? self.height
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Continue {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Continue.self, from: data)
        self.init(picontinue: me.picontinue, continueContinue: me.continueContinue)
    }
    
    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        picontinue: Int?? = nil,
        continueContinue: String?? = nil
        ) -> Continue {
        return Continue(
            picontinue: picontinue ?? self.picontinue,
            continueContinue: continueContinue ?? self.continueContinue
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
