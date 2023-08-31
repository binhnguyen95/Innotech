select a.comp_cd,
    a.factory_cd,
    a.work_order_cd,
    a.plan_cd,
    a.project_cd,
    a.item_cd,
    it.item_nm,
    it.spec,
    a.sort,
    a.work_order_date,
    a.wh_cd,
    wh.wh_nm,
    a.process_qty,
    a.process_status,
    a.cust_cd,
    c.cust_nm,
    a.memo,
    a.use_yn,
    a.createuser,
    a.createdate,
    a.updateuser,
    a.updatedate
from tb_prod_work_order a
    left join tb_ma_item it on it.item_cd = a.item_cd and it.comp_cd = a.comp_cd and it.factory_cd = a.factory_cd
    left join tb_ma_client c on c.cust_item_cd = a.cust_cd and c.comp_cd = a.comp_cd and c.factory_cd = a.factory_cd
    left join tb_ma_wh wh on wh.wh_cd = a.wh_cd and wh.comp_cd = a.comp_cd and wh.factory_cd = a.factory_cd
where a.comp_cd = {comp_cd}
and a.factory_cd = {factory_cd}
and a.work_order_cd = {work_order_cd}
and isnull(a.use_yn,'Y') = 'Y'
order by a.createdate desc