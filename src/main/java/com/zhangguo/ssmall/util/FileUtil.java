package com.zhangguo.ssmall.util;

import java.io.File;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil {
	/**
     * 上传图片
     *  原名称
     * @param request 请求
     * @param path_deposit 存放位置(路径)
     * @param file 文件
     * @param isRandomName 是否随机名称
     * @return 完整文件路径
     */
    public static String uploadImage(HttpServletRequest request,String path_deposit,MultipartFile file,boolean isRandomName) {
        //上传
        try {
            String[] typeImg={"gif","png","jpg"};

            if(file!=null){
                String origName=file.getOriginalFilename();// 文件原名称
                System.out.println("上传的文件原名称:"+origName);
                // 判断文件类型
                String type=origName.indexOf(".")!=-1?origName.substring(origName.lastIndexOf(".")+1, origName.length()):null;
                if (type!=null) {
                    boolean booIsType=false;
                    for (int i = 0; i < typeImg.length; i++) {
                        if (typeImg[i].equals(type.toLowerCase())) {
                            booIsType=true;
                        }
                    }
                    //类型正确
                    if (booIsType) {
                        //存放图片文件的路径
                        String path=request.getSession().getServletContext().getRealPath(path_deposit);
                        //组合名称
                        String fileSrc=""; 
                        //是否随机名称
                        if(isRandomName){
                            origName=DateUtils.formateString(new Date(), "yyyy-MM-dd-")+UUID.randomUUID().toString()+origName.substring(origName.lastIndexOf("."));
                        }
                        //判断是否存在目录
                        File targetFile=new File(path,origName);
                        if(!targetFile.exists()){
                            targetFile.mkdirs();//创建目录
                        }
                        //上传
                        file.transferTo(targetFile);
                        //完整路径
                        fileSrc=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+path_deposit+origName;
                        System.out.println("图片上传成功:"+fileSrc);
                        return fileSrc;
                    }
                }
            }
            return null;
        }catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
