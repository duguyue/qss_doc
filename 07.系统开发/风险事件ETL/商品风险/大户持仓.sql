/**
�󻧳ֲ�
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
	'�󻧳ֲ�' AS fxzb,
	--����ָ��
	zjzhdy.nums AS fxzbz,
	--����ָ��ֵ
	CASE
WHEN zjzhdy.nums <= 40 THEN
	30
WHEN zjzhdy.nums >40
AND zjzhdy.nums <=50 THEN
	40
ELSE
	50
END AS yuzhi,
 --��ֵ
CASE
WHEN zjzhdy.nums <= 40 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 30) / 30 * 100,
		2
	)
WHEN zjzhdy.nums > 40
AND zjzhdy.nums <= 50 THEN
	round(
		(zjzhdy.nums :: NUMERIC - 40) / 40* 100,
		2
	)
ELSE
	round(
		(zjzhdy.nums :: NUMERIC - 50) / 50 * 100,
		2
	)
END AS cce,
 --������
zjzhdy.jys AS jgdm,
 --��������
zjzhdy.jysmc AS jgmc,
 --��������
zjzhdy.cid AS cust_id,
 --�ͻ���
zjzhdy.khxm AS khmc,
 --�ͻ�����
'JYXX' AS ywcdbm,
 --ҵ��˵�����
'������Ϣ' AS ywcdmc,
 --ҵ��˵�����
'���Ĳ�Ʒ����' AS ywlx,
 --ҵ������
zjzhdy.cpbm AS ywbm,
 --ҵ�����
--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
'' AS fxsj_id,
 --
'%' AS unit

from(

SELECT vday,cid,khxm,jys,jysmc,jysinfo,cpbm,cpmc,sum(fvalue) as nu,
(SELECT sum(fvalue)  from insight_position_amount t  where t.vday=t1.vday and t.jys=t1.jys and t.cpbm=t1.cpbm ) as allnums,
round(sum(fvalue)/(SELECT sum(fvalue)  from insight_position_amount t  where t.vday=t1.vday and t.jys=t1.jys and t.cpbm=t1.cpbm )*100,2) as nums
 from insight_position_amount t1 GROUP BY vday,cid,khxm,jys,jysmc,jysinfo,cpbm,cpmc)zjzhdy
WHERE zjzhdy.nums>30