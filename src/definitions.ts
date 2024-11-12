export interface idniecapPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  configure(options: { apiKey: string }): Promise<EstadoLicencia>;
  readPassport(options: {accessKey: String, paceKeyReference: number}) : Promise<RespuestaReadPassport>;
}

export const PACEHandler =  { 
  NO_PACE_KEY_REFERENCE: 0,
  MRZ_PACE_KEY_REFERENCE: 1,
  CAN_PACE_KEY_REFERENCE: 2
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