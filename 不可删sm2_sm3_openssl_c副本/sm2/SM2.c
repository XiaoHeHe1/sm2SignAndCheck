/*
  email: co63 at 163.com
  date: 2012-09-26
*/

#include "sm2.h"
#include "part1.h"
#include "part2.h"
#include "part3.h"
#include "part4.h"

/*
  ��Ϊ������֤������ǩ������Կ�������ӽ���

  ���� SM2��Բ���߹�Կ�����㷨 �ĵ�������ʾ�����㣬
  ֻ��f2m_257 ��Կ���� �����û��Ӵ�ֵZʱ��һ��

  ecp->point_byte_length��ʾ��ͬ����ʹ�õĶ�����λ��

  DEFINE_SHOW_BIGNUM, 16������ʾ��������ֵ
  DEFINE_SHOW_STRING��16������ʾ�������ַ���
*/
int mainSM2(int argc, char* argv[])
{
	{
		//������֤
		printf("********************part1********************\n");
		test_part1(sm2_param_fp_192, TYPE_GFp, 192);
		test_part1(sm2_param_fp_256, TYPE_GFp, 256);
		test_part1(sm2_param_f2m_193, TYPE_GF2m, 193);
		test_part1(sm2_param_f2m_257, TYPE_GF2m, 257);

		//����ǩ��
		printf("********************part2********************\n");
		test_part2(sm2_param_fp_256, TYPE_GFp, 256);
		test_part2(sm2_param_f2m_257, TYPE_GF2m, 257);

		//��Կ����
		printf("********************part3********************\n");
		test_part3(sm2_param_fp_256, TYPE_GFp, 256);
		//a = 0ʱ���û�hash Z���㲻һ��, ��������Կ��ͬ
		test_part3(sm2_param_f2m_257, TYPE_GF2m, 257);
	
		//�ӽ���
		//192, 193λ��ʹ�õ�d, k���ضϴ���
		printf("********************part4********************\n");
		test_part4(sm2_param_fp_192, TYPE_GFp, 192);
		test_part4(sm2_param_fp_256, TYPE_GFp, 256);
		test_part4(sm2_param_f2m_193, TYPE_GF2m, 193);
		test_part4(sm2_param_f2m_257, TYPE_GF2m, 257);
	}

	//�Ƽ�����
	//test_part1(sm2_param_recommand, TYPE_GFp, 256);
	//test_part2(sm2_param_recommand, TYPE_GFp, 256);
	//test_part3(sm2_param_recommand, TYPE_GFp, 256);
	//test_part4(sm2_param_recommand, TYPE_GFp, 256);

//    system("pause");
	return 0;
}

