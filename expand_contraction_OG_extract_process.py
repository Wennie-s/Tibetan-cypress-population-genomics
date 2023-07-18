# coding:utf-8
import linecache


def getOGofCg(famsFile, ogsFile, outputFile, flag):
    # linecache 从1开始，此处读取第6行
    Cg_line = linecache.getline(famsFile, 6)
    # 获得第一个O的位置，去除之前数据
    firstIndexOfO = Cg_line.find('O')
    Cg_OGs_line = Cg_line[firstIndexOfO:]
    Cg_OGs_list = Cg_OGs_line.split(',')

    # 新建列表，用以存放包含flag的OG
    Cg_OGs_withFlag = list()
    for og in Cg_OGs_list:
        if (not -1 == og.find(flag)):
            # 如果flag在og中位置不为-1，即存在该flag，则将[之前str保存
            Cg_OGs_withFlag.append(og.split('[')[0])

    outF = open(outputFile, 'a') # 追加模式打开文件
    for og in Cg_OGs_withFlag:
        # 注意打开ogsFile须在循环内部，否则下一次是从当前行继续往下读
        ogsF = open(ogsFile)
        line  = ogsF.readline()
        while line:
            if (line.startswith(og)):
                # 如果该行以该og开头，则获得第一个空格位置，去除包括它的之前数据
                firstIndexOfSpace = line.find(' ')
                genes = line[firstIndexOfSpace+1:]
                genes_list = genes.split(' ')

                # 如果该基因以Cg开头，则写入输出文件
                for gene in genes_list:
                    if gene.startswith('Cg'):
                        outF.write(og + "\t" + gene +"\n")

            line = ogsF.readline()
        ogsF.close()

    outF.close()
    print("process OG with " + flag + " done")


# 当.py文件被直接运行时，之下的代码块将被运行；
# 当.py文件被以模块形式导入时，之下的代码块不被运行。
if __name__ == '__main__':
    fams = './final_result/rapid_evolved/summary_fams.txt'
    ogs = './final_result/rapid_evolved/Orthogroups.txt'
    getOGofCg(fams, ogs, './final_result/rapid_evolved/OGs_rapid_expansion.txt', '+')
    getOGofCg(fams, ogs, './final_result/rapid_evolved/OGs_rapid_expansion.txt', '-')
    print('All Done.')
