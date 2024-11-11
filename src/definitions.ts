export interface idniecapPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  readPassport(options: {accessKey: String, paceKeyReference: number}) : Promise<void>;
  //configure(apiKey: String): Promise<{estadoLicencia: EstadoLicencia}>;
  configure(options: { apiKey: string }): Promise<void>;
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
