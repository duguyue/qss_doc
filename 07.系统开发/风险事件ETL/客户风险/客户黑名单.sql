/**
�ͻ�������ָ�꣺�ͻ����������е����֤����ACCOUNT.TQS_KHXX�е�ZJBHƥ��+�ͻ�id����
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
			'�ͻ�����' AS fxlb,
			--�������
			'�ͻ�������' AS fxzb,
			--����ָ��
			'' AS fxzbz,
			--����ָ��ֵ
			'' AS yuzhi,
			--��ֵ
			'' AS cce,
			--������
			zjzhdy.jgdm AS jgdm,
			--��������
			zjzhdy.jgmc AS jgmc,
			--��������
			zjzhdy.cust_id AS cust_id,
			--�ͻ���
			zjzhdy.cust_name AS khmc,
			--�ͻ�����
			'KHHMD' AS ywcdbm,
			--ҵ��˵�����
			'�ͻ�������' AS ywcdmc,
			--ҵ��˵�����
			'���֤��' AS ywlx,
			--ҵ������
			'' AS ywbm,
			--ҵ�����
			--(SELECT auto_gen_fxsj_id ('DZ')) AS fxsj_id,
      '' AS fxsj_id,
			--
			'' AS unit
		FROM  hub_blacklist zjzhdy 