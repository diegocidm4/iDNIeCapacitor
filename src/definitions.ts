export interface idniecapPlugin {
   /**
    * Método utilizado para configurar el plugin.
    * @param options - Array que incluye los parámetros que se le envían al plugin: apiKey (código de licencia generado que permite el uso del plugin)
    */
  configure(options: { apiKey: string }): Promise<EstadoLicencia>;
  
  /**
   * Genera el código mrz en función de los parámetros introducidos
   * @param options - Array que incluye los parámetros que se le envían al plugin: passportNumber (número de pasaporte o numero de soporte en el caso del DNIe), dateOfBirth (fecha de nacimiento en formato yymmdd), dateOfExpiry (fecha de validez del documento en formato yymmdd)
   */
  getMRZKey(options: {passportNumber: String, dateOfBirth: String, dateOfExpiry: String} ): Promise<MRZKey>;
  
  /**
   * Lee el eID utilizando la conexión NFC.
   * @param options - Array que incluye los parámetros que se le envían al plugin: accessKey (Indica el can o mrz utilizado para establecer la comunicación), paceKeyReference (indica el tipo de clave usada en la conexión, se puede utilizar CAN o MRZ), tags (indica los dataGroups a leer del documento. [] para leer todos. En android si no se especifica DG2 no se recupera la foto y si no se especifica DG7 no se recupera la firma, el resto de DGs se recuperan siempre)
   */
  readPassport(options: {accessKey: String, paceKeyReference: number, tags: String[]}) : Promise<RespuestaReadPassport>;

  /**
   * Firma un texto con el certificado del DNIe pasado como parámetro.
   * @param options - Array que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), datosFirma (texto a firmar), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates)
   */
  signTextDNIe(options: {accessKey: String, pin: String, datosFirma: String, certToUse: String}) : Promise<RespuestaFirma>;
  
  /**
   * Firma el hash de un documento pasado como parámetro con el certificado del DNIe pasado como parámetro.
   * @param options - Array que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), document (url del documento a firmar), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates)
   */
  signDocumentDNIe(options: {accessKey: String, pin: String, document: String, certToUse: String}) : Promise<RespuestaFirma>;

  /**
   * Firma el hash pasado como parámetro con el certificado del DNIe pasado como parámetro.
   * @param options - Array que incluye los parámetros que se le envían al plugin: accessKey (Indica el can utilizado para establecer la comunicación), pin (indica pin del DNIe), hash (hash a firmar), digest (digest del algoritmo utilizado para generar el hash. Se indica uno de los valores del tipo DigestType), certToUse (certificado a usar. Se indica uno de los valores del tipo DNIeCertificates)
   */
  signHashDNIe(options: {accessKey: String, pin: String, hash: Array<Number>, digest: number, certToUse: String}) : Promise<RespuestaFirma>;

  /**
   * Indica si el dispositivo móvil dispone de la tecnología NFC y si esta opción está activada.
   */
  isNFCEnable() : Promise<RespuestaNFC>;

}

export const PACEHandler =  { 
  NO_PACE_KEY_REFERENCE: 0,
  MRZ_PACE_KEY_REFERENCE: 1,
  CAN_PACE_KEY_REFERENCE: 2
 }


 export const DataGroupId =  {
   COM: 'COM',
   DG1: 'DG1',
   DG2: 'DG2',
   DG3: 'DG3',
   DG4: 'DG4',
   DG5: 'DG5',
   DG6: 'DG6',
   DG7: 'DG7',
   DG8: 'DG8',
   DG9: 'DG9',
   DG10: 'DG10',
   DG11: 'DG11',
   DG12: 'DG12',
   DG13: 'DG13',
   DG14: 'DG14',
   DG15: 'DG15',
   DG16: 'DG16',
   SOD: 'SOD'
 }

 export const DNIeCertificates =  {
   AUTENTICACION: 'AUTENTICACION',
   FIRMA: 'FIRMA'
 }
/*
 export const DNIeSingPadding =  {
   PKCS: 'PKCS',
   PSS: 'PSS'
 }
*/
 export const DigestType =  { 
   SHA1: 1,
   SHA224: 224,
   SHA256: 256,
   SHA384: 384,
   SHA512: 512
  }
 
 export interface EstadoLicencia {
    descripcion: String,
    APIKeyValida: Boolean,
    lecturaDGHabilitada: Boolean,
    autenticacionHabilitada: Boolean,
    firmaHabilitada: Boolean
 }

 export interface DatosDNIe {
     nif: String,
     nombreCompleto: String,
     nombre: String,
     apellido1: String,
     apellido2: String,
     firma: String,
     imagen: String,
     fechaNacimiento: String,
     provinciaNacimiento: String,
     municipioNacimiento: String,
     nombrePadre: String,
     nombreMadre: String,
     fechaValidez: String,
     emisor: String,
     nacionalidad: String,
     sexo: String,
     direccion: String,
     provinciaActual: String,
     municipioActual: String,
     numSoporte: String,
     certificadoAutenticacion: DatosCertificado,
     certificadoFirma: DatosCertificado,
     certificadoCA: DatosCertificado,
     integridadDocumento: Boolean,
     pemCertificadoFirmaSOD: String,
     datosICAO: DatosICAO,
     can: String,
     erroresVerificacion: [String]
 }

 export interface DatosCertificado {
    nif: String
    nombre: String
    apellidos: String
    fechaNacimiento: String
    tipo: String
    nifRepresentante: String
    nombreRepresentante: String
    apellidosRepresentante: String
    fechaInicioValidez: String
    fechaFinValidez: String
    estado: Number
    email: String
 }

 export interface DatosICAO {
    DG1: String
    DG2: String
    DG13: String
    SOD: String
 }

 export interface RespuestaReadPassport {
    datosDNIe: DatosDNIe | undefined,
    error: String | undefined
 }

 export interface MRZKey {
   mrzKey: String
}

export interface RespuestaFirma {
   firma: String | undefined,
   error: String | undefined
}

export interface RespuestaNFC {
   disponible: Boolean,
   activo: Boolean
}
 