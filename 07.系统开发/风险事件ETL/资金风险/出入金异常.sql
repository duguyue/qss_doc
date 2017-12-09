/**
������쳣
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
			to_char((SELECT now() :: TIMESTAMP),'yyyyMMdd HH24:mm:ss') AS bjsj,
			--����ʱ��
			'�ʽ����' AS fxlb,
			--�������
			'������쳣' AS fxzb,
			--����ָ��
			zjzhdy.nums AS fxzbz,
			--����ָ��ֵ
		CASE WHEN zjzhdy.nums<=20   
then 10 WHEN zjzhdy.nums >20 and zjzhdy.nums<=30
then 20 ELSE 30 end 
			 AS yuzhi,
			--��ֵ
	CASE WHEN zjzhdy.nums<=20 
then round((zjzhdy.nums::numeric-10) /10 * 100,2)
 WHEN zjzhdy.nums >20 and zjzhdy.nums<=30
then 
 round((zjzhdy.nums::numeric-20) /20 * 100,2)
ELSE 
 round((zjzhdy.nums::numeric-30) /30 * 100,2)
 end 
			 AS cce,
			--������
			zjzhdy.jys AS jgdm,
			--��������
			p4.jysmc AS jgmc,
			--��������
			zjzhdy.cid AS cust_id,
			--�ͻ���
			khxx.khxm AS khmc,
			--�ͻ�����
			'ZJXX' AS ywcdbm,
			--ҵ��˵�����
			'�ʽ���Ϣ' AS ywcdmc,
			--ҵ��˵�����
			'�г�����' AS ywlx,
			--ҵ������
			'' AS ywbm,
			--ҵ�����
			--(SELECT auto_gen_fxsj_id ('DZ'))  AS fxsj_id,
			'' AS fxsj_id,
			--
			'��' AS unit
		FROM
			hub_tqs_khxx khxx
		INNER JOIN (SELECT cid,count(cid) as nums,jys FROM hub_tqs_zjjysq_ls where cljg='-111' GROUP BY cid,clrq,jys) zjzhdy on
		 zjzhdy.cid = khxx.cid
LEFT JOIN hub_dd_tqs_jysxx  p4 ON zjzhdy.jys = p4.jys
WHERE zjzhdy.nums>10