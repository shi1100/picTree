package com.zhangguo.ssmall.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zhangguo.ssmall.entities.PicTree;
import com.zhangguo.ssmall.entities.PicUrl;

public interface PicDAO {

	
	public List<PicTree> getPicList(@Param("name") String name,@Param("code") String code);
	
	public int addNode(PicTree node);
	
	public int delNode(PicTree node);
	
	public int savePicUrl(@Param("path")String path,@Param("id")String id);
	
	public List<PicUrl> queryPicPath(@Param("id")String id,@Param("text")String text);
	
	public int delPic(@Param("ids")String ids);
	
	public int updateNode(PicTree node);
	
	public List<PicTree> getPicListbyText(@Param("text")String text);
	
	public PicTree getPicListbyPid(@Param("id")String id);
}
