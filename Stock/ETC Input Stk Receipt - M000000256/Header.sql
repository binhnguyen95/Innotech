select
    {from_date} as from_date,
    {to_date} as to_date,
    {wh_cd_srch} as wh_cd_srch,
    {cust_cd_srch} as cust_cd_srch,
    {stk_cd_srch} as stk_cd_srch,
    {in_stk_type_ser} in_stk_type_ser,
  a.comp_cd,
  a.factory_cd,
  a.in_stk_cd,
  a.in_req_cd,
  a.wh_cd,
  b.wh_nm,
  a.cust_cd,
  c.cust_nm,
  a.in_stk_type,
  a.in_stk_ymd,
  a.memo,
  a.use_yn,
  a.status,
  a.createuser,
  a.createdate,
  a.updateuser,
  a.updatedate,
  CASE
       WHEN a.status = 'done' THEN concat('<span class="form-circle-sm" style="background-color:#0063B2;"><span style="color:white;">', '완료', '</span</span>')
       WHEN a.status = 'stop' THEN concat('<span class="form-circle-sm" style="background-color:#fca326;"><span style="color:white;">', '취소', '</span</span>')
       ELSE concat('<span class="form-circle-sm" style="background-color:#2BAE66;"><span style="color:white;">', '작성', '</span</span>')
    END AS status_name
  from tb_st_in_stock_receipt  a
  left join tb_ma_wh b on a.wh_cd = b.wh_cd
  left join tb_ma_client c on a.cust_cd = c.cust_item_cd
  left join tb_st_in_stock_receipt re on a.in_stk_cd = re.in_stk_cd
where
a.comp_cd = {comp_cd}
and a.factory_cd = {factory_cd}
and isnull(a.use_yn,'Y')  = 'Y'
and (isnull({stk_cd_srch},'') = '' or a.in_stk_cd like concat('%', {stk_cd_srch}, '%'))
and (isnull({from_date},'') = '' or a.in_stk_ymd >= {from_date})
and (isnull({to_date},'') = '' or a.in_stk_ymd <= {to_date})
and (isnull({wh_cd_srch},'') = '' or a.wh_cd = {wh_cd_srch})
and (isnull({cust_cd_srch},'') = '' or a.cust_cd = {cust_cd_srch})
and (isnull({in_stk_type_ser},'') = '' or a.in_stk_type = {in_stk_type_ser})
order by a.in_stk_cd desc