package com.system.mapper;

import java.util.List;

import com.system.po.Order;
public interface OrderMapper {


    void insertData(Order order);
    List<Order> selectAll();
    void deleteById(Integer id);
}
