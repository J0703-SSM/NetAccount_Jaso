package com.lanou.cost.service;

import com.lanou.base.util.PageExt;
import com.lanou.cost.domain.Cost;

import java.util.List;

/**
 * Created by dllo on 17/11/11.
 */
public interface CostService {
    List<Cost> findAll(PageExt pageExt);

    int count();

    void operate(Cost cost);

    int delete(int cost_id);

    void addCost(Cost cost);

    Cost verifyName(String name);

    Cost findById(int id);

    void updateCost(Cost cost);

//    List<Cost> findAllOrder(PageExt pageExt);
}
