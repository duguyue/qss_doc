/**��������**/
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
			'�ͻ�����' AS fxlb,
			--�������
			'��������' AS fxzb,
			--����ָ��
			khxx.age AS fxzbz,
		--����ָ��ֵ
		CASE
WHEN khxx.age< 18 THEN 	'18'
WHEN khxx.age > 65 THEN 	'65'
WHEN khxx.age > 60 AND khxx.age<=65 THEN 	'60' 
END AS yuzhi,
		--��ֵ
		 CASE
WHEN khxx.age < 18 THEN
	round((18::numeric - khxx.age) / 18 * 100, 2)
WHEN khxx.age > 65 THEN
	round((khxx.age::numeric - 65) / 65 * 100, 2)
WHEN khxx.age > 60 AND khxx.age<=65 THEN
	round((khxx.age::numeric - 60) / 60 * 100, 2)
END AS cce,
		--������
		zjzhdy.jys AS jgdm,
		--��������
		p3.jysmc AS jgmc,
		--��������
		khxx.cid AS cust_id,
		--�ͻ���
		khxx.khxm AS khmc,
		--�ͻ�����
		'KHXX' AS ywcdbm,
		--ҵ��˵�����
		'�ͻ���Ϣ' AS ywcdmc,
		--ҵ��˵�����
		'���֤��' AS ywlx,
		--ҵ������
		'' AS ywbm,
		--ҵ�����
		--(SELECT auto_gen_fxsj_id ('DZ')) AS fxsj_id,
		'' AS fxsj_id,
		--
		'��' AS unit
	FROM
		hub_tqs_khxx khxx
	INNER JOIN hub_tqs_zjzhdy zjzhdy ON zjzhdy.cid = khxx.cid
  LEFT JOIN hub_dd_tqs_jysxx p3 ON zjzhdy.jys = p3.jys
	WHERE
		TRIM (zjzhdy.qyzt) = '0'
	AND TRIM (khxx.zjlb) = '0'
  AND khxx.age < 18
  OR khxx.age > 60