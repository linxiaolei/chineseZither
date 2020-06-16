package com.system.service.impl;

import com.system.mapper.WorkspaceMapper;
import com.system.po.Workspace;
import com.system.service.WorkspaceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class WorkspaceServiceImpl implements WorkspaceService {

    @Autowired
    private WorkspaceMapper workspaceMapper;

	
	@Override
	public void updateById(Workspace workspace) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(workspace.getwId());
		workspaceMapper.updateData(workspace);
	}


	@Override
	public Workspace findById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return workspaceMapper.selectById(id);
	}
    
    

    
}
