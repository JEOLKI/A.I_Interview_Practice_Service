package com.aiinterview.common.util.aes;

import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;

public class AesCryptUtil {
	public static final String ENC_KEY = "e534cf179007db7e6360ebf95fa5d51c";
	public static final String salt = "deafa8b6802cebcc0bcceaaa5f3461a9";
	public static final String iv = "e9d3712c4d5c35093d340733b8c26b92";

	public static String decrypt(String data) {
		try {
			return decrypt(salt, iv, ENC_KEY, data, 10000, 128);
		} catch (Exception e) {
			return "";
		}
	}

	private static String decrypt(String salt, String iv, String passphrase, String ciphertext, int iterationCount, int keySize) throws Exception {
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount, keySize);
		SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.DECRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));
		byte[] decrypted = cipher.doFinal(Base64.decodeBase64(ciphertext.getBytes()));
		return new String(decrypted, "UTF-8");
	}

	public static String encrypt(String data) {
		try {
			return encrypt(salt, iv, ENC_KEY, data, 1000, 128);
		} catch (Exception e) {
			return "";
		}
	}

	private static String encrypt(String salt, String iv, String passphrase, String ciphertext, int iterationCount,
			int keySize) throws Exception {
		SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		KeySpec spec = new PBEKeySpec(passphrase.toCharArray(), Hex.decodeHex(salt.toCharArray()), iterationCount,
				keySize);
		SecretKey key = new SecretKeySpec(factory.generateSecret(spec).getEncoded(), "AES");
		Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
		cipher.init(Cipher.ENCRYPT_MODE, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));
		byte[] encrypted = cipher.doFinal(ciphertext.getBytes("UTF-8"));
		return new String(Base64.encodeBase64(encrypted));
	}

	public static void main(String[] args) {
		String enc = encrypt("test001");
		System.out.println(enc);
		System.out.println(decrypt(enc));
	}
}
