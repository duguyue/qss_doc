/**
��󲨷�
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
	to_char(
		(SELECT now() :: TIMESTAMP),
		'yyyyMMdd HH24:mm:ss'
	) AS bjsj,
	--����ʱ��
	'��Ʒ����' AS fxlb,
	--�������
	'��󲨷�' AS fxzb,
	--����ָ��
	zjzhdy.nums AS fxzbz,
	--����ָ��ֵ
	CASE
WHEN zjzhdy.nums <= 12 THEN
	8
WHEN zjzhdy.nums > 12
AND zjzhdy.nums <= 16 THEN
	12
ELSE
	16
END AS yuzhi,
 --��ֵ
CASE
WHEN zjzhdy.nums <= 12 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 8) / 8 * 100,
		2
	)
WHEN zjzhdy.nums > 12
AND zjzhdy.nums <= 16 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 12) / 12 * 100,
		2
	)
ELSE
	round(
		(zjzhdy.nums :: NUMERIC - 16) / 16 * 100,
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
'JYXX' AS ywcdbm,
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
'%' AS unit
FROM
(SELECT
	t1.ywrq,
	t1.cpdm,
	t1.jys,
	p3.jysmc,
	MAX (t1.cjje) maxcjje,--�������ֵ
  min(t1.cjje) mincjje,--������Сֵ
MAX(t1.cjje)-min(t1.cjje) as ce,--�����ֵ
(SELECT  min(i.cjje) from hub_tqs_imp_cjls_ls i where   i.ywrq=to_char(to_date(t1.ywrq, 'yyyymmdd') + interval '-1 day','yyyymmdd')) as lastmin,
--T-1����ͳɽ��۸�
(MAX(t1.cjje)-min(t1.cjje))/(SELECT  min(i.cjje) from hub_tqs_imp_cjls_ls i where   i.ywrq=to_char(to_date(t1.ywrq, 'yyyymmdd') + interval '-1 day','yyyymmdd')) as nums
FROM
	hub_tqs_imp_cjls_ls t1

LEFT JOIN hub_dd_tqs_jysxx p3 ON t1.jys = p3.jys

GROUP BY
	t1.ywrq,
	t1.jys,
	p3.jysmc,
	t1.cpdm
)zjzhdy
WHERE
	zjzhdy.nums > 8