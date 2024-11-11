import { WebPlugin } from '@capacitor/core';

import type { idniecapPlugin } from './definitions';

export class idniecapWeb extends WebPlugin implements idniecapPlugin {
//async configure(options: { apiKey: String }): Promise<{ estadoLicencia: EstadoLicencia }> {
  async configure(options: { apiKey: String }): Promise<void> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
    //return estadoLicencia;
  }
  async readPassport(options: {accessKey: String, paceKeyReference: number}): Promise<void> {
    console.log("NOT IMPLEMENTED");
    console.log(options);
  }
    
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
