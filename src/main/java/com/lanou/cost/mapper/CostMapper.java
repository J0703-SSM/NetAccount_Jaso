package com.lanou.cost.mapper;

import com.lanou.base.util.PageBean;
import com.lanou.base.util.PageExt;
import com.lanou.cost.domain.Cost;

import java.util.List;

/**
 * Created by dllo on 17/11/10.
 */
public interface CostMapper {
    List<Cost> findAll(PageExt pageExt);

    int count();

    void operate(Cost cost);

    void delete(int cost_id);
}
