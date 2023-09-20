select a.comp_cd
     , a.factory_cd
     , a.order_cd
     , a.order_type
     , a.sale_type
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
     , a.have_tax
     , a.tot_supply_amt
     , a.tot_vat_amt
     , a.tot_order_amt
     , a.order_file
     , '' as order_file_btn
     , a.memo
     , a.use_yn
     , a.createdate
     , a.createuser
     , a.updatedate
     , a.updateuser
     , a.order_no
     , a.project_type
     , b.code_value project_type_nm
     , a.project_no
     , c.code_value project_no_nm
     , a.project_cd
     , a.equip_yn
     , a.cust_delivery_nm
     , {cust_delivery_cd} cust_delivery_cd
 from tb_sl_order a
    left join tb_ma_code b on b.code_id = 'project_type' and b.code = a.project_type
    left join tb_ma_code c on c.code_id = 'project_no' and c.code = a.project_no
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and (isnull({order_cd},'') != '' and a.order_cd = {order_cd})
   and isnull(a.use_yn, 'Y') = 'Y'
 order by a.order_date desc