select a.comp_cd
   , a.factory_cd
   , a.h_in_cd
   , a.h_in_seq
   , a.in_cd
   , a.in_seq
   , a.order_cd
   , a.order_seq
   , a.request_cd
   , a.request_seq
   , a.item_cd
   , i.item_type_nm
   , i.item_no
   , i.item_nm
   , i.spec
   , i.unit
   , a.supplier_cd
   , c.cust_nm as supplier_nm
   , a.wh_cd
   , wh.wh_nm
   , a.order_qty
   , a.in_price
   , a.supply_amt
   , a.vat_amt
   , a.in_amt
   , a.progress_status
   , a.progress_qty
   , case when a.progress_status = 'completed' then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'interface' then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>') else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>') end as progress_status_nm
   , a.memo
   , a.use_yn
   , a.createdate
   , a.createuser
   , a.updatedate
   , a.updateuser
  from tb_pur_handle_stock_in_detail a
  left join vw_ma_item i on i.item_cd = a.item_cd and i.comp_cd = a.comp_cd and i.factory_cd = a.factory_cd
  left join tb_ma_client c on c.cust_item_cd = a.supplier_cd and c.comp_cd = a.comp_cd and c.factory_cd = a.factory_cd
  left join tb_ma_wh wh on wh.wh_cd = a.wh_cd and wh.comp_cd = a.comp_cd and wh.factory_cd = a.factory_cd
  left join vw_ma_code_pu_progress_status ps on ps.code = a.progress_status
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and a.h_in_cd = {h_in_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
 order by a.in_seq asc