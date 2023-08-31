
  select {cust_ser} as cust_ser,
        {dept_ser} as dept_ser,
        {fromdt} as fromdt,
        {todt} as todt,
        {invoice_export_type_ser} as invoice_export_type_ser,
        {sale_type_ser} as sale_type_ser,
        {project_cd_ser} as project_cd_ser,
            a.comp_cd,
          a.factory_cd,
          a.invoice_export_cd,
          a.order_cd,
          a.project_cd,
          a.invoice_export_type,
          a.sale_type,
          a.invoice_export_date,
          a.invoice_export_address,
          a.wh_cd,
          a.cust_delivery_nm,
          a.cust_cd,
          a.cust_nm,
          a.cust_manager,
          a.cust_phone_no,
          a.cust_email,
          a.cust_purch_manager,
          a.cust_purch_phone_no,
          a.cust_purch_email,
          a.dept_cd,
          a.manager_id,
          a.have_tax,
          case when a.have_tax = 'notax' then '면세'
          when a.have_tax = 'tax-0' then '영세율' end as tax,
          a.tot_supply_amt,
          a.tot_vat_amt,
          a.tot_amt,
          a.currency_unit,
          a.currency_ratio,
          a.tot_currency_amt,
          a.equip_yn,
          a.order_no,
          a.memo,
          a.use_yn,
          a.status,
          case when a.status = 'done' then concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', '확정', '</span</span>')
          when a.status = 'stop' then concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', '취소', '</span</span>') 
          else concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', '작성', '</span</span>') 
          end as status_name,
          a.createuser,
          a.createdate,
          a.updateuser,
          a.updatedate
from tb_sl_invoice_export a
left join tb_cm_dept d on d.DEPTCD = a.dept_cd
join vw_ma_code_order_sale_type b on b.code = a.sale_type 
where 
(isnull(a.use_yn,'') = 'Y')
and (isnull({cust_ser},'') = '' or a.cust_nm like concat('%', {cust_ser}, '%') or a.cust_manager like concat('%', {cust_ser}, '%') or a.cust_phone_no like concat('%', {cust_ser}, '%') or a.cust_email like concat('%', {cust_ser}, '%') or a.cust_purch_manager like concat('%', {cust_ser}, '%') or a.cust_purch_phone_no like concat('%', {cust_ser}, '%') or a.cust_purch_email like concat('%', {cust_ser}, '%'))
and (isnull({dept_ser},'') = '' or a.dept_cd = {dept_ser})
and (isnull({fromdt},'') = '' or a.invoice_export_date >= {fromdt})
and (isnull({todt},'') = '' or a.invoice_export_date <= {todt})
and (isnull({project_cd_ser},'') = '' or a.project_cd like concat('%', {project_cd_ser}, '%'))
and (isnull({invoice_export_type_ser},'') = '' or a.invoice_export_type = {invoice_export_type_ser})
and (isnull({sale_type_ser},'') = '' or a.sale_type = {sale_type_ser})
order by a.invoice_export_cd desc

