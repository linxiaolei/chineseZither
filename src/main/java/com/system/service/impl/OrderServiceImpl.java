package com.system.service.impl;

import com.system.mapper.OrderMapper;
import com.system.po.Order;
import com.system.service.OrderService;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


/**
 * Created by Jacey on 2017/6/30.
 */
@Service
public class OrderServiceImpl implements OrderService {
	 @Autowired
	 private OrderMapper orderMapper;

	@Override
	public Boolean save(Order order) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(order.getOrderId());
		orderMapper.insertData(order);
		
		return true;
	}

	@Override
	public List<Order> findAll() throws Exception {
		// TODO Auto-generated method stub
		return orderMapper.selectAll();
	}

	@Override
	public void deleteById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		orderMapper.deleteById(id);
	}
}
