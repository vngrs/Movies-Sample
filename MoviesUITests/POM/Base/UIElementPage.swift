//
//  UIElementPage.swift
//  MoviesUITests
//
//  Created by Ahmed Abdurrahman on 7/27/20.
//  Copyright © 2020 VNGRS. All rights reserved.
//

import XCTest

class UIElementPage<T: UIElement>: Page {

    override init(element: XCUIElement) {
        super.init(element: element)
    }

    init(root: T) {
        super.init(rootIdentifier: root.accessibilityIdentifier)
    }

    func label(_ element: T) -> XCUIElement {
        return self.element.staticTexts[element.accessibilityIdentifier]
    }

    func textField(_ element: T) -> XCUIElement {
        return self.element.textFields[element.accessibilityIdentifier]
    }

    func textView(_ element: T) -> XCUIElement {
        return self.element.textViews[element.accessibilityIdentifier]
    }

    func staticText(_ element: T) -> XCUIElement {
        return self.element.staticTexts[element.accessibilityIdentifier]
    }

    func button(_ element: T) -> XCUIElement {
        return self.element.buttons[element.accessibilityIdentifier]
    }

    func image(_ element: T) -> XCUIElement {
        return self.element.images[element.accessibilityIdentifier]
    }

    func table(_ element: T) -> XCUIElement {
        return self.element.tables[element.accessibilityIdentifier]
    }

    func collection(_ element: T) -> XCUIElement {
        return self.element.collectionViews[element.accessibilityIdentifier]
    }

    func otherElement(_ element: T) -> XCUIElement {
        return self.element.otherElements[element.accessibilityIdentifier]
    }
}
