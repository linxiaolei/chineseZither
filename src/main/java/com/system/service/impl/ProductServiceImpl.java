package com.system.service.impl;

import com.system.mapper.ProductMapper;
import com.system.po.Product;
import com.system.po.Teacher;
import com.system.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by Jacey on 2017/6/30.
 */
@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductMapper ProductMapper;

	@Override
	public List<Product> findAll() throws Exception {
		// TODO Auto-generated method stub
		return ProductMapper.selectAll();
	}

	@Override
	public Product findById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		return ProductMapper.selectById(id);
	}

	@Override
	public Boolean save(Product product) throws Exception {
		// TODO Auto-generated method stub
		 System.out.println(product.getPrice());
		ProductMapper.insertData(product);
	      
		return true;
	}

	@Override
	public void updateById(Product product) throws Exception {
		// TODO Auto-generated method stub
		ProductMapper.updateData(product);
	}

	@Override
	public void deleteById(Integer id) throws Exception {
		// TODO Auto-generated method stub
		ProductMapper.deleteById(id);
	}
	
	
}
