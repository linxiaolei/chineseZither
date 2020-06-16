package com.system.service;

import com.system.po.Product;


import java.util.List;

/**
 * CourseService课程信息.
 */
public interface ProductService {
   
    //获取分页查询课程信息
	List<Product> findAll() throws Exception;
    
	Product findById(Integer id) throws Exception;
	Boolean save(Product product) throws Exception;
	
	void updateById(Product product) throws Exception;
	
	void deleteById(Integer id) throws Exception;
}
