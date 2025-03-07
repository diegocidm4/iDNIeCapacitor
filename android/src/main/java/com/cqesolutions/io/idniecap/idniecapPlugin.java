package com.cqesolutions.io.idniecap;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.nfc.NfcAdapter;
import android.nfc.NfcManager;
import android.util.Base64;

import androidx.activity.result.ActivityResult;

import com.cqesolutions.io.idniecap.bean.DatosCertificado;
import com.cqesolutions.io.idniecap.bean.DatosCertificadoFirma;
import com.cqesolutions.io.idniecap.bean.DatosDNIe;
import com.cqesolutions.io.idniecap.jj2000.J2kStreamDecoder;
import com.cqesolutions.io.idniecap.utils.DateUtils;
import com.cqesolutions.io.idniecap.utils.ImageUtils;
import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.ActivityCallback;
import com.getcapacitor.annotation.CapacitorPlugin;

import org.json.JSONException;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.IntBuffer;
import java.security.NoSuchAlgorithmException;
import java.util.List;

@CapacitorPlugin(name = "idniecap")
public class idniecapPlugin extends Plugin {

    private idniecap implementation = new idniecap();
    private Boolean lecturaCompleta = false;
    private DatosDNIe datosDNIe = null;
    private DatosCertificado certificadoAutenticacion = null;
    private DatosCertificado certificadoFirma = null;
    private DatosCertificadoFirma certificadoCA = null;
    private boolean integridadDocumento = true;
    private String errorText = null;
    private String firma = null;

    @PluginMethod
    public void configure(PluginCall call){
        String apiKey = call.getString("apiKey");

        implementation.configure(apiKey);

        JSObject ret = new JSObject();
        ret.put("descripcion","Licencia válida de forma indefinida.");
        ret.put("APIKeyValida",true);
        ret.put("lecturaDGHabilitada",true);
        ret.put("autenticacionHabilitada",true);
        ret.put("firmaHabilitada",true);
        call.resolve(ret);
    }

    @PluginMethod
    public void getMRZKey(PluginCall call){
        String passportNumber = call.getString("passportNumber");
        String dateOfBirth = call.getString("dateOfBirth");
        String dateOfExpiry = call.getString("dateOfExpiry");

        String mrzKey = implementation.getMRZKey(passportNumber, dateOfBirth, dateOfExpiry);

        JSObject ret = new JSObject();
        ret.put("mrzKey",mrzKey);
        call.resolve(ret);
    }

    @PluginMethod
    public void readPassport(PluginCall call){
        String accessKey = call.getString("accessKey");
        int paceKeyReference = call.getInt("paceKeyReference");
        JSArray jtags = call.getArray("tags");
        boolean esDNIe = call.getBoolean("esDNIe");

        String[] tags = new String[jtags.length()];
        try {
            for(int i=0; i<jtags.length();i++)
            {
                    tags[i]=jtags.getString(i);
            }
        } catch (JSONException e) {
            call.reject("Se ha producido un error al procesar los datos");
        }

        lecturaCompleta = false;
        datosDNIe = null;
        certificadoAutenticacion = null;
        certificadoFirma = null;
        certificadoCA = null;
        integridadDocumento = true;

        boolean esperaRespuesta = implementation.readPassport(accessKey, paceKeyReference, tags, esDNIe,this, call);

        if(!esperaRespuesta)
        {
            call.unavailable("Opción no disponible.");
        }

        while(!lecturaCompleta)
        {

        }

        JSObject jsonDatosDNIe = null;
        if(datosDNIe!=null)
        {
            jsonDatosDNIe = new JSObject();

            JSObject jsonDatosCertAut = null;
            if(certificadoAutenticacion != null) {
                jsonDatosCertAut = new JSObject();
                jsonDatosCertAut.put("nif", certificadoAutenticacion.getNif());
                jsonDatosCertAut.put("nombre", certificadoAutenticacion.getNombre());
                jsonDatosCertAut.put("apellidos", certificadoAutenticacion.getApellidos());
                jsonDatosCertAut.put("fechaNacimiento", certificadoAutenticacion.getFechaNacimiento());
                jsonDatosCertAut.put("tipo", certificadoAutenticacion.getTipo());
                jsonDatosCertAut.put("nifRepresentante", certificadoAutenticacion.getNifRepresentante());
                jsonDatosCertAut.put("nombreRepresentante", certificadoAutenticacion.getNombreRepresentante());
                jsonDatosCertAut.put("apellidosRepresentante", certificadoAutenticacion.getApellidosRepresentante());
                jsonDatosCertAut.put("fechaInicioValidez", certificadoAutenticacion.getFechaInicioValidez());
                jsonDatosCertAut.put("fechaFinValidez", certificadoAutenticacion.getFechaFinValidez());
                jsonDatosCertAut.put("estado", certificadoAutenticacion.getEstado());
                jsonDatosCertAut.put("email", certificadoAutenticacion.getEmail());
            }

            JSObject jsonDatosCertFirma = null;
            if(certificadoFirma != null) {
                jsonDatosCertFirma = new JSObject();
                jsonDatosCertFirma.put("nif", certificadoFirma.getNif());
                jsonDatosCertFirma.put("nombre", certificadoFirma.getNombre());
                jsonDatosCertFirma.put("apellidos", certificadoFirma.getApellidos());
                jsonDatosCertFirma.put("fechaNacimiento", certificadoFirma.getFechaNacimiento());
                jsonDatosCertFirma.put("tipo", certificadoFirma.getTipo());
                jsonDatosCertFirma.put("nifRepresentante", certificadoFirma.getNifRepresentante());
                jsonDatosCertFirma.put("nombreRepresentante", certificadoFirma.getNombreRepresentante());
                jsonDatosCertFirma.put("apellidosRepresentante", certificadoFirma.getApellidosRepresentante());
                jsonDatosCertFirma.put("fechaInicioValidez", certificadoFirma.getFechaInicioValidez());
                jsonDatosCertFirma.put("fechaFinValidez", certificadoFirma.getFechaFinValidez());
                jsonDatosCertFirma.put("estado", certificadoFirma.getEstado());
                jsonDatosCertFirma.put("email", certificadoFirma.getEmail());

            }

            JSObject jsonDatosCertCA = null;
            if(certificadoCA != null) {
                jsonDatosCertCA = new JSObject();
                jsonDatosCertCA.put("nif", certificadoCA.getNumeroSerie());
                jsonDatosCertCA.put("nombre", certificadoCA.getSujeto());
                jsonDatosCertCA.put("fechaInicioValidez", certificadoCA.getFechaInicioValidez());
                jsonDatosCertCA.put("fechaFinValidez", certificadoCA.getFechaFinValidez());
                jsonDatosCertCA.put("estado", certificadoCA.getEstado());
            }

            JSObject jsonDatosDatosICAO = null;
            if(datosDNIe.getDatosICAO() != null) {
                jsonDatosDatosICAO = new JSObject();
                jsonDatosDatosICAO.put("DG1", datosDNIe.getDatosICAO().getDG1());
                jsonDatosDatosICAO.put("DG2", datosDNIe.getDatosICAO().getDG2());
                jsonDatosDatosICAO.put("DG13", datosDNIe.getDatosICAO().getDG13());
                jsonDatosDatosICAO.put("SOD", datosDNIe.getDatosICAO().getSOD());
            }

            String imagen = null;
            if(datosDNIe.getImagen() != null)
            {
                imagen = ImageUtils.encodeToBase64(datosDNIe.getImagen());
            }

            String firma = null;
            if(datosDNIe.getFirma() != null)
            {
                firma = ImageUtils.encodeToBase64(datosDNIe.getFirma());
            }

            jsonDatosDNIe.put("nif", datosDNIe.getNif());
            jsonDatosDNIe.put("nombreCompleto", datosDNIe.getNombreCompleto());
            jsonDatosDNIe.put("nombre", datosDNIe.getNombre());
            jsonDatosDNIe.put("apellido1", datosDNIe.getApellido1());
            jsonDatosDNIe.put("apellido2", datosDNIe.getApellido2());
            jsonDatosDNIe.put("imagen", imagen);
            jsonDatosDNIe.put("firma", firma);
            jsonDatosDNIe.put("fechaNacimiento", DateUtils.formateaFechaDNIe(datosDNIe.getFechaNacimiento(), "dd/MM/yyyy", getActivity().getApplicationContext()));
            jsonDatosDNIe.put("provinciaNacimiento", datosDNIe.getProvinciaNacimiento());
            jsonDatosDNIe.put("municipioNacimiento", datosDNIe.getMunicipioNacimiento());
            jsonDatosDNIe.put("nombrePadre", datosDNIe.getNombrePadre());
            jsonDatosDNIe.put("nombreMadre", datosDNIe.getNombreMadre());
            //jsonDatosDNIe.put("fechaValidez", datosDNIe.getFechaValidez());
            jsonDatosDNIe.put("fechaValidez", DateUtils.formateaFechaDNIe(datosDNIe.getFechaValidez(), "dd/MM/yyyy", getActivity().getApplicationContext()));
            jsonDatosDNIe.put("emisor", datosDNIe.getEmisor());
            jsonDatosDNIe.put("nacionalidad", datosDNIe.getNacionalidad());
            jsonDatosDNIe.put("sexo", datosDNIe.getSexo());
            jsonDatosDNIe.put("direccion", datosDNIe.getDireccion());
            jsonDatosDNIe.put("provinciaActual", datosDNIe.getProvinciaActual());
            jsonDatosDNIe.put("municipioActual", datosDNIe.getMunicipioActual());
            jsonDatosDNIe.put("numSoporte", datosDNIe.getNumSoporte());
            jsonDatosDNIe.put("certificadoAutenticacion", jsonDatosCertAut);
            jsonDatosDNIe.put("certificadoFirma", jsonDatosCertFirma);
            jsonDatosDNIe.put("certificadoCA", jsonDatosCertCA);
            jsonDatosDNIe.put("integridadDocumento", integridadDocumento);
            jsonDatosDNIe.put("pemCertificadoFirmaSOD", null);
            jsonDatosDNIe.put("datosICAO", jsonDatosDatosICAO);
            jsonDatosDNIe.put("can", accessKey);
        }

        JSObject ret = new JSObject();
        ret.put("datosDNIe",jsonDatosDNIe);
        ret.put("error", errorText);
        call.resolve(ret);
    }

    @ActivityCallback
    private void readPassport(PluginCall call, ActivityResult result) {
        if (call == null) {
            lecturaCompleta = true;
            return;
        }

        if(result.getResultCode() == Activity.RESULT_OK)
        {
            Intent data = result.getData();
            datosDNIe = (DatosDNIe) data.getExtras().get("datosDNIe");
            certificadoAutenticacion = (DatosCertificado) data.getExtras().get("certificadoAutenticacion");
            certificadoFirma = (DatosCertificado) data.getExtras().get("certificadoFirma");
            if(data.getExtras().containsKey("certificadoCA")) {
                certificadoCA = (DatosCertificadoFirma) data.getExtras().get("certificadoCA");
            }
            if(data.getExtras().containsKey("integridadDocumento")) {
                integridadDocumento = (boolean) data.getExtras().get("integridadDocumento");
            }

        }
        else
        {
            Intent data = result.getData();
            errorText = (String) data.getExtras().get("errorText");
        }
        lecturaCompleta = true;
    }


    @PluginMethod
    public void signTextDNIe(PluginCall call){
        String accessKey = call.getString("accessKey");
        String pin = call.getString("pin");
        String datosFirma = call.getString("datosFirma");
        String certToUse = call.getString("certToUse");

        lecturaCompleta = false;
        firma = null;
        errorText = null;

        implementation.signTextDNIe(accessKey, pin, datosFirma, certToUse, this, call);

        while(!lecturaCompleta)
        {

        }

        JSObject ret = new JSObject();
        ret.put("firma",firma);
        ret.put("error", errorText);
        call.resolve(ret);

    }

    @ActivityCallback
    private void signText(PluginCall call, ActivityResult result) {
        if (call == null) {
            lecturaCompleta = true;
            return;
        }

        if(result.getResultCode() == Activity.RESULT_OK)
        {
            Intent data = result.getData();
            firma = (String) data.getExtras().get("firma");
        }
        else
        {
            Intent data = result.getData();
            String error = (String) data.getExtras().get("error");
            if(error.isEmpty())
                errorText = null;
        }
        lecturaCompleta = true;
    }

    @PluginMethod
    public void signDocumentDNIe(PluginCall call){
        String accessKey = call.getString("accessKey");
        String pin = call.getString("pin");
        String document = call.getString("document");
        String certToUse = call.getString("certToUse");

        int digest = 256;
        byte[] hash = new byte[0];
        try {
            hash = implementation.calculaHashDocumento(document, digest, getActivity());
        } catch (IOException | NoSuchAlgorithmException e) {
            call.reject("Se ha producido un error al procesar los datos");
        }

        lecturaCompleta = false;
        firma = null;
        errorText = null;

        implementation.signHashDNIe(accessKey, pin, hash, digest, certToUse, this, call);

        while(!lecturaCompleta)
        {

        }

        JSObject ret = new JSObject();
        ret.put("firma",firma);
        ret.put("error", errorText);
        call.resolve(ret);
    }

    @PluginMethod
    public void signHashDNIe(PluginCall call){
        String accessKey = call.getString("accessKey");
        String pin = call.getString("pin");
        JSArray jhash = call.getArray("hash");
        Integer digest = call.getInt("digest");
        String certToUse = call.getString("certToUse");

        int[] ihash = new int[jhash.length()];
        byte[] hash = null;
        try {
            for(int i=0; i<jhash.length();i++)
            {
                ihash[i]=(int)jhash.get(i);
            }

            hash = implementation.toByte(ihash);

        } catch (JSONException | IOException e) {
            call.reject("Se ha producido un error al procesar los datos");
        }

        lecturaCompleta = false;
        firma = null;
        errorText = null;

        implementation.signHashDNIe(accessKey, pin, hash, digest, certToUse, this, call);

        while(!lecturaCompleta)
        {

        }

        JSObject ret = new JSObject();
        ret.put("firma",firma);
        ret.put("error", errorText);
        call.resolve(ret);

    }

    @PluginMethod
    public void isNFCEnable(PluginCall call){
		Boolean disponible = true;
        Boolean activo = true;

        NfcManager manager = (NfcManager) getActivity().getApplicationContext().getSystemService(Context.NFC_SERVICE);
		NfcAdapter adapter = manager.getDefaultAdapter();

		if(adapter==null) {
			try{
                disponible = false;
			}
			catch (IllegalStateException ignored) {
				// There's no way to avoid getting this if saveInstanceState has already been called.
			}
		}
		else if (!adapter.isEnabled()) {
			try{
                activo = false;
			}
			catch (IllegalStateException ignored) {
				// There's no way to avoid getting this if saveInstanceState has already been called.
			}
		}


        JSObject ret = new JSObject();
        ret.put("disponible",disponible);
        ret.put("activo", activo);
        call.resolve(ret);

    }
}
