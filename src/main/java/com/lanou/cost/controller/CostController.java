package com.lanou.cost.controller;

import com.lanou.base.util.PageBean;
import com.lanou.base.util.PageExt;
import com.lanou.cost.domain.Cost;
import com.lanou.cost.service.CostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * cost  控制器
 */

@RequestMapping("/cost")
@Controller
public class CostController {

    @Qualifier("costService")
    @Autowired
    private CostService costService;


    /**
     * 查询所有
     * @param request
     */
    @RequestMapping("/findAll")
    public String findAll(HttpServletRequest request){
        //当前页码
        int pc = getPc(request);
        //指定每页记录数
        int ps = 3;
        //传递pc ps 获取pageBean
        PageExt pageExt = new PageExt();
        int pc1 = (pc-1)*3;
        pageExt.setPc(pc1);
        pageExt.setPs(ps);
        List<Cost> costList = costService.findAll(pageExt);
        PageBean<Cost> pb = new PageBean<Cost>();
        //+ bean
        pb.setBeanList(costList);
        //+ 记录数
        pb.setPs(ps);
        //+ 当前页
        pb.setPc(pc);
        System.out.println("资费套餐 : "+costList);
        //+ 总数
        int tr = costService.count();
        System.out.println("套餐总数 : "+tr);
        pb.setTr(tr);
        //= 存入域中
        request.getServletContext().setAttribute("pb",pb);

        return "fee/fee_list";
    }
    /*获取当前页码*/
    private int getPc(HttpServletRequest request) {
        /*
            1. 得到 pc
                > 如果pc参数不存在, pc=1
                > 如果pc参数存在, 转 int
         */
        String value = request.getParameter("pc");
        if (value == null || value.trim().isEmpty()){
            return 1;
        }
        return Integer.parseInt(value);
    }

    /**
     * 启用
     */
    @RequestMapping("/operate")
    public void operate(Cost cost){
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        System.out.println(df.format(date));// new Date()为获取当前系统时间
        cost.setStartime(date);
        costService.operate(cost);
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public void delete(Cost cost){
        costService.delete(cost.getCost_id());
    }
}
