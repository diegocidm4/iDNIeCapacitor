import Foundation

@objc public class idniecap: NSObject {

    @objc public func configure(_ apiKey: String)  {
        print("Configure en iDNIe")
        print(apiKey)
        
    }

    @objc public func getMRZKey(_ passportNumber: String,_ dateOfBirth: String,_ dateOfExpiry: String)  {
        print("getMRZKey en iDNIe")
        
    }

    @objc public func readPassport(_ accessKey: String, _ paceKeyReference: Int,_ tags: [String]) {
        print("readPassport en iDNIe")
        print(accessKey)
        print(paceKeyReference)

    }

    @objc public func signTextDNIe(_ accessKey: String, _ pin: String,_ datosFirma: String,_ certToUse: String) {
        print("signTextDNIe en iDNIe")

    }

    @objc public func signDocumentDNIe(_ accessKey: String, _ pin: String,_ document: String,_ certToUse: String) {
        print("signTextDNIe en iDNIe")

    }

    @objc public func signHashDNIe(_ accessKey: String, _ pin: String,_ hash: String,_ digest: String,_ certToUse: String) {
        print("signTextDNIe en iDNIe")

    }
/*
    @objc public func authenticationDNIeOpenSession(_ accessKey: String, _ pin: String) {
        print("signTextDNIe en iDNIe")

    }

    @objc public func signChallengeDNIe(_ hash: String, _ digest: String,_ signPadding: String) {
        print("signTextDNIe en iDNIe")

    }
 */
}
