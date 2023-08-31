select a.comp_cd
   , a.factory_cd
   , a.work_order_cd
   , a.work_order_seq
   , a.item_cd
   , i.item_no
   , i.item_nm
   , i.item_type_nm
   
   , i.spec
   , i.unit
   , a.bom_level
   , a.qty
   , a.process_qty
   , '' as input_qty
   , (SELECT TOP 1 wh_cd FROM tb_ma_wh where wh_type = 'WH_TYPE3' and use_yn = 'Y') as wh_cd
   , isnull(s.qty, 0) as available_stock
   , a.process_status
   , a.use_yn
   , a.remark
   , a.createdate
   , a.createuser
   , a.updatedate
   , a.updateuser
  from tb_prod_work_order_detail a
  left join vw_ma_item i on i.item_cd = a.item_cd
  left join (select item_cd, sum(UseQty) as qty from tb_ts_nqty where wh_cd = (SELECT TOP 1 wh_cd FROM tb_ma_wh where wh_type = 'WH_TYPE3' and use_yn = 'Y') group by item_cd) s on s.item_cd = a.item_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and a.work_order_cd = {work_order_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
 order by a.work_order_seq asc