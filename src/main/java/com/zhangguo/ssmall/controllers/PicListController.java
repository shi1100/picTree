package com.zhangguo.ssmall.controllers;

import java.io.File;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map.Entry;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.zhangguo.ssmall.entities.PicTree;
import com.zhangguo.ssmall.entities.PicUrl;
import com.zhangguo.ssmall.services.PicServiceImpl;
import com.zhangguo.ssmall.util.FileUploadUtils;

import net.sf.json.JSONArray;

@Controller
public class PicListController {

	
//	@Resource
//	GoodsService goodsService;
	
	@Resource
	PicServiceImpl picService;
	private Logger logger = LogManager.getLogger(PicListController.class);
	/*
	 * 产品列表与分页Action
	 */
	@RequestMapping("/pic/list")
	public String list(Model model){
		List<PicTree> list = picService.getPicList("", "");
		List<PicTree> pictree = getInfosByParentId("0",list);
		JSONArray jsonArray = JSONArray.fromObject(pictree);
        String jsonString = jsonArray.toString().replace(",\"nodes\":[]", "");
        model.addAttribute("nodes",jsonString.replace("name", "text"));
		return "picList/picList";
	}
	
	@RequestMapping(value="/pic/refreshTree",produces="text/html;charset=UTF-8;")
	@ResponseBody
	public Object refreshTree(String text){
		plist = new ArrayList();
		List<PicTree> list = picService.getPicListbyText(text);
		logger.info("查询结果个数:"+list.size());
		plist.addAll(list);
		try {//查询父节点
			for(int i=0;i<list.size();i++) {
				if(!list.get(i).getPid().equals("0")) {
					plist =getList(list.get(i).getPid()) ;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		List<PicTree> pictree = getInfosByParentId("0",plist);
		JSONArray jsonArray = JSONArray.fromObject(pictree);
        String jsonString = jsonArray.toString().replace(",\"nodes\":[]", "");
		return jsonString.replace("name", "text");
	}
	
	private List<PicTree> plist = null;
	
	private List getList(String id) {
		logger.info("子节点id:"+id);
		PicTree pt = picService.getPicListbyPid(id);
		Boolean b = false;
		for(PicTree p:plist) {
			if(pt.getId().equals(p.getId())) {
				b = true;
				break;
			}
		}
		if(!b) {
			plist.add(pt);
		}
		
		if(!pt.getPid().equals("0")) {
			getList(pt.getPid());
		}
		return plist;
	}
	
	
	@RequestMapping("/pic/addNode")
	@ResponseBody
	public Object addNode(PicTree node){
		int i = picService.addNode(node);
		return node.getId();
	}
	
	
	@RequestMapping("/pic/delNode")
	@ResponseBody
	public Object delNode(PicTree node){
		return picService.delNode(node);
	}
	
	@RequestMapping("/pic/picModal")
	public Object picModal(Model model,String id){
		model.addAttribute("snodeid",id);
		return "picList/picModal";
	}
	
	@RequestMapping("/pic/updateNode")
	@ResponseBody
	public Object updateNode(PicTree node){
		return picService.updateNode(node);
	}
	
	 /**
     * 上传文件
     * @param request
     * @param response
     * @param file 上传的文件，支持多文件
     * @throws Exception
     */

	@RequestMapping("/pic/addPic")
	@ResponseBody
    public Object addPic(HttpServletRequest request,HttpServletResponse response
            ,@RequestParam("file") MultipartFile[] file,String id) throws Exception{
		int i=-1;
		List<String> fileNames = new ArrayList<String>();
	    List<File> fileEntity = new ArrayList<File>();
	    //创建一个通用的多部分解析器 
	    CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());  
        //判断 request 是否有文件上传,即多部分请求  
        if(multipartResolver.isMultipart(request)){
            //转换成多部分request    
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;  
            MultiValueMap<String,MultipartFile> multiFileMap = multiRequest.getMultiFileMap();
            List<MultipartFile> fileSet = new LinkedList<MultipartFile>();
            for(Entry<String, List<MultipartFile>> temp : multiFileMap.entrySet()){
                fileSet = temp.getValue();
            }
            for(MultipartFile temp : fileSet){
            	FileUploadUtils.realPath = request.getSession().getServletContext().getRealPath("");
            	String filePath = FileUploadUtils.copyFile(temp.getInputStream(), temp.getOriginalFilename()); 
            	i =i+ picService.savePicUrl(filePath,id);
            }
        }
        return i;
    }
	
	@RequestMapping("/pic/render")
	public String render(Model model,String id,String text){
		 List<PicUrl> picList = picService.queryPicPath(id,text);
		 model.addAttribute("picList",picList);
		 model.addAttribute("tid",id);
		 return "picList/picMain";
	}
	
	
	@RequestMapping("/pic/delPic")
	@ResponseBody
	public Object delPic(String ids){
		return picService.delPic(ids);
	}
	
	
	/**
     * 递归获取整棵树的json
     * @param string
     * @return
     */
    public List<PicTree> getInfosByParentId(String pid,List<PicTree> allST) {
    	 //最顶层parentI
         //st第一次数据库拿到最顶层的数据，根据顶层parentID获取下面的数据
         //allST数据库获取所有的数据对象
         List<PicTree> topCateList = new ArrayList<PicTree>();
         PicTree p = new PicTree("0","0","全部","",null);
         p.setNodes(recursion("0",allST));
         topCateList.add(p);
        return topCateList;
    }

    public List<PicTree> recursion(String id,List<PicTree> allST) {
        List<PicTree> cateList = new ArrayList<PicTree>();
           for(int i = 0;i< allST.size();i++){
                if(id.equals(allST.get(i).getPid())){
                    List<PicTree> twoCateList = recursion(allST.get(i).getId(),allST);
                    allST.get(i).setNodes(twoCateList);
                    cateList.add(allST.get(i));
                }
            }
        return cateList;
    }
}
