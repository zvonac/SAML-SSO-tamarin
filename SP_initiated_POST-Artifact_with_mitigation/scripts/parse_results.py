#!/usr/bin/python3

import re
import sys
import tempfile

import pandas as pd

pd.set_option('display.max_rows', 500)
pd.set_option('display.max_columns', 500)
pd.set_option('display.width', 1000)

RESULT_REGEX = re.compile("^\s*(\w+).*(falsified|verified|analysis incomplete)[^\(]+\((\d+) steps\)")
FILENAME_REGEX = re.compile("^analyzed: (.+\.spthy)")
SUMMARY_START = "=============================================================================="
VERIFIED = "verified"
FALSIFIED = "falsified"
SKIPPED = "analysis incomplete"
V1 = ["signed", "unsigned"]
V2 = ["relaystate", "norelaystate"]
V3 = ["strongid", "weakid"]
EXECUTABLES = "analyzed/SAML_{}_{}_{}_executables_summary.txt"
HELPERS = "analyzed/SAML_{}_{}_{}_helpers_summary.txt"
CLIENT_SP = "analyzed/SAML_{}_{}_{}_client_sp_summary.txt"
SP_IDP = "analyzed/SAML_{}_{}_{}_sp_idp_summary.txt"

def parse_summary(summary):
    results = []
    for line in summary.splitlines():
        match = FILENAME_REGEX
        match = RESULT_REGEX.match(line)
        if match:
            results.append(match.groups())
    return results

def parse_tamarin_output(filename):
    summary = ''
    start = False
    with open(filename, "rt") as handle:
        for line in handle:
            if not start and line.startswith(SUMMARY_START):
                start = True
            if start:
                summary += line
    return parse_summary(summary)

def parse_and_check(v1, v2, v3):
    fexec = EXECUTABLES.format(v1, v2, v3)
    exec_verified = 0
    exec_results = parse_tamarin_output(fexec)
    for result in exec_results:
        k, v, steps = result
        if k.startswith("ex"):
            assert v == VERIFIED
            exec_verified += 1
    fhelpers = HELPERS.format(v1, v2, v3)
    helpers_verified = 0
    helpers_results = parse_tamarin_output(fhelpers)
    for result in helpers_results:
        k, v, steps = result
        if k.startswith("helper") or k.startswith("https_typing"):
            assert v == VERIFIED
            helpers_verified += 1
    fclient = CLIENT_SP.format(v1, v2, v3)
    client_verified = 0
    client_falsified = 0
    client_results = parse_tamarin_output(fclient)
    results = []
    for result in client_results:
        k, v, steps = result
        if k.startswith("sec_Client") or k.startswith("sec_SP_Client"):
            assert v in [VERIFIED, FALSIFIED]
            if v == VERIFIED:
                client_verified += 1
            else:
                client_falsified += 1
            results.append((k, v, steps))
    fspidp = SP_IDP.format(v1, v2, v3)
    spidp_verified = 0
    spidp_falsified = 0
    spidp_results = parse_tamarin_output(fspidp)
    for result in spidp_results:
        k, v, steps = result
        if k.startswith("sec_SP_IdP") or k.startswith("sec_IdP"):
            assert v in [VERIFIED, FALSIFIED]
            if v == VERIFIED:
                spidp_verified += 1
            else:
                spidp_falsified += 1
            results.append((k, v, steps))
    print("Variant {} {} {}: {} executables verified, {} helpers verified".format(v1, v2, v3, exec_verified, helpers_verified))    
    return results

def parse_and_check_all():
    results = []
    summary = {}
    columns = ['Lemma']
    col_index = {}
    row_index = {}
    for v1 in V1:
        for v2 in V2:
            for v3 in V3:
                key = v1[0]+v2[0]+v3[0]
                col_index[key] = len(columns)
                columns.append(key)
                res = parse_and_check(v1, v2, v3)
                for k, v, s in res:
                    results.append((v1, v2, v3, k, v, s))
                    if not k in row_index:
                        l = len(row_index)
                        row_index[k] = l
                        summary[row_index[k]] = [k] + ['-']*8
                    if v == VERIFIED:
                        summary[row_index[k]][col_index[key]] = 'o'
                    else:
                        summary[row_index[k]][col_index[key]] = 'X'
    return results, summary, columns

def print_latex(rows, header):
    print(' & '.join(header) + ' \\\\')
    for _, row in rows:
        new_row = []
        for item in row:
            if item == 'o':
                new_row.append('\\yes')
            elif item == 'X':
                new_row.append('\\no')
            else:
                new_row.append(item.replace('_', '\\_'))
        print(' & '.join(new_row) + ' \\\\')

if __name__ == "__main__":
    results, summary, columns = parse_and_check_all()
    if 'latex' in sys.argv:
        print_latex(sorted(summary.items()), columns)
    else:   
        df = pd.DataFrame([y for (_, y) in sorted(summary.items())], columns=columns)
        print(df)
