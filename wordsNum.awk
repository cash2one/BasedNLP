#ͳ���ļ���Ҫ��utf8��ʽ

#ͳ�ƴʡ��ֵĸ���
#���д���
#awk '{print $0} {print "The numbers of words:" NF } {print "The numbers of characters:" length-(NF-1)}' testexample.txt

#���д���ĩβ�ո�ȥ��
awk 'BEGIN {words=0;chars=0;} {sub(" *$","")}{words=words+NF;chars=chars+length-(NF-1);print $0;}\
 END {print "The numbers of words:" words } END {print "The numbers of characters:" chars} ' testexample.txt

#ȡ��ĳЩ�ض����ֶ�
#������ �ض��ֶ�ʲô��˼������
