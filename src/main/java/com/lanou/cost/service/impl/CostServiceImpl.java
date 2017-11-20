package com.lanou.cost.service.impl;

import com.lanou.base.util.PageExt;
import com.lanou.cost.domain.Cost;
import com.lanou.cost.mapper.CostMapper;
import com.lanou.cost.service.CostService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by dllo on 17/11/11.
 */
@Service("costService")
public class CostServiceImpl implements CostService {


    @Resource
    private CostMapper costMapper;

    /**
     * 查询所有
     * @param pageExt
     * @return
     */
    public List<Cost> findAll(PageExt pageExt) {
        return costMapper.findAll(pageExt);
    }

    /**
     * 总数
     * @return
     */
    public int count() {
        return costMapper.count();
    }

    /**
     * 启用
     * @param cost
     */
    public void operate(Cost cost) {
        costMapper.operate(cost);
    }

    /**
     * 删除
     * @param cost_id
     */
    public int delete(int cost_id) {
        return costMapper.delete(cost_id);
    }

    /**
     * 添加资费
     * @param cost
     */
    public void addCost(Cost cost) {
        costMapper.addCost(cost);
    }

    /**
     * 去重复
     * @param name
     * @return
     */
    public Cost verifyName(String name) {
        return costMapper.verifyName(name);
    }

    /**
     * 查询(id)
     * @param id
     * @return
     */
    public Cost findById(int id) {
        return costMapper.findById(id);
    }


    /**
     * 编辑
     */
    public void updateCost(Cost cost) {

        costMapper.updateCost(cost);
    }
//
//    public List<Cost> findAllOrder(PageExt pageExt) {
//        return costMapper.findAllOrder(pageExt);
//    }
}
