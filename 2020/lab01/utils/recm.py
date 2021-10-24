#!/usr/bin/python3
# -*- coding: utf-8 -*-
"""
lab2: 基于用户的协同过滤算法
      阅读雨课堂课件“基于用户的协同过滤算法”。 求p(A, e), p(B, b)。
lab3: 基于用户的协同过滤算法代码实现
      阅读雨课堂课件“基于用户的协同过滤算法”。完成代码编写和测试。
"""

import sys
import json
import getopt


def dump2json(obj, indent=4):
    return json.dumps(obj, indent=indent)


def print2(s=""):
    print(s, file=sys.stderr)


def get_merchandise_score(data_lines, user, merchandise_index):
    for line in data_lines:
        if line[0] == user:
            l_line = list()
            for element in line.split(' '):
                if (element == user) or (not element):
                    continue
                l_line.append(element)
            return int(l_line[merchandise_index])
    return 0


def get_users(data_lines):
    users = list()
    for line in data_lines[1:]:
        users.append(line[0])
    return users


def get_merchandises(data_lines):
    merchandises = list()
    for merchandise in data_lines[0].split(' '):
        if (merchandise == 'U\M') or (not merchandise):
            continue
        merchandises.append(merchandise)
    return merchandises


def pre_init_data_matrix(matrix_file):
    data_lines = list()
    with open(matrix_file, 'r') as file_handle:
        for line in file_handle.readlines():
            line = line.strip().rstrip()
            if line.startswith('#'):
                continue
            data_lines.append(line.replace('\t', ' '))
    return data_lines


def init_data_matrix(data_lines, users, merchandises):
    data_matrix = dict()
    for user in users:
        data_matrix[user] = dict()
        for merchandise in merchandises:
            mindex = merchandises.index(merchandise)
            mscore = get_merchandise_score(data_lines, user, mindex)
            data_matrix[user][merchandise] = mscore
    return data_matrix


def get_merchandise_user_table(data_matrix, merchandises, users):
    tbl = dict()
    for merchandise in merchandises:
        tbl[merchandise] = list()
        for user in users:
            if data_matrix[user][merchandise] != 0:
                tbl[merchandise].append(user)
    return tbl


def get_user_intersection_table(merchandise_user_table, users, merchandises):
    tbl = dict()
    for user_lf in users:
        tbl[user_lf] = dict()
        for user_rt in users:
            tbl[user_lf][user_rt] = 0

    for user_lf in users:
        for user_rt in users:
            if user_lf == user_rt:
                continue
            for merchandise in merchandises:
                wusers = merchandise_user_table[merchandise]
                if (user_lf in wusers) and (user_rt in wusers):
                    tbl[user_lf][user_rt] += 1

    return tbl


def get_merchandises_num_byuser(data_matrix, merchandises, user):
    merchandises_num = 0
    user_merchandises = data_matrix[user]
    for merchandise in user_merchandises:
        if user_merchandises[merchandise] != 0:
            merchandises_num += 1
    return merchandises_num


#
# Get user similarity via cosine law
#
#                   |N(u)  n  N(v)|
#     W(u, v)  = ---------------------
#                  ................
#                \/ |N(u)| x |N(v)|
#
#     where N(u)        is the total number of merchandises bought by user u
#           N(v)        is the total number of merchandises bought by user v
#           N(u) n N(v) is the total number of merchandises bought by both
#                          user u and user v
#
def get_user_similarity_table(data_matrix, ui_table, users, merchandises):
    us_tbl = dict()
    for user_lf in users:
        us_tbl[user_lf] = dict()
        for user_rt in users:
            us_tbl[user_lf][user_rt] = 0.0

    for user_lf in users:
        nu = get_merchandises_num_byuser(data_matrix, merchandises, user_lf)
        for user_rt in users:
            if user_lf == user_rt:
                continue
            nv = get_merchandises_num_byuser(data_matrix,
                                             merchandises, user_rt)
            nuv = ui_table[user_lf][user_rt]
            wuv = abs(nuv) / ((abs(nu) * abs(nv)) ** 0.5)
            us_tbl[user_lf][user_rt] = wuv

    return us_tbl


def get_row_from_us_tbl(us_tbl, users, user):
    l_row = list()
    d_row = us_tbl[user]
    for u in users:
        l_row.append(d_row[u])
    return l_row


def get_col_from_data_matrix(data_matrix, users, merchandise):
    l_col = list()
    for user in users:
        l_col.append(data_matrix[user][merchandise])
    return l_col


def get_recm_score(data_matrix, us_tbl, users, user, merchandise):
    row = get_row_from_us_tbl(us_tbl, users, user)
    col = get_col_from_data_matrix(data_matrix, users, merchandise)
    score = 0.0
    for i in range(len(row)):
        score += row[i] * col[i]
    return score


def usage(argv0):
    print2("Usage: %s [-v] [-e] [-u user] [-m merchandise]"
           " <user-merchandise matrix>" % argv0)
    print2("e.g.")
    print2("       %s ../data/matrix.txt" % argv0)
    print2("       %s -v ../data/matrix.txt" % argv0)
    print2("       %s -v -e ../data/matrix.txt" % argv0)
    print2("       %s -u A -m c ../data/matrix.txt" % argv0)
    print2("       %s -u A -m e ../data/matrix.txt" % argv0)
    print2("       %s -u B -m b ../data/matrix.txt" % argv0)


def main(argc, argv):
    i_user = None
    i_merchandise = None
    verbose = False
    lang = 'cn'
    options, rargv = getopt.getopt(argv[1:],
                                   ":u:m:evh",
                                   ["user=", "merchandise=",
                                    "english", "verbose", "help"])
    for opt, arg in options:
        if opt in ("-v", "--verbose"):
            verbose = True
        elif opt in ("-u", "--user"):
            i_user = arg
        elif opt in ("-m", "--merchandise"):
            i_merchandise = arg
        elif opt in ("-e", "--english"):
            lang = 'en'
        elif opt in ("-h", "--help"):
            usage(argv[0])
            return 1
        else:
            usage(argv[0])
            return 1

    rargc = len(rargv)
    if rargc != 1:
        usage(argv[0])
        return 1
    um_matrix_file = rargv[0]

    d_tables = {
        'um': {
            'cn': '用户商品打分表',
            'en': 'user-merchandise score table'
        },
        'mu': {
            'cn': '商品用户倒排表',
            'en': 'merchandise-user inverted table'
        },
        'ui': {
            'cn': '用户交集表',
            'en': 'user intersection table'
        },
        'us': {
            'cn': '用户相似度表',
            'en': 'user similarity table'
        }
    }

    data_lines = pre_init_data_matrix(um_matrix_file)
    users = get_users(data_lines)
    merchandises = get_merchandises(data_lines)
    data_matrix = init_data_matrix(data_lines, users, merchandises)
    if verbose:
        print("====== 0 - %s ======" % d_tables['um'][lang])
        print(dump2json(data_matrix))

    mu_tbl = get_merchandise_user_table(data_matrix, merchandises, users)
    if verbose:
        print("====== 1 - %s ======" % d_tables['mu'][lang])
        print(dump2json(mu_tbl))

    ui_tbl = get_user_intersection_table(mu_tbl, users, merchandises)
    if verbose:
        print("====== 2 - %s ======" % d_tables['ui'][lang])
        print(dump2json(ui_tbl))

    us_tbl = get_user_similarity_table(data_matrix, ui_tbl, users,
                                       merchandises)
    if verbose:
        print("====== 3 - %s ======" % d_tables['us'][lang])
        print(dump2json(us_tbl))

    i_users = users
    if i_user is not None:
        i_users = list([i_user])
    i_merchandises = merchandises
    if i_merchandise is not None:
        i_merchandises = list([i_merchandise])
    for user in i_users:
        for merchandise in i_merchandises:
            score = get_recm_score(data_matrix, us_tbl, users, user,
                                   merchandise)
            print("p(%s, %s) = %.3f" % (user, merchandise, score))

    return 0

if __name__ == '__main__':
    sys.exit(main(len(sys.argv), sys.argv))
