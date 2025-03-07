import { WebPlugin } from '@capacitor/core';

import type { EstadoLicencia, idniecapPlugin, MRZKey, RespuestaFirma, RespuestaNFC, RespuestaReadPassport } from './definitions';

export class idniecapWeb extends WebPlugin implements idniecapPlugin {
  getMRZKey(options: {passportNumber: String, dateOfBirth: String, dateOfExpiry: String}): Promise<MRZKey> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }
  //async configure(options: { apiKey: String }): Promise<{ estadoLicencia: EstadoLicencia }> {
  async configure(options: { apiKey: String }): Promise<EstadoLicencia> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }
  async readPassport(options: {accessKey: String, paceKeyReference: number, tags: String[], esDNIe: boolean}): Promise<RespuestaReadPassport> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }

  async signTextDNIe(options: {accessKey: String, pin: String, datosFirma: String, certToUse: String}) : Promise<RespuestaFirma>{
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }

  async signDocumentDNIe(options: {accessKey: String, pin: String, document: String, certToUse: String}) : Promise<RespuestaFirma>{
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }

  async signHashDNIe(options: {accessKey: String, pin: String, hash: Array<Number>, digest: number, certToUse: String}) : Promise<RespuestaFirma>
  {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    throw new Error('Method not implemented.');
  }

  async isNFCEnable(): Promise<RespuestaNFC> {
    throw new Error('Method not implemented.');
  }
}
