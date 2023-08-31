select {fromdt} as fromdt
     , {todt} as todt
     , {order_cd_ser} as order_cd_ser
     , {project_cd_ser} as project_cd_ser
     , {request_type_ser} as request_type_ser
     , {sale_type_ser} as sale_type_ser
     , {manager_ser} as manager_ser
     , {dept_ser} as dept_ser
     , {supplier_ser} as supplier_ser
     , a.comp_cd
     , a.factory_cd
     , a.order_cd
     , a.request_cd
     , a.project_cd
     , a.request_type
     , rt.code_value as request_type_nm
     , a.sale_type
     , s.code_value as sale_type_nm
     , a.order_date
     , a.delivery_date
     , a.supplier_cd
     , sp.cust_nm as supplier_nm
     , CONCAT(
        isnull((select TOP 1 it.item_nm from tb_pur_order_detail od left join tb_ma_item it on it.item_cd = od.item_cd where od.order_cd = a.order_cd order by od.order_seq asc),''),
        (case when  (select count(*) from tb_pur_order_detail where tb_pur_order_detail.order_cd = a.order_cd) > 1
        then concat (' 외 ', isnull((select count(*) from tb_pur_order_detail where tb_pur_order_detail.order_cd = a.order_cd),1) - 1, '건')
        else ''
        end)
     ) as item_nm
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
     , a.have_tax
     , a.tot_vat
     , a.tot_supply_amt
     , a.tot_order_amt
     , a.memo
     , a.use_yn
     , a.status
     , a.createdate
     , a.createuser
     , a.updatedate
     , a.updateuser
     , CASE
       WHEN a.status = 'done' THEN concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', '확정', '</span</span>')
       WHEN a.status = 'stop' THEN concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', '취소', '</span</span>')
       ELSE concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', '작성', '</span</span>')
    END AS status_name
    , (SELECT [dbo].[CONVERT_AMT_NUM_TO_AMT_WORD](a.tot_order_amt)) as total_order_amt_str
    , (SELECT [dbo].[CONVERT_DATE_TO_DATE_WORD](a.order_date)) as order_date_str
    , (SELECT  [dbo].[CONVERT_AMT_NUM_TO_AMT_WORD_ver2](a.tot_supply_amt)) as supply_amt_str
    , a.delivery_date
    ,(SELECT [dbo].[CONVERT_DATE_TO_DATE_WORD](a.delivery_date)) as delivery_date_str
    
 from tb_pur_order a
 left join tb_ma_project pj on pj.project_cd = a.project_cd
 left join vw_ma_code_request_type rt on rt.code = a.request_type
 left join vw_ma_code_request_sale_type s on s.code = a.sale_type
 left join vw_cm_usermaster m on m.UID = a.manager_id
 left join tb_cm_dept d on d.DEPTCD = a.dept_cd
 left join vw_cm_usermaster mn on mn.UID = a.requester
 left join tb_cm_dept dn on dn.DEPTCD = a.request_dept
 left join tb_ma_client sp on sp.cust_item_cd = a.supplier_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
   and (isnull({fromdt},'') = '' or a.order_date >= {fromdt})
   and (isnull({todt},'') = '' or a.order_date <= {todt})
   and (isnull({order_cd_ser},'') = '' or a.order_cd like concat('%', {order_cd_ser}, '%'))
   and (isnull({project_cd_ser},'') = '' or a.project_cd like concat('%', {project_cd_ser}, '%'))
   and (isnull({request_type_ser},'') = '' or a.request_type = {request_type_ser})
   and (isnull({sale_type_ser},'') = '' or a.sale_type = {sale_type_ser})
   and (isnull({manager_ser},'') = '' or a.manager_id = {manager_ser})
   and (isnull({dept_ser},'') = '' or a.dept_cd = {dept_ser})
   and (isnull({supplier_ser},'') = '' or a.supplier_cd like concat('%', {supplier_ser}, '%') or sp.cust_nm like concat('%', {supplier_ser}, '%'))
 order by a.createdate desc