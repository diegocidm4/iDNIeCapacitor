import Foundation
import Capacitor
import iDNIe

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
        //CAPPluginMethod(name: "readPassport", returnType: CAPPluginReturnCallback),
    ]
    private let implementation = idniecap()

    private var passportReader: PassportReader? = nil
    private var passportSelected: NFCPassportModel? = nil
    
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func configure(_ call: CAPPluginCall) {
        let apiKey = call.getString("apiKey") ?? ""

        let resultado = iDNIe.configure(apiKey:apiKey)
        
        var json: [String: Any] = [:]
        json["descripcion"] = resultado.descripcion
        json["APIKeyValida"] = resultado.APIKeyValida
        json["lecturaDGHabilitada"] = resultado.lecturaDGHabilitada
        json["autenticacionHabilitada"] = resultado.autenticacionHabilitada
        json["firmaHabilitada"] = resultado.firmaHabilitada
        
        call.resolve(json)
    }

    @objc func readPassport(_ call: CAPPluginCall) {
        let accessKey = call.getString("accessKey") ?? ""
        let paceKeyReference = call.getInt("paceKeyReference") ?? 0
        var paceReference = PACEHandler.CAN_PACE_KEY_REFERENCE
        
        switch paceKeyReference
        {
            case 0: paceReference = PACEHandler.NO_PACE_KEY_REFERENCE
                    break;
            case 1: paceReference = PACEHandler.MRZ_PACE_KEY_REFERENCE
                    break;
            case 2: paceReference = PACEHandler.CAN_PACE_KEY_REFERENCE
                    break;
            default:paceReference = PACEHandler.NO_PACE_KEY_REFERENCE
                    break;

        }
        
        passportReader = PassportReader()
        
        let passportUtils = PassportUtils()
        passportReader?.passiveAuthenticationUsesOpenSSL = true

        var lecturaCompleta = false;
        var datosDNIe: DatosDNIe? = nil;
        var errorText: String? = nil;
        
        passportReader?.readPassport(accessKey: accessKey, paceKeyReference: paceReference, tags: [], skipSecureElements: true, customDisplayMessage: { (displayMessage) in  return NFCUtils.customDisplayMessage(displayMessage: displayMessage)
        }, completed: { (passport, error) in
            if let passport = passport {
                datosDNIe = DNIeUtils.obtenerTodosDatosDNIe(dnie: passport)
                self.passportSelected = datosDNIe?.getPassport()
            } else {
                errorText = error?.localizedDescription
                print("[NFC] - Error\(error?.localizedDescription)")
            }
            lecturaCompleta = true
        })

        while(!lecturaCompleta)
        {
            
        }

        var jsonDatosDNIe: [String: Any]? = nil
        if(datosDNIe != nil)
        {
            var base64Foto = ""
            if(datosDNIe?.getImagen() != nil)
            {
                base64Foto = DNIeUtils.convertImageToBase64(image: (datosDNIe?.getImagen())!)
            }

            var base64Firma = ""
            if(datosDNIe?.getFirma() != nil)
            {
                base64Firma = DNIeUtils.convertImageToBase64(image: (datosDNIe?.getFirma())!)
            }

            var jsonDatosCertAut: [String: Any] = [:]
            if(datosDNIe?.getcertificadoAutenticacion() != nil)
            {
                if(datosDNIe?.getcertificadoAutenticacion()?.nif != nil)
                {
                    jsonDatosCertAut["nif"] = datosDNIe?.getcertificadoAutenticacion()?.nif
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.nombre != nil)
                {
                    jsonDatosCertAut["nombre"] = datosDNIe?.getcertificadoAutenticacion()?.nombre
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.apellidos != nil)
                {
                    jsonDatosCertAut["apellidos"] = datosDNIe?.getcertificadoAutenticacion()?.apellidos
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.fechaNacimiento != nil)
                {
                    jsonDatosCertAut["fechaNacimiento"] = datosDNIe?.getcertificadoAutenticacion()?.fechaNacimiento
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.tipo != nil)
                {
                    jsonDatosCertAut["tipo"] = datosDNIe?.getcertificadoAutenticacion()?.tipo
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.nifRepresentante != nil)
                {
                    jsonDatosCertAut["nifRepresentante"] = datosDNIe?.getcertificadoAutenticacion()?.nifRepresentante
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.nombreRepresentante != nil)
                {
                    jsonDatosCertAut["nombreRepresentante"] = datosDNIe?.getcertificadoAutenticacion()?.nombreRepresentante
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.apellidosRepresentante != nil)
                {
                    jsonDatosCertAut["apellidosRepresentante"] = datosDNIe?.getcertificadoAutenticacion()?.apellidosRepresentante
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.fechaInicioValidez != nil)
                {
                    jsonDatosCertAut["fechaInicioValidez"] = datosDNIe?.getcertificadoAutenticacion()?.fechaInicioValidez
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.fechaFinValidez != nil)
                {
                    jsonDatosCertAut["fechaFinValidez"] = datosDNIe?.getcertificadoAutenticacion()?.fechaFinValidez
                }

                if(datosDNIe?.getcertificadoAutenticacion()?.estado != nil)
                {
                    jsonDatosCertAut["estado"] = datosDNIe?.getcertificadoAutenticacion()?.estado
                }
                
                if(datosDNIe?.getcertificadoAutenticacion()?.email != nil)
                {
                    jsonDatosCertAut["email"] = datosDNIe?.getcertificadoAutenticacion()?.email
                }
            }
            
            var jsonDatosCertFirma: [String: Any] = [:]
            if(datosDNIe?.getcertificadoFirma() != nil)
            {
                if(datosDNIe?.getcertificadoFirma()?.nif != nil)
                {
                    jsonDatosCertFirma["nif"] = datosDNIe?.getcertificadoFirma()?.nif
                }

                if(datosDNIe?.getcertificadoFirma()?.nombre != nil)
                {
                    jsonDatosCertFirma["nombre"] = datosDNIe?.getcertificadoFirma()?.nombre
                }

                if(datosDNIe?.getcertificadoFirma()?.apellidos != nil)
                {
                    jsonDatosCertFirma["apellidos"] = datosDNIe?.getcertificadoFirma()?.apellidos
                }

                if(datosDNIe?.getcertificadoFirma()?.fechaNacimiento != nil)
                {
                    jsonDatosCertFirma["fechaNacimiento"] = datosDNIe?.getcertificadoFirma()?.fechaNacimiento
                }

                if(datosDNIe?.getcertificadoFirma()?.tipo != nil)
                {
                    jsonDatosCertFirma["tipo"] = datosDNIe?.getcertificadoFirma()?.tipo
                }

                if(datosDNIe?.getcertificadoFirma()?.nifRepresentante != nil)
                {
                    jsonDatosCertFirma["nifRepresentante"] = datosDNIe?.getcertificadoFirma()?.nifRepresentante
                }

                if(datosDNIe?.getcertificadoFirma()?.nombreRepresentante != nil)
                {
                    jsonDatosCertFirma["nombreRepresentante"] = datosDNIe?.getcertificadoFirma()?.nombreRepresentante
                }

                if(datosDNIe?.getcertificadoFirma()?.apellidosRepresentante != nil)
                {
                    jsonDatosCertFirma["apellidosRepresentante"] = datosDNIe?.getcertificadoFirma()?.apellidosRepresentante
                }

                if(datosDNIe?.getcertificadoFirma()?.fechaInicioValidez != nil)
                {
                    jsonDatosCertFirma["fechaInicioValidez"] = datosDNIe?.getcertificadoFirma()?.fechaInicioValidez
                }

                if(datosDNIe?.getcertificadoFirma()?.fechaFinValidez != nil)
                {
                    jsonDatosCertFirma["fechaFinValidez"] = datosDNIe?.getcertificadoFirma()?.fechaFinValidez
                }

                if(datosDNIe?.getcertificadoFirma()?.estado != nil)
                {
                    jsonDatosCertFirma["estado"] = datosDNIe?.getcertificadoFirma()?.estado
                }
                
                if(datosDNIe?.getcertificadoFirma()?.email != nil)
                {
                    jsonDatosCertFirma["email"] = datosDNIe?.getcertificadoFirma()?.email
                }
            }
            var jsonDatosCertCA: [String: Any] = [:]
            if(datosDNIe?.getcertificadoCA() != nil)
            {
                if(datosDNIe?.getcertificadoCA()?.nif != nil)
                {
                    jsonDatosCertCA["nif"] = datosDNIe?.getcertificadoCA()?.nif
                }

                if(datosDNIe?.getcertificadoCA()?.nombre != nil)
                {
                    jsonDatosCertCA["nombre"] = datosDNIe?.getcertificadoCA()?.nombre
                }

                if(datosDNIe?.getcertificadoCA()?.apellidos != nil)
                {
                    jsonDatosCertCA["apellidos"] = datosDNIe?.getcertificadoCA()?.apellidos
                }

                if(datosDNIe?.getcertificadoCA()?.fechaNacimiento != nil)
                {
                    jsonDatosCertCA["fechaNacimiento"] = datosDNIe?.getcertificadoCA()?.fechaNacimiento
                }

                if(datosDNIe?.getcertificadoCA()?.tipo != nil)
                {
                    jsonDatosCertCA["tipo"] = datosDNIe?.getcertificadoCA()?.tipo
                }

                if(datosDNIe?.getcertificadoCA()?.nifRepresentante != nil)
                {
                    jsonDatosCertCA["nifRepresentante"] = datosDNIe?.getcertificadoCA()?.nifRepresentante
                }

                if(datosDNIe?.getcertificadoCA()?.nombreRepresentante != nil)
                {
                    jsonDatosCertCA["nombreRepresentante"] = datosDNIe?.getcertificadoCA()?.nombreRepresentante
                }

                if(datosDNIe?.getcertificadoCA()?.apellidosRepresentante != nil)
                {
                    jsonDatosCertCA["apellidosRepresentante"] = datosDNIe?.getcertificadoCA()?.apellidosRepresentante
                }

                if(datosDNIe?.getcertificadoCA()?.fechaInicioValidez != nil)
                {
                    jsonDatosCertCA["fechaInicioValidez"] = datosDNIe?.getcertificadoCA()?.fechaInicioValidez
                }

                if(datosDNIe?.getcertificadoCA()?.fechaFinValidez != nil)
                {
                    jsonDatosCertCA["fechaFinValidez"] = datosDNIe?.getcertificadoCA()?.fechaFinValidez
                }

                if(datosDNIe?.getcertificadoCA()?.estado != nil)
                {
                    jsonDatosCertCA["estado"] = datosDNIe?.getcertificadoCA()?.estado
                }
                
                if(datosDNIe?.getcertificadoCA()?.email != nil)
                {
                    jsonDatosCertCA["email"] = datosDNIe?.getcertificadoCA()?.email
                }
            }
            
            var jsonDatosDatosICAO: [String: Any] = [:]
            if(datosDNIe?.getdatosICAO() != nil)
            {
                if(datosDNIe?.getdatosICAO()?.DG1 != nil)
                {
                    jsonDatosDatosICAO["DG1"] = datosDNIe?.getdatosICAO()?.DG1
                }
                
                if(datosDNIe?.getdatosICAO()?.DG2 != nil)
                {
                    jsonDatosDatosICAO["DG2"] = datosDNIe?.getdatosICAO()?.DG2
                }
                
                if(datosDNIe?.getdatosICAO()?.DG13 != nil)
                {
                    jsonDatosDatosICAO["DG13"] = datosDNIe?.getdatosICAO()?.DG13
                }

                if(datosDNIe?.getdatosICAO()?.SOD != nil)
                {
                    jsonDatosDatosICAO["SOD"] = datosDNIe?.getdatosICAO()?.SOD
                }
            }
            
            jsonDatosDNIe = [:]
            jsonDatosDNIe?["nif"] = datosDNIe?.getNif()
            jsonDatosDNIe?["nombreCompleto"] = datosDNIe?.getNombreCompleto()
            jsonDatosDNIe?["nombre"] = datosDNIe?.getNombre()
            jsonDatosDNIe?["apellido1"] = datosDNIe?.getApellido1()
            jsonDatosDNIe?["apellido2"] = datosDNIe?.getApellido2()
            jsonDatosDNIe?["imagen"] = base64Foto
            jsonDatosDNIe?["firma"] = base64Firma
            jsonDatosDNIe?["fechaNacimiento"] = datosDNIe?.getFechaNacimiento()
            jsonDatosDNIe?["provinciaNacimiento"] = datosDNIe?.getProvinciaNacimiento()
            jsonDatosDNIe?["municipioNacimiento"] = datosDNIe?.getMunicipioNacimiento()
            jsonDatosDNIe?["nombrePadre"] = datosDNIe?.getNombrePadre()
            jsonDatosDNIe?["nombreMadre"] = datosDNIe?.getNombreMadre()
            jsonDatosDNIe?["fechaValidez"] = datosDNIe?.getfechaValidez()
            jsonDatosDNIe?["emisor"] = datosDNIe?.getemisor()
            jsonDatosDNIe?["nacionalidad"] = datosDNIe?.getnacionalidad()
            jsonDatosDNIe?["sexo"] = datosDNIe?.getsexo()
            jsonDatosDNIe?["direccion"] = datosDNIe?.getdireccion()
            jsonDatosDNIe?["provinciaActual"] = datosDNIe?.getprovinciaActual()
            jsonDatosDNIe?["municipioActual"] = datosDNIe?.getmunicipioActual()
            jsonDatosDNIe?["numSoporte"] = datosDNIe?.getnumSoporte()
            jsonDatosDNIe?["certificadoAutenticacion"] = jsonDatosCertAut
            jsonDatosDNIe?["certificadoFirma"] = jsonDatosCertFirma
            jsonDatosDNIe?["certificadoCA"] = jsonDatosCertCA
            jsonDatosDNIe?["integridadDocumento"] = datosDNIe?.getIntegridadDocumento()
            jsonDatosDNIe?["pemCertificadoFirmaSOD"] = datosDNIe?.getpemCertificadoFirmaSOD()
            jsonDatosDNIe?["datosICAO"] = jsonDatosDatosICAO
            jsonDatosDNIe?["can"] = datosDNIe?.getCan()
            
            var jsonErrores = [String]()
            if(datosDNIe?.geterroresVerificacion() != nil && (datosDNIe?.geterroresVerificacion()!.count ?? 0) > 0)
            {
                let errores = datosDNIe?.geterroresVerificacion()
                for error in errores!
                {
                    jsonErrores.append(error.localizedDescription)
                }
            }
            
            jsonDatosDNIe?["erroresVerificacion"] = jsonErrores
        }
        
        var json: [String: Any] = [:]
        json["datosDNIe"] = jsonDatosDNIe
        json["error"] = errorText
        
        call.resolve(json)
    }

}
