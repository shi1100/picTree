package com.zhangguo.ssmall.services;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zhangguo.ssmall.entities.PicTree;
import com.zhangguo.ssmall.entities.PicUrl;
import com.zhangguo.ssmall.mapper.PicDAO;

@Service
public class PicServiceImpl {
		//自动装配
		@Resource
		private PicDAO picdao;
		
		
		public List<PicTree> getPicList(String name,String code) {
			return picdao.getPicList(name, code);
		}
		
		
		public int addNode(PicTree node) {
			return picdao.addNode(node);
		}
		
		public int delNode(PicTree node) {
			return picdao.delNode(node);
		}
		
		public int savePicUrl(String path,String id) {
			return picdao.savePicUrl(path,id);
		}
		
		public List<PicUrl> queryPicPath(String id,String text) {
			return picdao.queryPicPath(id,text);
		}
		
		public int delPic(String ids) {
			return picdao.delPic(ids);
		}
		
		public int updateNode(PicTree node) {
			return picdao.updateNode(node);
		}
		
		
		public List<PicTree> getPicListbyText(String text){
			return picdao.getPicListbyText(text);
		}
		
		public PicTree getPicListbyPid(String id){
			return picdao.getPicListbyPid(id);
		}

}
