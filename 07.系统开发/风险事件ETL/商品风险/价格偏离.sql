/**
�۸�ƫ��
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
	'�۸�ƫ��' AS fxzb,
	--����ָ��
	zjzhdy.nums AS fxzbz,
	--����ָ��ֵ
	CASE
WHEN zjzhdy.nums <= 4 THEN
	2
WHEN zjzhdy.nums >4
AND zjzhdy.nums <=6 THEN
	4
ELSE
	6
END AS yuzhi,
 --��ֵ
CASE
WHEN zjzhdy.nums <= 4 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 2) / 2 * 100,
		2
	)
WHEN zjzhdy.nums > 4
AND zjzhdy.nums <= 6 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 4) / 4* 100,
		2
	)
ELSE
	round(
		(zjzhdy.nums :: NUMERIC - 6) / 6 * 100,
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
'XXLG' AS ywcdbm,
 --ҵ��˵�����
'���¼۸�' AS ywcdmc,
 --ҵ��˵�����
'���Ĳ�Ʒ����' AS ywlx,
 --ҵ������
zjzhdy.cpbm AS ywbm,
 --ҵ�����
--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
'' AS fxsj_id,
 --
'%' AS unit
FROM
(SELECT
	(P .fvalue - x.jg) / x.jg AS nums,
	P .jys,
	P .jysmc,
	P .cpbm,
	P .cpmc
FROM
	insight_settlement_price P
INNER JOIN hub_xxjg x ON x.pzdm = P .cpbm
)zjzhdy
WHERE
	zjzhdy.nums > 2