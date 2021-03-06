#ifndef PARAMETER_H
#define PARAMETER_H

#include <QString>

struct Parameter
{
    static QString work;
    static QString open;
    static QString exe;

    static QString vcf;
    static QString pheno;
    static QString covar;
    static QString block;
    static QString gene;
    static QString grm;

    static int txtsize;
    static int logsize;

    static int openmp;

    static bool delete_onexit;
};

#endif // PARAMETER_H
