select a.comp_cd
   , a.factory_cd
   , a.order_cd
   , a.order_seq
   , a.request_cd
   , a.request_seq
   , a.item_cd
   , a.sale_order_item_cd
   , i.item_type_nm
   , i.item_no
   , i.item_nm
   , i.spec
   , i.unit
   , a.supplier_cd
   , c.cust_nm as supplier_nm
   , isnull(s.qty, 0) as available_stock
   , (isnull(s.qty, 0) - isnull(a.order_qty, 0)) as surplus
   , rd.request_qty
   , a.order_qty
   , a.order_price
   , a.supply_amt
   , a.vat_amt
   , a.order_amt
   , a.progress_status
   , a.progress_qty
   , case when a.progress_status = 'completed' then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'processing' then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'confirmed' then concat('<span class="form-circle-sm" style="background-color:#006400;"><span style="color:white;">', ps.code_value, '</span</span>')
         else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>') end as progress_status_nm
   , a.memo
   , a.use_yn
   , a.createdate
   , a.createuser
   , a.updatedate
   , a.updateuser
   
   ,bom.createdate as bom_createdate
  from tb_pur_order_detail a
  left join vw_ma_item i on i.item_cd = a.item_cd and i.comp_cd = a.comp_cd and i.factory_cd = a.factory_cd
  left join tb_ma_client c on c.cust_item_cd = a.supplier_cd and c.comp_cd = a.comp_cd and c.factory_cd = a.factory_cd
  left join tb_pur_request_detail rd on rd.request_cd = a.request_cd and rd.request_seq = a.request_seq and rd.comp_cd = a.comp_cd and rd.factory_cd = a.factory_cd
  left join (select item_cd, sum(UseQty) as qty from tb_ts_nqty group by item_cd) s on s.item_cd = a.item_cd
  left join vw_ma_code_po_progress_status ps on ps.code = a.progress_status
  left join tb_ma_bom bom on a.sale_order_item_cd = bom.prod_item_cd and a.item_cd = bom.c_item_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and a.order_cd = {order_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
 order by bom_createdate