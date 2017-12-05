/**
������
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
			'�ʽ����' AS fxlb,
			--�������
			'������' AS fxzb,
			--����ָ��
			zjzhdy.fvalue AS fxzbz,
			--����ָ��ֵ
		CASE WHEN zjzhdy.fvalue<=1000000 
then 50 WHEN zjzhdy.fvalue >1000000 and zjzhdy.fvalue<=2000000
then 100 ELSE 200 end 
			 AS yuzhi,
			--��ֵ
	CASE WHEN zjzhdy.fvalue<=1000000 
then round((zjzhdy.fvalue::numeric-500000) /500000 * 100,2)
 WHEN zjzhdy.fvalue >1000000 and zjzhdy.fvalue<=2000000
then 
 round((zjzhdy.fvalue::numeric-1000000) /1000000 * 100,2)
ELSE 
 round((zjzhdy.fvalue::numeric-2000000) /2000000 * 100,2)
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
			'ZJXX' AS ywcdbm,
			--ҵ��˵�����
			'�ʽ���Ϣ' AS ywcdmc,
			--ҵ��˵�����
			'������' AS ywlx,
			--ҵ������
			'' AS ywbm,
			--ҵ�����
			--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
			'' AS fxsj_id,
			--
			'��' AS unit
		FROM
			 insight_in_out_amount zjzhdy 
WHERE zjzhdy.fvalue>500000