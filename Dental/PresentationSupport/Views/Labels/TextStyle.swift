//
//  LabelStyle.swift
//  Dental
//
//  Created by Igor Sorokin on 06.01.2020.
//  Copyright © 2020 Igor Sorokin. All rights reserved.
//

import UIKit

enum LabelStyle {
    static let mediumTitle: TextStyle               = .init(numberOfLines: 2, textAttributes: .mediumTitle)
    
    static let smallDescription: TextStyle          = .init(numberOfLines: 2, textAttributes: .smallDescription)
    
    static let description: TextStyle               = .init(numberOfLines: 0, textAttributes: .smallDescription)
    
    static let secondaryDescription: TextStyle      = .init(numberOfLines: 0, textAttributes: .secondaryDescription)
    
    static let warning: TextStyle                   = .init(numberOfLines: 0, textAttributes: .warning)
                
    static let largeTitle: TextStyle                = .init(numberOfLines: 0, textAttributes: .largeTitle)
                
    static let defaultTitle: TextStyle              = .init(numberOfLines: 0, textAttributes: .defaultTitle)
    
    static let appTitle: TextStyle                  = .init(numberOfLines: 0, textAttributes: .appTitle)
    
    static let mediumDescription: TextStyle         = .init(numberOfLines: 0, textAttributes: .mediumDescription)
    
    static let activeDescription: TextStyle         = .init(numberOfLines: 0, textAttributes: .activeDescription)
    
    static let activeTitle: TextStyle               = .init(numberOfLines: 0, textAttributes: .activeTitle)
    
    static let centerDescription: TextStyle         = .init(numberOfLines: 0, textAttributes: .centerDescription)
    
}

// MARK: - NSAttributed String Styles

extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    
    static let mediumTitle: [NSAttributedString.Key: Any]       = [.foregroundColor: UIColor.common,
                                                                  .font: Fonts.appleFont(of: 18, weight: .semibold)]
    
    static let smallDescription: [NSAttributedString.Key: Any]  = [.foregroundColor: UIColor.common,
                                                                  .font: Fonts.appleFont(of: 14, weight: .regular)]
    
    static let warning: [NSAttributedString.Key: Any]           = [.foregroundColor: UIColor.common,
                                                                  .font: Fonts.appleFont(of: 14, weight: .regular),
                                                                  .paragraphStyle: NSParagraphStyle.center]
    
    static let largeTitle: [NSAttributedString.Key: Any]        = [.foregroundColor: UIColor.common,
                                                                  .font: Fonts.appleFont(of: 28, weight: .bold)]
    
    static let mediumDescription: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.common,
                                                                   .font: Fonts.appleFont(of: 18, weight: .regular)]
    
    static let defaultTitle: [NSAttributedString.Key: Any]      = [.foregroundColor: UIColor.common,
                                                                   .font: Fonts.appleFont(of: 24, weight: .semibold)]
    
    static let secondaryDescription: [NSAttributedString.Key: Any]  = [.foregroundColor: UIColor.secondaryCommon,
                                                                       .font: Fonts.appleFont(of: 14, weight: .medium)]
    
    static let appTitle: [NSAttributedString.Key: Any]          = [.foregroundColor: UIColor.app,
                                                                   .font: Fonts.appleFont(of: 28, weight: .semibold)]
    
    static let activeDescription: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.app,
                                                                   .font: Fonts.appleFont(of: 16, weight: .regular)]
    
    static let activeTitle: [NSAttributedString.Key: Any]       = [.foregroundColor: UIColor.common,
                                                                  .font: Fonts.appleFont(of: 18, weight: .semibold),
                                                                  .paragraphStyle: NSParagraphStyle.center]
    
    static let centerDescription: [NSAttributedString.Key: Any]  = [.foregroundColor: UIColor.secondaryCommon,
                                                                       .font: Fonts.appleFont(of: 14, weight: .medium),
                                                                       .paragraphStyle: NSParagraphStyle.center]
    
}

// MARK: - NSParagraphStyle

extension NSParagraphStyle {
    
    static let center: NSParagraphStyle = {
       let centerStyle = NSMutableParagraphStyle()
        centerStyle.alignment = .center
        return centerStyle
    }()
    
}
