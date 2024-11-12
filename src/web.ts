import { WebPlugin } from '@capacitor/core';

import type { EstadoLicencia, idniecapPlugin, RespuestaReadPassport, DatosDNIe } from './definitions';

export class idniecapWeb extends WebPlugin implements idniecapPlugin {
  //async configure(options: { apiKey: String }): Promise<{ estadoLicencia: EstadoLicencia }> {
  async configure(options: { apiKey: String }): Promise<EstadoLicencia> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    var estado: EstadoLicencia = {
      descripcion: '',
      APIKeyValida: false,
      lecturaDGHabilitada: false,
      autenticacionHabilitada: false,
      firmaHabilitada: false
    };
    return estado;
  }
  async readPassport(options: {accessKey: String, paceKeyReference: number}): Promise<RespuestaReadPassport> {
  //  async readPassport(options: {accessKey: String, paceKeyReference: number}, callback: MyPluginCallback): Promise<CallbackID> {
    console.log("NOT IMPLEMENTED");
    console.log(options);

    var datosDNIe: DatosDNIe = {
      nif: '',
      nombreCompleto: '',
      nombre: '',
      apellido1: '',
      apellido2: '',
      firma: '',
      imagen: '', 
      fechaNacimiento: '',
      provinciaNacimiento: '',
      municipioNacimiento: '',
      nombrePadre: '',
      nombreMadre: '',
      fechaValidez: '',
      emisor: '',
      nacionalidad: '',
      sexo: '',
      direccion: '',
      provinciaActual: '',
      municipioActual: '',
      numSoporte: '',
      certificadoAutenticacion: {
        nif: "",
        nombre: "",
        apellidos: "",
        fechaNacimiento: "",
        tipo: "",
        nifRepresentante: "",
        nombreRepresentante: "",
        apellidosRepresentante: "",
        fechaInicioValidez: "",
        fechaFinValidez: "",
        estado: 0,
        email: ""
      },
      certificadoFirma: {
        nif: "",
        nombre: "",
        apellidos: "",
        fechaNacimiento: "",
        tipo: "",
        nifRepresentante: "",
        nombreRepresentante: "",
        apellidosRepresentante: "",
        fechaInicioValidez: "",
        fechaFinValidez: "",
        estado: 0,
        email: ""
      },
      certificadoCA: {
        nif: "",
        nombre: "",
        apellidos: "",
        fechaNacimiento: "",
        tipo: "",
        nifRepresentante: "",
        nombreRepresentante: "",
        apellidosRepresentante: "",
        fechaInicioValidez: "",
        fechaFinValidez: "",
        estado: 0,
        email: ""
      },
      integridadDocumento: false,
      pemCertificadoFirmaSOD: '',
      datosICAO: {
        DG1: "",
        DG2: "",
        DG13: "",
        SOD: ""
      },
      can: '',
      erroresVerificacion: ['']
    }

    var respuesta: RespuestaReadPassport =
    {
      datosDNIe: datosDNIe,
      error: undefined
    }


    return respuesta;
  }
    
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
