//
//  DateFormatterPool.swift
//  BasicUse
//
//  Created by Mike on 28/08/2017.
//  Copyright © 2017 Mike. All rights reserved.
//

import Foundation

final class DateFormatterPool {
    
    // Public method
    
    
    /// Get DateFormatter by formatter and local
    ///
    /// - Parameters:
    ///   - formatter: Date Formatter String
    ///   - local: Date Formatter's local instance
    /// - Returns: Specific Date Formatter
    public func dateFormatter(formatter: String, local: Locale) -> DateFormatter {
    
        let keyString = formatterKey(formatter: formatter, localIdentifier: local.identifier)
        var dateFormatter = formatterCache.object(forKey: keyString as AnyObject)
        
        if let dateFormat = dateFormatter {
            
            return dateFormat
        }
        
        dateFormatter = DateFormatter()
        dateFormatter?.locale = local 
        dateFormatter?.dateFormat = formatter
        formatterCache.setObject(dateFormatter!, forKey: keyString as AnyObject)
        return dateFormatter!
    }
    
    /// Get DateFormatter by formatter and local
    ///
    /// - Parameters:
    ///   - formatter: Date Formatter String
    ///   - localIdentifier: Date Formatter's local identifier
    /// - Returns: Specific Date Formatter
    public func dateFormatter(formatter: String, localIdentifier: String) ->DateFormatter {
        
        let local = Locale.init(identifier: localIdentifier)
        return dateFormatter(formatter: formatter, local: local)
    }
    
    /// Get DateFormatter by formatter, the default local is current local
    ///
    /// - Parameters:
    ///   - formatter: Date Formatter String
    /// - Returns: Specific Date Formatter
    public func dateFormatter(formatter: String) ->DateFormatter {
        
        return dateFormatter(formatter: formatter, local: NSLocale.current)
    }
    
    /// Get DateFormatter by date style, time style and local
    ///
    /// - Parameters:
    ///   - dateStyle: date style
    ///   - timeStyle: time style
    ///   - local: Date Formatter's local instance
    /// - Returns: Specific Date Formatter
    public func dateFormatter(dateStyle:  DateFormatter.Style, timeStyle: DateFormatter.Style, local: Locale) ->DateFormatter {
    
        let formatKey = formatterKey(dateStyle: dateStyle, timeStyle: timeStyle, localIdentifier: local.identifier)
        
        var formatter = formatterCache.object(forKey: formatKey as AnyObject)
        if let format = formatter {
            
            return format
        }
        formatter = DateFormatter()
        formatter?.dateStyle = dateStyle
        formatter?.timeStyle = timeStyle
        formatter?.locale = local
        
        formatterCache.setObject(formatter!, forKey: formatKey as AnyObject)
        return formatter!
    }
    
    /// Get DateFormatter by date style, time style and local
    ///
    /// - Parameters:
    ///   - dateStyle: date style
    ///   - timeStyle: time style
    ///   - localIdentifier: Date Formatter's local identifier
    /// - Returns: Specific Date Formatter
    public func dateFormatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, localIdentifier: String) -> DateFormatter {
    
        let local = Locale.init(identifier: localIdentifier)
        return dateFormatter(dateStyle: dateStyle, timeStyle: timeStyle, local: local)
    }
    
    
    /// Get DateFormatter by date style, time style and local is the default one
    ///
    /// - Parameters:
    ///   - dateStyle: date style
    ///   - timeStyle: time style
    /// - Returns: Specific Date Formatter
    public func dateFormatter(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> DateFormatter {
        
        return dateFormatter(dateStyle: dateStyle, timeStyle: timeStyle, local: Locale.current)
    }
    
    // Initialize method
    static let shared = DateFormatterPool()
    private let  formatterCache = NSCache<AnyObject, DateFormatter>()
    private init() {}
    // Private method
    private func formatterKey(formatter: String, localIdentifier: String) -> String {
    
        return formatter + "|" + localIdentifier
        
    }
    
    private func formatterKey(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style, localIdentifier: String) -> String {
    
        return String(describing: dateStyle.rawValue) + "." + String(describing: timeStyle.rawValue) + localIdentifier
        
    }
    
}
