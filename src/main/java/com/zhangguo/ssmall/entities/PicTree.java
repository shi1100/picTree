package com.zhangguo.ssmall.entities;

import java.util.ArrayList;
import java.util.List;

public class PicTree {

	private String id;
	private String code;
	private String name;
	private String pid;
	private List<PicTree> nodes;
	
	public PicTree(){}
	
	public PicTree(String id, String code, String name, String pid, List<PicTree> nodes) {
		super();
		this.id = id;
		this.code = code;
		this.name = name;
		this.pid = pid;
		this.nodes = nodes;
	}
	public List<PicTree> getNodes() {
		return nodes;
	}
	public void setNodes(List<PicTree> nodes) {
		this.nodes = nodes;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	
	
}
