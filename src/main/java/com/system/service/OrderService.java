package com.system.service;

import com.system.po.Order;

import java.util.List;

/**
 * CourseService课程信息.
 */
public interface OrderService {
   
	Boolean save(Order order) throws Exception;
	List<Order> findAll() throws Exception;
	
	void deleteById(Integer id) throws Exception;
}
