/**
Ƶ������
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
	'���׷���' AS fxlb,
	--�������
	'Ƶ������' AS fxzb,
	--����ָ��
	zjzhdy.nums AS fxzbz,
	--����ָ��ֵ
	CASE
WHEN zjzhdy.nums <= 40 THEN
	20
WHEN zjzhdy.nums > 40
AND zjzhdy.nums <= 60 THEN
	40
ELSE
	60
END AS yuzhi,
 --��ֵ
CASE
WHEN zjzhdy.nums <= 40 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 20) / 20 * 100,
		2
	)
WHEN zjzhdy.nums > 40
AND zjzhdy.nums <= 60 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 40) / 40 * 100,
		2
	)
ELSE
	round(
		(zjzhdy.nums :: NUMERIC - 60) / 60 * 100,
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
'�ͻ���' AS ywlx,
 --ҵ������
zjzhdy.cpdm AS ywbm,
 --ҵ�����
--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
'' AS fxsj_id,
 --
'��' AS unit
FROM
	(
		SELECT
			t1.ywrq,
			t1.cpdm,
			COUNT (t1.cpdm) nums,
			t1.jys,
			p3.jysmc
		FROM
			hub_tqs_imp_cjls_ls t1
		LEFT JOIN hub_dd_tqs_jysxx p3 ON t1.jys = p3.jys
		GROUP BY
			t1.ywrq,
			t1.jys,
			t1.cpdm,
			p3.jysmc
	) zjzhdy
WHERE
	zjzhdy.nums > 20