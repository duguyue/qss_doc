/**
Υ������
**/
INSERT INTO hub_fxsj (
	bjsj,
	fxlb,
	fxzb,
	fxzbz,
	yuzhi,
	cce,
	jgdm,
	jgmc,
	cust_id,
	khmc,
	ywcdbm,
	ywcdmc,
	ywlx,
	ywbm,
	fxsj_id,
	unit
)
SELECT
	to_char((SELECT now() :: TIMESTAMP),'yyyyMMdd HH24:mm:ss') AS bjsj,
	--����ʱ��
	'��Ʒ����' AS fxlb,
	--�������
	'Υ������' AS fxzb,
	--����ָ��
	zjzhdy.nums AS fxzbz,
	--����ָ��ֵ
	CASE
WHEN zjzhdy.nums <= 2 THEN
	1
WHEN zjzhdy.nums >2
AND zjzhdy.nums <=3 THEN
	2
ELSE
	3
END AS yuzhi,
 --��ֵ
CASE
WHEN zjzhdy.nums <= 2 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 1) / 1 * 100,
		2
	)
WHEN zjzhdy.nums > 2
AND zjzhdy.nums <= 3 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 2) / 2 * 100,
		2
	)
ELSE
	round(
		(zjzhdy.nums :: NUMERIC - 3) / 3 * 100,
		2
	)
END AS cce,
 --������
zjzhdy.jys AS jgdm,
 --��������
zjzhdy.jysmc AS jgmc,
 --��������
'' AS cust_id,
 --�ͻ���
'' AS khmc,
 --�ͻ�����
'CPXX' AS ywcdbm,
 --ҵ��˵�����
'������Ϣ' AS ywcdmc,
 --ҵ��˵�����
'���Ĳ�Ʒ����' AS ywlx,
 --ҵ������
zjzhdy.cpdm AS ywbm,
 --ҵ�����
--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
'' AS fxsj_id,
 --
'��' AS unit
FROM
(SELECT
	t1.ywrq,
	t1.cpdm,
	t1.jys,
	p3.jysmc,
	count(t1.cpdm)as  nums--�������ֵ

FROM
	hub_tqs_imp_cjls_ls t1

LEFT JOIN hub_dd_tqs_jysxx p3 ON t1.jys = p3.jys
where t1.cpdm  NOT in(SELECT cpdm from hub_tqs_cpxx)
GROUP BY
	t1.ywrq,
	t1.jys,
	p3.jysmc,
	t1.cpdm
)zjzhdy
WHERE
	zjzhdy.nums > 1