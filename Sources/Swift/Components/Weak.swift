//
// Weak.swift
//
// Copyright © 2017 Zeeshan Mian
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import Foundation

/// A generic class to hold a weak reference to a type `T`.
/// This is useful for holding a reference to nullable object.
///
/// ```swift
/// let views = [Weak<UIView>]()
/// ```
open class Weak<T: AnyObject>: Equatable, Hashable {
    open weak var value: T?

    public init (value: T) {
        self.value = value
    }

    public var hashValue: Int {
        guard let value = value else {
            return Unmanaged<AnyObject>.passUnretained(self).toOpaque().hashValue
        }

        if let value = value as? AnyHashable {
            return value.hashValue
        }

        return Unmanaged<AnyObject>.passUnretained(value).toOpaque().hashValue
    }

    public static func ==<T>(lhs: Weak<T>, rhs: Weak<T>) -> Bool {
        return lhs.value === rhs.value
    }
}

extension NSObject {
    var memoryAddress: String {
        return String(describing: Unmanaged<NSObject>.passUnretained(self).toOpaque())
    }
}
