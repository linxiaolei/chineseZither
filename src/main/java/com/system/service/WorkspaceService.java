package com.system.service;

import com.system.po.Workspace;

/**
 * CourseService课程信息.
 */
public interface WorkspaceService {

		Workspace findById(Integer id) throws Exception;
		
		void updateById(Workspace workspace) throws Exception;
	
}
