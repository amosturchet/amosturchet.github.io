#!/usr/bin/python 
# -*- coding: utf-8 -*-


def getdata(file,n):
    l = list()
    j=0
    for line in file:
        if j == n:
            l.append(line)
            break
        j = j+1
    if j != n:
        raise ValueError("Can't get the value insered")
    out = l[0].split('|')
    for i in range(len(out)-2):
        out[i]=out[i+1]
    out[0] = out[0]+'.'
    out[1] = out[1]+'.'
    if out[2] != 'none':
        out[2] = out[2] +', '
    if out[3] != 'none':
        out[3] = out[3] + '.'
    out[4] = out[4] +','
    out[6] = out[6] +'.'
    return out
    
    
    
        

def main():
    inp = open('tex.txt','r')
    tex = list(inp)
    inp.close()
    n = int(raw_input('Which line should i read?'))
    dat = open('data.txt','r')
    data = getdata(dat,n)
    print data
    dat.close()
    indeces = list()
    for i in range(len(tex)):
        if 'nnnnn' in tex[i]:
            indeces.append(i)
    j=0
    none = 0
    print indeces
    for i in range(len(tex)):
        if i in indeces:
            if data[j]=='none':
                if none == 0:
                    tex[i-1] = tex[i-1][:len(tex[i-1])-2]
                    tex[i]=' '
                    none = none + 1
                else:
                    tex[i-1] = tex[i-1][:len(tex[i-1])-9]
                    tex[i]='.'
            else: tex[i] = data[j]
            j = j+1
    name = data[len(data)-2]
    file = open(name+'.txt','w')
    for line in tex:
        file.write(line)
    file.close()

if __name__ == '__main__':
    main()