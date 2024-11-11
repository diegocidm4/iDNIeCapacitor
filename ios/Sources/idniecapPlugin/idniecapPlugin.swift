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
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "configure", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "readPassport", returnType: CAPPluginReturnPromise),
    ]
    private let implementation = idniecap()
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func configure(_ call: CAPPluginCall) {
        let apiKey = call.getString("apiKey") ?? ""
        print("ApiKey: " + apiKey)
//        iDNIe.configure(apiKey:apiKey)
        //Comentario nuevo
        
        call.resolve()
    }

    @objc func readPassport(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let paceKeyReference = call.getInt("paceKeyReference") ?? 0
        
        print("AccessKey: " + accessKey + " paceKeyReference: " + String(paceKeyReference))
        
/*
        call.resolve([
            "dni": "44470662R"
        ])
*/
        call.resolve()        
    }

}
