/**
���ӯ��
**/
INSERT INTO hub_fxsj  (
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
			'���ӯ��' AS fxzb,
			--����ָ��
			zjzhdy.nums AS fxzbz,
			--����ָ��ֵ
		CASE WHEN zjzhdy.nums<=500000   
then 20 WHEN zjzhdy.nums >500000 and zjzhdy.nums<=1000000
then 50 ELSE 100 end 
			 AS yuzhi,
			--��ֵ
	CASE WHEN zjzhdy.nums<=500000
then round((zjzhdy.nums::numeric-200000) /200000 * 100,2)
 WHEN zjzhdy.nums >500000 and zjzhdy.nums<=1000000
then 
 round((zjzhdy.nums::numeric-500000) /500000 * 100,2)
ELSE 
 round((zjzhdy.nums::numeric-1000000) /1000000 * 100,2)
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
			'KHXX' AS ywcdbm,
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
		FROM(SELECT cid,sum(fvalue) as nums,jys,jysmc,khxm FROM insight_profit_loss_amount GROUP BY cid,vday,jys,jysmc,khxm ) zjzhdy
where  zjzhdy.nums>200000