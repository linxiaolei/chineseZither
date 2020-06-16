package com.system.mapper;

import com.system.po.Workspace;

public interface WorkspaceMapper {


    void updateData(Workspace workspace);
    
   Workspace selectById(Integer id);

}
