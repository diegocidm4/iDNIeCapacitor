import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(idniecapPlugin)
public class idniecapPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "idniecapPlugin"
    public let jsName = "idniecap"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "configure", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getMRZKey", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "readPassport", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signTextDNIe", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signDocumentDNIe", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "signHashDNIe", returnType: CAPPluginReturnPromise),
//        CAPPluginMethod(name: "authenticationDNIeOpenSession", returnType: CAPPluginReturnPromise),
//        CAPPluginMethod(name: "signChallengeDNIe", returnType: CAPPluginReturnPromise),
    ]
    private let implementation = idniecap()
    
    @objc func configure(_ call: CAPPluginCall) {
        let apiKey = call.getString("apiKey") ?? ""

        let resultado = implementation.configure(apiKey)
        
        var json: [String: Any] = [:]
        json["descripcion"] = resultado.descripcion
        json["APIKeyValida"] = resultado.APIKeyValida
        json["lecturaDGHabilitada"] = resultado.lecturaDGHabilitada
        json["autenticacionHabilitada"] = resultado.autenticacionHabilitada
        json["firmaHabilitada"] = resultado.firmaHabilitada
        
        call.resolve(json)
    }

    @objc func getMRZKey(_ call: CAPPluginCall) {
        let passportNumber = call.getString("passportNumber") ?? ""
        let dateOfBirth = call.getString("dateOfBirth") ?? ""
        let dateOfExpiry = call.getString("dateOfExpiry") ?? ""

        let mrzKey = implementation.getMRZKey(passportNumber, dateOfBirth, dateOfExpiry)
        
        var json: [String: Any] = [:]
        json["mrzKey"] = mrzKey
        call.resolve(json)
    }

    @objc func readPassport(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let paceKeyReference = call.getInt("paceKeyReference") ?? 0
        let tags = call.getArray("tags") ?? []
        
        let json = implementation.readPassport(accessKey, paceKeyReference, tags as! [String])
        
        call.resolve(json)
    }

    @objc func signTextDNIe(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let pin = call.getString("pin") ?? ""
        let datosFirma = call.getString("datosFirma") ?? ""
        let certToUse = call.getString("certToUse") ?? ""
        
        let json = implementation.signTextDNIe(accessKey, pin, datosFirma, certToUse)
        
        call.resolve(json)
        
    }

    @objc func signDocumentDNIe(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let pin = call.getString("pin") ?? ""
        let document = call.getString("document") ?? ""
        let certToUse = call.getString("certToUse") ?? ""

        let json = implementation.signDocumentDNIe(accessKey, pin, document, certToUse)
        
        call.resolve(json)
    }

    @objc func signHashDNIe(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let pin = call.getString("pin") ?? ""
        let hash = call.getArray("hash") ?? []
        let digest = call.getInt("digest") ?? 0
        let certToUse = call.getString("certToUse") ?? ""
            
        let json = implementation.signHashDNIe(accessKey, pin, hash as! [UInt8], digest, certToUse)
        
        call.resolve(json)
    }
}
