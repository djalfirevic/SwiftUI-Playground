//
//  ProSwiftUITests.swift
//  ProSwiftUITests
//
//  Created by Paul Hudson on 03/09/2022.
//

@testable import ProSwiftUI
import XCTest

// Safety check that all the chapter titles have matching SwiftUI views.
final class ProSwiftUITests: XCTestCase {
    let book = Book()

    func testAllViewsLoad() throws {
        for section in book.sections {
            for chapter in section.chapters {
                _ = chapter.makeView()
            }
        }
        
        // if we made it here, all the views loaded! 😂
    }
}
