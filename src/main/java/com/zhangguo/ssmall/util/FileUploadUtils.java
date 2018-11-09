package com.zhangguo.ssmall.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.commons.io.IOUtils;

public class FileUploadUtils {

	
	/**
	 * 把上传的文件保存到服务器
	 * @param inputStream
	 * @param uploadFileFileName
	 * @return
	 */
	public static String copyFile(InputStream inputStream, String uploadFileFileName) {
		String urlPath = getUrlPath(uploadFileFileName);
		File file = createTmpStoreFile(urlPath);
		FileOutputStream fileOutputStream = null;
		try {
			fileOutputStream = new FileOutputStream(file);
			IOUtils.copy(inputStream, fileOutputStream);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				
				if(null != fileOutputStream) {
					fileOutputStream.close();
				}
				if(null != inputStream) {
					inputStream.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return urlPath;
	}
	
	/**
	 * 获取图片存储地址
	 * @param uploadFileFileName
	 * @return
	 */
	private static String getUrlPath(String uploadFileFileName) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String name = UUID.randomUUID().toString();
		String ext = uploadFileFileName.substring(uploadFileFileName.lastIndexOf("."));
		return "/UploadFile/"+ df.format(new Date()) + "/" +name + ext; 
	}
	
	
	public static String realPath = ""; //系统服务绝对路径
	/**
	 * 创建临时文件
	 * @param urlPath
	 * @return
	 */
	private static  File createTmpStoreFile(String urlPath)  {
		
		File storedFile = new File(realPath + urlPath);
		if (!storedFile.getParentFile().isDirectory() || !storedFile.getParentFile().exists()) {
			storedFile.getParentFile().mkdirs();
		}
		if (!storedFile.exists()) {
			try {
				storedFile.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return storedFile;
	}
}
