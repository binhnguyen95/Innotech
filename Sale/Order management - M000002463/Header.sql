select {project_ser} as project_ser
     , {fromdt} as fromdt
     , {todt} as todt
     , {order_type_ser} as order_type_ser
     , {sale_type_ser} as sale_type_ser
     , {cust_ser} as cust_ser
     , {manager_ser} as manager_ser
     , {dept_ser} as dept_ser
     , (case
        when (select count(*) from tb_sl_order_detail dt where dt.progress_status = 'completed' and a.order_cd = dt.order_cd) = (select count(*) from tb_sl_order_detail dt where a.order_cd = dt.order_cd) 
	    then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', '완료', '</span</span>')
	    
	    when (select count(*) from tb_sl_order_detail dt where dt.progress_status = 'confirmed' and a.order_cd = dt.order_cd) = (select count(*) from tb_sl_order_detail dt where a.order_cd = dt.order_cd) 
	    then concat('<span class="form-circle-sm" style="background-color:#006400;"><span style="color:white;">', '승인', '</span</span>')
     
        when (select count(*) from tb_sl_order_detail dt where dt.progress_status = 'in_progress' and a.order_cd = dt.order_cd) > 0
        or (select count(*) from tb_sl_order_detail dt where dt.progress_status = 'completed' and a.order_cd = dt.order_cd) > 0
        then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', '진행중', '</span</span>')
	    
      else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', '작성', '</span</span>') end) as progress_status_nm
     , a.comp_cd
     , a.factory_cd
     , a.order_cd
     , a.order_type
     , e.code_value as order_type_nm
     , a.sale_type
     , s.code_value as sale_type_nm
     , a.order_date
     , a.expected_delivery_date
     , a.delivery_place
     , a.cust_cd
     , a.cust_nm
     , a.cust_manager
     , a.cust_phone_no
     , a.cust_email
     , a.cust_purch_manager
     , a.cust_purch_phone_no
     , a.cust_purch_email
     , a.dept_cd
     , a.manager_id
     , m.USERNAME as manager_nm
     , d.DEPTNM as manager_dept
     , a.have_tax
     , a.tot_supply_amt
     , a.tot_vat_amt
     , a.tot_order_amt
     , a.order_file
     , a.memo
     , a.use_yn
     , a.createdate
     , a.createuser
     , a.updatedate
     , a.updateuser
     , a.order_no
     , a.project_cd
     , a.equip_yn
     , a.cust_delivery_nm
 from tb_sl_order a
 left join vw_ma_code_order_type e on e.code_id = 'order_type' and e.code = a.order_type
 left join vw_ma_code_order_sale_type s on s.code_id = 'order_sale_type' and s.code = a.sale_type
 left join vw_cm_usermaster m on m.UID = a.manager_id
 left join tb_cm_dept d on d.DEPTCD = a.dept_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
   and (isnull({project_ser},'') = '' or a.project_cd like concat('%', {project_ser}, '%'))
   and (isnull({fromdt},'') = '' or a.order_date >= {fromdt})
   and (isnull({todt},'') = '' or a.order_date <= {todt})
   and (isnull({order_type_ser},'') = '' or a.order_type = {order_type_ser})
   and (isnull({sale_type_ser},'') = '' or a.sale_type = {sale_type_ser})
   and (isnull({cust_ser},'') = '' or a.cust_nm like concat('%', {cust_ser}, '%') or a.cust_manager like concat('%', {cust_ser}, '%') or a.cust_phone_no like concat('%', {cust_ser}, '%') or a.cust_email like concat('%', {cust_ser}, '%') or a.cust_purch_manager like concat('%', {cust_ser}, '%') or a.cust_purch_phone_no like concat('%', {cust_ser}, '%') or a.cust_purch_email like concat('%', {cust_ser}, '%'))
   and (isnull({manager_ser},'') = '' or a.manager_id = {manager_ser})
   and (isnull({dept_ser},'') = '' or a.dept_cd = {dept_ser})
 order by a.project_cd desc