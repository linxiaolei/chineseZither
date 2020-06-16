package com.system.mapper;

import com.system.po.Product;


import java.util.List;

public interface ProductMapper {


    List<Product> selectAll();

	Product selectById(Integer id);
	
	void insertData(Product product);
	 
	void updateData(Product product);
	
	void deleteById(Integer id);

}
