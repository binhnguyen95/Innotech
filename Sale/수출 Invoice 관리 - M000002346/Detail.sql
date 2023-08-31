SELECT a.comp_cd,
       a.factory_cd,
       a.invoice_export_cd,
       a.invoice_export_seq,
       a.order_cd,
       a.order_seq,
       a.project_cd,
       a.item_cd,
       b.item_type_nm,
       b.item_no,
       b.item_nm,
       b.spec,
       b.unit,
       a.qty,
       a.price,
       a.supply_amt,
       a.vat_amt,
       a.amt,
       a.currency_price,
       a.currency_amt,
       a.progress_qty,
       a.progress_status,
       case when a.progress_status = 'completed' then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'delivery_complete' then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', ps.code_value, '</span</span>')
         when a.progress_status = 'confirmed' then concat('<span class="form-circle-sm" style="background-color:#006400;"><span style="color:white;">', ps.code_value, '</span</span>')
         else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', ps.code_value, '</span</span>') 
         end as progress_status_nm
        ,
       a.memo,
       a.use_yn,
       a.createuser,
       a.createdate,
       a.updateuser,
       a.updatedate
FROM tb_sl_invoice_export_detail a
join vw_ma_item b on a.item_cd = b.item_cd
left join vw_ma_code_de_progress_status ps on ps.code = a.progress_status
WHERE  a.invoice_export_cd = {invoice_export_cd}


