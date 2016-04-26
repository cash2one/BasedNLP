# �����

## һ. ���

������ʵ���˶�����������������ʵ�ֶ��������⡣

## ��. ��������

������Linuxϵͳ��g++4.8���ϣ�Eclipseƽ̨

### 1. ��Ҫ���ļ�

a. MaxEntropy�ļ�(������ȡ��Ҫ�Լ���)   https://github.com/jinyeqiong/MaxEntropy
b. LibN3L�ļ�  https://github.com/jinyeqiong/LibN3L
c. mshadow�ļ�   https://github.com/jinyeqiong/mshadow
d. OpenBLAS�ļ�   https://github.com/jinyeqiong/OpenBLAS

### 2. �����ļ�

a. ����openblas:
��ע��������C++ �����Ҫ��װC++���뻷������g++��

```bash
#��homeĿ¼��(make clean ���������һ��)
sudo apt-get install g++

# �л���openblas��Ŀ¼��
cd openblas    #�Զ���ʵ��·��Ϊ׼
make USE_THREAD=0 ????#single thread version, one can use multi-thread version as well.
make install????????????#default path /opt/OpenBLAS

# �л������������optĿ¼���һ���ļ���
cd /opt/OpenBLAS/include/
cp * /usr/include       #��/opt/OpenBLAS/include/����ļ�ȫ�����Ƶ�/usr/include��

# �л���/opt/OpenBLAS/lib/Ŀ¼��
cd /opt/OpenBLAS/lib/
cp *.* /usr/lib    #��/opt/OpenBLAS/lib/��Ĵ���׺�����ļ�ȫ�����Ƶ�/usr/lib��
```

b. ����mshadow

```bash
#�л���mshadowĿ¼��
cd mshadow     #�Զ���ʵ��·��Ϊ׼
cp -r mshadow /opt    ##��mshadow����ļ����ݹ��ļ����Ƶ�opt��
```

### 3. ���г���

a. ���ļ�����Eclipse

```File -> Import -> C/C++ -> Existing Code as Makefile Project -> Linux GCC```������ļ�����·�����ɡ�

b. ���LibN3L��mshadow·��

```
��Ŀ�Ҽ� -> Properties -> C/C++ General -> Paths and Symbols -> GNU C++
Add -> ../LibN3L
Add -> /opt/mshadow
```

c. ������Ŀ

```��Ŀ�Ҽ� -> Clean Project -> Build Project```

d. �����в���

```bash
# �л���MaxEntropyĿ¼��
cd MaxEntropy     #�Զ���ʵ��·��Ϊ׼

./cleanall.sh ���������ļ���ȥ����ԭ�ļ��ж�������ļ��������û��ִ��Ȩ�ޣ����Ȩ�����ã���Ҫʱȥ��sudo���ԡ�
cmake .
make

# ��ѵ�����ϣ��������ϣ��������Ϸ���һ���ļ���xx�У�������MaxEntSentiment�ļ�����
# �л����ļ���xx��
cd xx    #���߿�����������
#��������أ��������xx1.log��
../MaxEntLabeler -l -train train.txt -dev dev.txt -test test.txt -option option.sparse >xx1.log 2>&1 &
```

## ��. ����ԭ��

ͨ��y'=wx�������ݶ��½������ϸ���w���Ӷ��õ�����ʵı�ǩy�������б�������͡�

### 1. �����������

**������ʽ**��[��ǩ ���ӣ��ִʺ�] 
eg. 1 �� ϲ�� ����

**��������x**���������еĴ�תΪ�������������������г��֣������±�
eg. <1 3> ("��"��"����"���������г��֣���"ϲ��"δ��������������)

**�����ʽ**��<��ǩ����>
eg. <1 0> (�������������Ϊ������)

### 2. ����ؼ������

x��������������������������ǵ��Ǵʵ��±ꣻ������n����������xΪ1��nά����
y���������������ǩ�����������𣻼�����������⣬��yΪ1*2ά����
w���м���������ʼֵ�����������n��2ά����

### 3. ����ؼ������

a. ǰ���㷨��``` y'=x*w ```��ͨ�����������w������õ�y'��y'����1*2ά����
b. softmax��``` ly=y-y' ```������y����ʧ
c. �����㷨��``` lw=ly*(y'(w)) ```������y'(w)��y��w�󵼣�����õ�w����ʧ
d. ����w��ͨ��lw����w
e. �������õ��µ�wֵ���ظ�a��ǰ���㷨���Դ����ƣ��ظ����

## ��. �������

������MaxEntLabeler.cpp

�����ļ���ѵ�����������������Լ����ļ��ĸ�ʽ���������������ֳ����������ʽ

#### A. ����ѵ�����������������Լ�����ʽ��ΪInstance  ��readInstances()��

Instance��ʽ��string vector<string> [��ǩ ������]

#### B. ������ĸ����ͨ��ѵ�����õ���ǩ��������� ��createAlphabet()��

������ѵ��������һ�飬����ǩ�������ֱ����m_labelAlphabet��m_featAlphabet�У����еĸ�ʽ��map��{string��int}����[��ǩ/�������±�����]

**ע��**��
 m_labelAlphabet�Ĵ�С�������ĸ�����
��extractLinearFeatures()���ǳ�ȡ��������ȡ������������ȫҪ�������������������˸�����һ����ֵfeatCutOff���Ž������洢��m_featAlphabet�С�

#### C. ��InstanceתΪExample��ʽ 

Example��ʽ��vector<int> vector<int>

��convert2Example()����InstanceתΪExample��ʽ����ǩ�����������������1������Ϊ0���������������ô����������е��±��������������

��initialExamples()�������о��Ӷ���InstanceתΪExample��ʽ

**ע**�����ˣ��Ѿ��õ�����Ҫ�����������������x���������y�ˡ�

#### D. ��������ش���

(1) ����ѵ��������

a. ��Example��ʽ��ѵ��������˳��
b. ��m_classifier.process()��
���ѡ��һ�仰������������ǰ���㷨���õ����output�����õ�1*2ά����
c. ������ʧ������ǰ���㷨�õ��Ľ��output����ȷ�ı�ǩ������õ��������ʧoutputLoss
d. ���к����㷨����������������output����ʧoutputLoss���õ�w����ʧ
e. ��m_classifier.updateParams()������w

(2) ���ڿ���������

�������Ĵ�����ѵ�������ƣ�����ֻ�ǽ���ǰ���㷨���õ����Ƶ��������output

(3) ���ڲ��Լ�����

�뿪��������

**�ܽ�**
ѵ����Ŀ�ģ���������w
������Ŀ�ģ�Ѱ�ҿ����������õ�����£���Ӧ�Ĳ��Լ��Ľ��
���Լ���������





























