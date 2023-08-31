select
    {req_cd_search} as req_cd_search,
    {from_date} as from_date,
    {to_date} as to_date,
    {wh_cd_ser} as wh_cd_ser,
    {cust_cd_search} as cust_cd_search,
    {in_stk_type_ser} in_stk_type_ser,
  a.comp_cd,
  a.factory_cd,
  a.in_req_cd,
  a.wh_cd,
  b.wh_nm,
  a.cust_cd,
  c.cust_nm,
  a.in_stk_type,
  a.in_req_ymd,
  a.memo,
  a.use_yn,
  a.createuser,
  a.createdate,
  a.updateuser,
  a.updatedate
  from tb_st_in_stock_req a
  left join tb_ma_wh b on a.wh_cd = b.wh_cd
  left join tb_ma_client c on a.cust_cd = c.cust_item_cd
  
where
a.comp_cd = {comp_cd}
and a.factory_cd = {factory_cd}
and isnull(a.use_yn, 'Y') = 'Y'
and (isnull({from_date},'') = '' or a.in_req_ymd >= {from_date})
and (isnull({to_date},'') = '' or a.in_req_ymd <= {to_date})
and (isnull({req_cd_search},'') = '' or a.in_req_cd like concat('%', {req_cd_search}, '%'))
and (isnull({wh_cd_ser},'') = '' or a.wh_cd = {wh_cd_ser})
and (isnull({cust_cd_search},'') = '' or a.cust_cd = {cust_cd_search})
and (isnull({in_stk_type_ser},'') = '' or a.in_stk_type = {in_stk_type_ser})
order by a.in_req_cd desc