SELECT a.comp_cd,
       a.factory_cd,
       a.in_out_status,
       CASE
           WHEN a.in_out_status = 'done' THEN concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
           WHEN a.in_out_status = 'processing' THEN concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>')
           ELSE concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>')
       END AS prog_status,
       a.in_req_cd,
       a.in_req_seq,
       a.item_cd,
       c.item_no,
       c.item_nm,
       c.spec,
       c.unit,
       c.item_type_nm,
       a.req_qty,
       a.prog_qty,
       a.req_type,
       a.memo,
       a.use_yn,
       a.createuser,
       a.createdate,
       a.updateuser,
       a.updatedate
FROM tb_st_in_stock_req_item a
LEFT JOIN tb_st_in_stock_req b ON a.in_req_cd = b.in_req_cd
LEFT JOIN vw_ma_item c ON a.item_cd = c.item_cd
JOIN vw_ma_code_stock_status ps ON a.in_out_status = ps.code
WHERE a.comp_cd = {comp_cd}
  AND a.factory_cd = {factory_cd}
  AND a.in_req_cd = {in_req_cd}
  AND isnull(a.use_yn, 'Y') = 'Y'
ORDER BY a.in_req_seq ASC