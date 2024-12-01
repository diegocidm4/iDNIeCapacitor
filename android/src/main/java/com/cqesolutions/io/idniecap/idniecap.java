package com.cqesolutions.io.idniecap;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;


import com.cqesolutions.io.idniecap.activities.ConsultaDNIe;
import com.cqesolutions.io.idniecap.activities.ConsultaPasaporte;
import com.cqesolutions.io.idniecap.activities.FirmaDNIe;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;

import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class idniecap {

    public void configure(String apiKey){
        //Not implemented on android
    }

    public String getMRZKey(String passportNumber,String dateOfBirth, String dateOfExpiry){
        return passportNumber+"#"+dateOfBirth+"#"+dateOfExpiry;
    }

    public boolean readPassport(String accessKey, int paceKeyReference, String[] tags, Plugin plugin, PluginCall call){
        boolean recuperaFoto = false;
        boolean recuperaFirma = false;
        if(tags.length==0)
        {
            recuperaFoto = true;
            recuperaFirma = true;
        }
        else {
            for (int i = 0; i < tags.length; i++) {
                if (tags[i].equals("DG2")) {
                    recuperaFoto = true;
                } else if (tags[i].equals("DG7")) {
                    recuperaFirma = true;
                }

            }
        }
        boolean esperaRespuesta = false;
        switch (paceKeyReference)
        {
            case 1:
                //Open activity to read DNIe
                Intent intentPassport = new Intent(plugin.getActivity(), ConsultaPasaporte.class);
                String[] accesKeyArray = accessKey.split("#");
                String passportNumber = accesKeyArray[0];
                String dateOfBirth = accesKeyArray[1];
                String dateOfExpiry = accesKeyArray[2];

                intentPassport.putExtra("passportNumber", passportNumber);
                intentPassport.putExtra("dateOfBirth", dateOfBirth);
                intentPassport.putExtra("dateOfExpiry", dateOfExpiry);
                intentPassport.putExtra("recuperaFoto", recuperaFoto);
                intentPassport.putExtra("recuperaFirma", recuperaFirma);
                plugin.startActivityForResult(call, intentPassport, "readPassport");
                esperaRespuesta = true;
                break;
            case 2:
                //Open activity to read DNIe
                Intent intent = new Intent(plugin.getActivity(), ConsultaDNIe.class);
                intent.putExtra("CAN", accessKey);
                intent.putExtra("recuperaFoto", recuperaFoto);
                intent.putExtra("recuperaFirma", recuperaFirma);
                plugin.startActivityForResult(call, intent, "readPassport");
                esperaRespuesta = true;
                break;
            default:
                //Not implemented
                esperaRespuesta = false;
                break;
        }

        return esperaRespuesta;
    }

    public void signTextDNIe(String accessKey, String pin,String datosFirma, String certToUse, Plugin plugin, PluginCall call){

        //Open activity to read DNIe
        Intent intent = new Intent(plugin.getActivity(), FirmaDNIe.class);
        intent.putExtra("CAN", accessKey);
        intent.putExtra("pin", pin);
        intent.putExtra("datosFirma", datosFirma);
        intent.putExtra("certToUse", certToUse);
        plugin.startActivityForResult(call, intent, "signText");

    }

    public void signHashDNIe(String accessKey, String pin,byte[] hash, int digest, String certToUse, Plugin plugin, PluginCall call){
        //Open activity to read DNIe
        Intent intent = new Intent(plugin.getActivity(), FirmaDNIe.class);
        intent.putExtra("CAN", accessKey);
        intent.putExtra("pin", pin);
        intent.putExtra("hashFirma", hash);
        intent.putExtra("digest", digest);
        intent.putExtra("certToUse", certToUse);
        plugin.startActivityForResult(call, intent, "signText");

    }

    public byte[] toByte(int[] data) throws IOException {

        byte[] bytes = new byte[data.length];
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) data[i];
        }
        return bytes;
    }

    public byte[] calculaHashDocumento(String documento, int digest, Activity activity) throws IOException, NoSuchAlgorithmException {
        String hashAlgo = "SHA-256";
        switch (digest)
        {
            case 1: hashAlgo = "SHA-1";
                break;
            case 224: hashAlgo = "SHA-224";
                break;
            case 256: hashAlgo = "SHA-256";
                break;
            case 384: hashAlgo = "SHA-384";
                break;
            case 512: hashAlgo = "SHA-512";
                break;

        }

        MessageDigest md = MessageDigest.getInstance(hashAlgo);
        Uri documentUri = Uri.parse(documento);
        InputStream is = activity.getApplicationContext().getContentResolver().openInputStream(documentUri);

        byte[] buffer = new byte[4 * 1024]; // optimal size is 4K
        long available = is.available();
        long processed = 0;

        int read = 0;
        do {
            read = is.read(buffer);
            if (read > 0) {
                md.update(buffer, 0, read);
                processed += read;
                //cb.onProgress(file, processed, available);
            }
        } while (read > 0);

        is.close();

        return md.digest();
    }
}
