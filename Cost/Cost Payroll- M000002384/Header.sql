SELECT
  {cost_type_ser} cost_type_ser,
  {cost_ym_ser} cost_ym_ser,
  {dept_cd_ser} dept_cd_ser,
  a.cost_unit,
  CONVERT(VARCHAR(7), CONVERT(date, LEFT(a.cost_ym, 4) + '-' + RIGHT(a.cost_ym, 2) + '-01', 23), 23) AS cost_ym,
--   a.cost_ym,
  a.cost_seq,
  a.cost_type,
  a.dept_cd,
  a.emp_cd,
  a.salary,
  a.remark,
  a.createuser,
  a.createdate,
  a.updateuser,
  a.updatedate 
FROM
  tb_cost_payroll a
where
    (isnull({cost_type_ser},'') = '' or a.cost_type = {cost_type_ser})
    and (isnull({cost_ym_ser},'') = '' or a.cost_ym = REPLACE(SUBSTRING({cost_ym_ser}, 0, 8), '-', '') )
    and (isnull({dept_cd_ser},'') = '' or a.dept_cd = {dept_cd_ser})
order by    
    a.cost_ym asc, a.cost_seq asc