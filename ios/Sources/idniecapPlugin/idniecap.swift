import Foundation

@objc public class idniecap: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    @objc public func configure(_ apiKey: String)  {
        print("Configure en iDNIe")
        print(apiKey)
        
    }

    @objc public func readPassport(_ accessKey: String, _ paceKeyReference: Int) {
        print("readPassport en iDNIe")
        print(accessKey)
        print(paceKeyReference)

    }
}
