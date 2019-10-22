#include <string.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "kann_data.h"

#define MAX_LINE_SIZE 16384


kann_data_t *kann_data_read(const char *fn)
{
	kann_data_t *d;
	int m_row = 0, dret, m_grp = 0, grp_size = 0;
	char line[MAX_LINE_SIZE];

	FILE *fp;
	fp = fn && strcmp(fn, "-")? fopen(fn, "r") : fileno(stdin);
	if (fp == NULL) {
		printf("[ERROR] Cannot read %s\n", fn);
		exit(1);
	}

	d = (kann_data_t*)calloc(1, sizeof(kann_data_t));

	while (fgets(line, MAX_LINE_SIZE, fp)) {
		int st, k;
		size_t i;

		size_t len = strlen(line);
		if (len > 0 && line[len-1] == '\n')
			line[--len] = '\0';

		if (line[0] == '#') {
			for (i = 0, k = 0; i < len; ++i)
				if (line[i] == '\t') ++k;
			if (k > 0) {
				d->n_col = k;
				d->cname = (char**)malloc(d->n_col * sizeof(char*));
				for (i = 0, k = st = 0; i <= len; ++i) {
					if (i == len || line[i] == '\t') {
						if (k > 0) line[i] = 0, d->cname[k-1] = strdup(&line[st]);
						++k, st = i + 1;
					}
				}
			}
			continue;
		}
		if (line[0] == 0) {
			if (d->n_grp == m_grp) {
				m_grp = m_grp? m_grp<<1 : 8;
				d->grp = (int*)realloc(d->grp, m_grp * sizeof(int));
			}
			d->grp[d->n_grp++] = grp_size;
			grp_size = 0;
			continue;
		}
		for (i = 0, k = 0; i < len; ++i)
			if (line[i] == '\t') ++k;
		if (d->n_col == 0) d->n_col = k;
		if (k != d->n_col) continue; // TODO: throw a warning/error
		if (d->n_row == m_row) {
			m_row = m_row? m_row<<1 : 8;
			d->x = (float**)realloc(d->x, m_row * sizeof(float*));
			d->rname = (char**)realloc(d->rname, m_row * sizeof(char*));
		}
		d->x[d->n_row] = (float*)malloc(d->n_col * sizeof(float));
		for (i = 0, k = st = 0; i <= len; ++i) {
			if (i == len || line[i] == '\t') {
				char *p;
				if (k == 0) {
					line[i] = 0;
					d->rname[d->n_row] = strdup(&line[st]);
				} else d->x[d->n_row][k-1] = strtod(&line[st], &p);
				++k, st = i + 1;
			}
		}
		++d->n_row, ++grp_size;
	}
	if (d->n_grp == m_grp) {
		m_grp = m_grp? m_grp<<1 : 8;
		d->grp = (int*)realloc(d->grp, m_grp * sizeof(int));
	}
	d->grp[d->n_grp++] = grp_size;

	d->x = (float**)realloc(d->x, d->n_row * sizeof(float*));
	d->rname = (char**)realloc(d->rname, d->n_row * sizeof(char*));
	d->grp = (int*)realloc(d->grp, d->n_grp * sizeof(int));

	fclose(fp);

	return d;

}

void kann_data_free(kann_data_t *d)
{
	int i;
	if (d == 0) return;
	for (i = 0; i < d->n_row; ++i) {
		if (d->rname) free(d->rname[i]);
		free(d->x[i]);
	}
	if (d->cname) for (i = 0; i < d->n_col; ++i) free(d->cname[i]);
	free(d->x); free(d->cname); free(d->rname); free(d->grp); free(d);
}
