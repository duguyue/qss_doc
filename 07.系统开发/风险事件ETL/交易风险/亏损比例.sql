/**
�������
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
			'�������' AS fxzb,
			--����ָ��
			zjzhdy.nums AS fxzbz,
			--����ָ��ֵ
		CASE WHEN 0-zjzhdy.nums<=40  
then 20 WHEN 0-zjzhdy.nums >40 and 0-zjzhdy.nums<=60
then 40 ELSE 60 end 
			 AS yuzhi,
			--��ֵ
	CASE WHEN 0-zjzhdy.nums<=40
then round((0-zjzhdy.nums::numeric-20) /20 * 100,2)
 WHEN 0-zjzhdy.nums >40 and 0-zjzhdy.nums<=60
then 
 round((0-zjzhdy.nums::numeric-40) /40 * 100,2)
ELSE 
 round((zjzhdy.nums::numeric-60) /60 * 100,2)
 end 
			 AS cce,
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
			'�ͻ���' AS ywlx,
			--ҵ������
			'' AS ywbm,
			--ҵ�����
			--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
     			 '' AS fxsj_id,
			--
			'%' AS unit
		FROM(
SELECT x.cid,x.vday,COALESCE(y.fvalue/x.jrj,0) as nums,x.khxm,x.jys,x.jysmc from
--���𣨾����
(SELECT cid,vday,(SELECT sum(fvalue2) from insight_in_out_amount a2 WHERE  a2.vday<=a1.vday and a1.cid=a2.cid) as jrj,a1.khxm,a1.jys,a1.jysmc FROM insight_in_out_amount a1 GROUP BY a1.cid,a1.vday,a1.khxm,a1.jys,a1.jysmc
)x
LEFT JOIN
--���տͻ�ӯ��
(SELECT cid,vday,fvalue,khxm,jys,jysmc from insight_profit_loss_amount WHERE fvalue>0 )y
on x.cid=y.cid and x.vday=y.vday
 ) zjzhdy
where  0-zjzhdy.nums>20