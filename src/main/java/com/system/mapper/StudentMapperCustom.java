package com.system.mapper;

import com.system.po.PagingVO;
import com.system.po.StudentCustom;
import com.system.po.Student;
import com.system.po.SelectedCourseCustom;
import java.util.List;

/**
 * Created by Jacey on 2017/6/28.
 */
public interface StudentMapperCustom {

    //分页查询学生信息
    List<StudentCustom> findByPaging(PagingVO pagingVO) throws Exception;

    //查询学生信息，和其选课信息
    StudentCustom findStudentAndSelectCourseListById(String id) throws Exception;
    
    Student findStudentAndSelectCourseList() throws Exception;

}
