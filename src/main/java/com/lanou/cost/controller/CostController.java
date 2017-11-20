package com.lanou.cost.controller;

import com.lanou.base.util.PageBean;
import com.lanou.base.util.PageExt;
import com.lanou.cost.domain.Cost;
import com.lanou.cost.service.CostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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

    //指定每页记录数
    private int ps = 3;

    /**
     * 查询所有
     * @param request
     */
    @RequestMapping("/findAll")
    public String findAll(HttpServletRequest request){
        //当前页码
        int pc = getPc(request);

        //传递pc ps 获取pageBean
        PageExt pageExt = new PageExt();
        //设置分页参数
        pageExt.setPc((pc-1)*3);

//排序
        String  sort= request.getParameter("sort");
        String column = request.getParameter("column");
        //
        request.setAttribute("sort",sort);
        request.setAttribute("column",column);
        //默认排序
        if (sort == null || sort.equals("")){
            sort = "asc";
        }
        if (column == null || column.equals("")){
            column ="base_cost";
        }

        //设置排序参数
        pageExt.setSort(sort);
        pageExt.setColumn(column);

        //查询
        List<Cost> costList = costService.findAll(pageExt);
        PageBean<Cost> pb = new PageBean<Cost>();
        //+ bean
        pb.setBeanList(costList);
        //+ 记录数
        pb.setPs(ps);
        //+ 当前页
        pb.setPc(pc);
        //+ 总数
        int tr = costService.count();
        pb.setTr(tr);

        //= 存入域中
        request.setAttribute("pb",pb);

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
    public String operate(Cost cost){
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        df.format(date);// new Date()为获取当前系统时间
        cost.setStartime(date);
        costService.operate(cost);
        return "forward:findAll";
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public String delete(Cost cost){

        int count = costService.delete(cost.getCost_id());

        System.out.println(count);

        return "forward:findAll";
    }

    /**
     * 判重复
     */
    @ResponseBody
    @RequestMapping("/verifyName")
    public int verifyName(Cost cost){
        Cost cost1 = costService.verifyName(cost.getName());
        int id = cost.getCost_id();

        System.out.println(id);
        if (cost1 == null || id == cost1.getCost_id()){
            return 1;
        }
        return 0;
    }
    /**
     * 添加
     */
    @RequestMapping("/addCost")
    public String addCost(Cost cost){
        Date date = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        df.format(date);// new Date()为获取当前系统时间
        cost.setCreatime(date);//设置创建时间
        cost.setStatus("0");//设置初始状态(未开启)

        costService.addCost(cost);
        return "redirect:findAll";
    }
    /**
     * 查询(id)
     */
    @RequestMapping("/findCost/{id}")
    public String findCost(
            @PathVariable
            int id,
            Model model
    ){
        Cost cost = costService.findById(id);
        model.addAttribute("cost",cost);
        return "fee/fee_modi";
    }
    /**
     * 编辑
     */
    @RequestMapping("/updateCost")
    public String updateCost(Cost cost){
        costService.updateCost(cost);
        return "forward:findAll";
    }
    /**
     * 明细
     */
    @RequestMapping("/detail/{id}")
    public String detail(
            @PathVariable
            int id,
            Model model
    ){
        Cost cost = costService.findById(id);
        model.addAttribute("cost",cost);
        return "fee/fee_detail";
    }
}
