# Student Name: Kadam, Ruchir Ravindra
# UTA ID: 1001227805
# Project No.: Home Work Assignment 4
# Due date: March 23, 2017

from itertools import chain, combinations
import sys


def prefix(a, b):
    p_a = a[0:len(a)-1]
    p_b = b[0:len(b) - 1]
    if p_a == p_b:
        return True
    else:
        return False


def rules(l, min_conf_value):
    for iset in l[len(l)-1]:
        if len(l) > 1:
            print('----------PATTERNS GENERATED----------')
            for i in chain.from_iterable(combinations(iset, r) for r in range(len(iset) + 1)):
                if i not in [(),iset]:
                    rem = [item for item in iset if item not in i]
                    rem = tuple(rem)
                    l_num1 = len(i) - 1
                    l_num2 = len(rem) - 1
                    if l_num1 == 0:
                        i = i[0]
                    if l_num2 == 0:
                        rem = rem[0]
                    conf = (l[len(l) - 1][iset]) / (l[l_num1][i])
                    if conf >= min_conf_value:
                        print(i,' => ',rem,': conf=',conf)
        else:
            print("Patterns cannot be generated with this minimum support value!")


def calculate_c(temp,itemlist,num):
    c = {}
    if num == 1:
        for item in itemlist:
            for t in item:
                if t in c.keys():
                    c[t] += 1
                else:
                    c[t] = 1
    elif num == 2:
        for i in range(0, len(temp)):
            for j in range(i + 1, len(temp)):
                key = (temp[i], temp[j])
                c[key] = 0
                for item in itemlist:
                    if subset(key, item):
                        c[key] += 1
    else:
        for i in range(0, len(temp)):
            for j in range(i+1,len(temp)):
                if prefix(temp[i],temp[j]):
                    key = make_key(temp[i],temp[j])
                    c[key] = 0
                    for item in itemlist:
                        if subset(key, item):
                            c[key] += 1
    return c


def make_key(a, b):
    c = sorted(set(a + b))
    return tuple(c)


def subset(a, b):
    if len(a) > len(b):
        return False
    else:
        for i in a:
            if i not in b:
                return False
        return True


def calculate_l(c, sup_count):
    l = {}
    for k in c.keys():
        if c[k] >= sup_count:
            l[k] = c[k]
    return l


def apriori(itemlist, min_sup_value, min_conf_value):
    sup_count = min_sup_value * len(itemlist)
    l = []
    temp = []
    for i in range(1, 99999):
        c = calculate_c(temp,itemlist,i)
        l1 = calculate_l(c,sup_count)
        if len(l1) == 0:
            break
        l.append(l1)
        temp = sorted(l1.keys())
    rules(l, min_conf_value)

if __name__ == '__main__':
    filename = sys.argv[1]
    min_sup_value = float(sys.argv[2])
    min_conf_value = float(sys.argv[3])
    file = open(filename, 'r')
    contents = file.read()
    file.close()
    item_array = contents.split("\n")
    itemlist = []
    for item in item_array:
        item = item.split()
        itemlist.append(item)
    apriori(itemlist,min_sup_value,min_conf_value)
