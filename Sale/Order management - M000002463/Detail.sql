select a.comp_cd
   , a.factory_cd
   , a.order_cd
   , a.project_cd
   , a.order_seq
   , a.wh_cd
   , a.item_cd
   , i.item_type_nm
   , i.item_no
   , i.item_nm
   , i.spec
   , i.unit
   , a.p_item_cd
   , isnull(s.qty, 0) as available_stock
   , (isnull(s.qty, 0) - isnull(a.order_qty, 0)) as surplus
   , a.order_qty
   , a.order_price
   , a.supply_amt
   , a.vat_amt
   , a.order_amt
   , a.progress_qty
   , a.progress_status
   , case when a.progress_status = 'completed' then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'in_progress' then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'confirmed' then concat('<span class="form-circle-sm" style="background-color:#006400;"><span style="color:white;">', ps.code_value, '</span</span>')
         else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>') end as progress_status_nm
   , a.memo
   , a.use_yn
   , a.createdate
   , a.createuser
   , a.updatedate
   , a.updateuser
  from tb_sl_order_detail a
  left join vw_ma_item i on i.item_cd = a.item_cd
  left join vw_ma_code_od_progress_status ps on ps.code = a.progress_status
  left join (select item_cd, sum(qty) as qty from tb_mt_stock group by item_cd) s on s.item_cd = a.item_cd
 where a.comp_cd = {comp_cd}
   and a.factory_cd = {factory_cd}
   and a.order_cd = {order_cd}
   and isnull(a.use_yn, 'Y') = 'Y'
--  order by a.order_seq asc
order by a.project_cd desc


 