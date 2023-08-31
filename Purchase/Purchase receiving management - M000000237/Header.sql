select distinct 
    {fromdt} as fromdt
     , {todt} as todt
     , {in_cd_ser} as in_cd_ser
     , {order_cd_ser} as order_cd_ser
     , {project_cd_ser} as project_cd_ser
     , {request_type_ser} as request_type_ser
     , {sale_type_ser} as sale_type_ser
     , {manager_ser} as manager_ser
     , {dept_ser} as dept_ser
     , {supplier_ser} as supplier_ser
     , b.supplier_cd
     , sp.cust_nm as supplier_nm
     , a.comp_cd
     , a.factory_cd
     , a.in_cd
     , a.order_cd
     , a.request_cd
     , a.project_cd
     , a.request_type
     , rt.code_value as request_type_nm
     , a.sale_type
     , s.code_value as sale_type_nm
     , a.delivery_date
     , a.in_date
     , a.wh_cd
     , wh.wh_nm
     , a.cust_cd
     , a.cust_nm
     , a.cust_manager
     , a.cust_phone_no
     , a.cust_email
     , a.request_dept
     , a.requester
     , mn.USERNAME as requester_nm
     , dn.DEPTNM as request_dept_nm
     , a.dept_cd
     , a.manager_id
     , m.USERNAME as manager_nm
     , d.DEPTNM as manager_dept
     , a.in_file
     , a.have_tax
     , a.tot_supply_amt
     , a.tot_vat
     , a.tot_in_amt
     , a.memo
     , a.use_yn
     , a.createdate
     , a.createuser
     , a.updatedate
     , a.updateuser
 from tb_pur_stock_in a
 left join tb_pur_stock_in_detail b on a.in_cd = b.in_cd
 left join tb_ma_wh wh on wh.wh_cd = a.wh_cd and wh.comp_cd = a.comp_cd and wh.factory_cd = a.factory_cd
 left join vw_ma_code_request_type rt on rt.code = a.request_type
 left join vw_ma_code_request_sale_type s on s.code = a.sale_type
 left join vw_cm_usermaster m on m.UID = a.manager_id
 left join tb_cm_dept d on d.DEPTCD = a.dept_cd
 left join vw_cm_usermaster mn on mn.UID = a.requester
 left join tb_cm_dept dn on dn.DEPTCD = a.request_dept
 left join tb_ma_client sp on sp.cust_item_cd = b.supplier_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
   and (isnull({fromdt},'') = '' or a.in_date >= {fromdt})
   and (isnull({todt},'') = '' or a.in_date <= {todt})
   and (isnull({in_cd_ser},'') = '' or a.in_cd like concat('%', {in_cd_ser}, '%'))
   and (isnull({order_cd_ser},'') = '' or a.order_cd = {order_cd_ser})
   and (isnull({project_cd_ser},'') = '' or a.project_cd like concat('%', {project_cd_ser}, '%'))
   and (isnull({request_type_ser},'') = '' or a.request_type = {request_type_ser})
   and (isnull({sale_type_ser},'') = '' or a.sale_type = {sale_type_ser})
   and (isnull({manager_ser},'') = '' or a.manager_id = {manager_ser})
   and (isnull({dept_ser},'') = '' or a.dept_cd = {dept_ser})
   and (isnull({supplier_ser},'') = '' or a.supplier_cd like concat('%', {supplier_ser}, '%') or sp.cust_nm like concat('%', {supplier_ser}, '%'))
 order by a.createdate desc