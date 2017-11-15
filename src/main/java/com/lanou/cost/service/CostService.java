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

    void delete(int cost_id);
}
