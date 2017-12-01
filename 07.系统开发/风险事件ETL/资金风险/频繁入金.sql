/**
Ƶ�����
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
			'Ƶ�����' AS fxzb,
			--����ָ��
			zjzhdy.nums AS fxzbz,
			--����ָ��ֵ
		CASE WHEN zjzhdy.nums<=5   
then 3 WHEN zjzhdy.nums >5 and zjzhdy.nums<=8
then 5 ELSE 8 end 
			 AS yuzhi,
			--��ֵ
	CASE WHEN zjzhdy.nums<=5 
then round((zjzhdy.nums::numeric-3) /3 * 100,2)
 WHEN zjzhdy.nums >5 and zjzhdy.nums<=8
then 
 round((zjzhdy.nums::numeric-5) /5 * 100,2)
ELSE 
 round((zjzhdy.nums::numeric-8) /8 * 100,2)
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
			'�ͻ���Ϣ' AS ywcdmc,
			--ҵ��˵�����
			'�ͻ���' AS ywlx,
			--ҵ������
			'' AS ywbm,
			--ҵ�����
			--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
			'' AS fxsj_id,
			--
			'��' AS unit
		FROM (SELECT cid,fvalue3 as nums ,jys,jysmc,khxm FROM insight_in_out_amount ) zjzhdy
WHERE zjzhdy.nums>3