SELECT a.comp_cd,
       a.factory_cd,
       a.in_stk_cd,
       a.in_stk_seq,
       a.in_req_cd,
       a.in_req_seq,
       b.item_cd,
       b.item_no,
       b.item_nm,
       b.item_type_nm,
       b.spec,
       b.unit,
       a.in_qty,
       a.in_out_status,
       CASE
           WHEN a.in_out_status = 'done' THEN concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
           WHEN a.in_out_status = 'processing' THEN concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>')
           when a.in_out_status = 'confirmed' then concat('<span class="form-circle-sm" style="background-color:#006400;"><span style="color:white;">', ps.code_value, '</span</span>')
           ELSE concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>')
       END AS prog_status,
       a.req_type,
       a.memo,
       a.use_yn,
       a.createuser,
       a.createdate,
       a.updateuser,
       a.updatedate
FROM tb_st_in_stock_receipt_item a
LEFT JOIN vw_ma_item b ON a.item_cd = b.item_cd
LEFT JOIN vw_ma_code_stock_status ps ON a.in_out_status = ps.code

WHERE a.comp_cd = {comp_cd}
  AND a.factory_cd = {factory_cd}
  AND isnull(a.use_yn, 'Y') = 'Y'
  AND a.in_stk_cd = {in_stk_cd}
ORDER BY a.in_stk_seq ASC