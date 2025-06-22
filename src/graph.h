#ifndef GRAPH_H
#define GRAPH_H
#include <math.h>

#ifndef M_PI
#define M_PI 3.14159265358979323846
#endif

#define WIDTH 80
#define HEIGHT 25
#define START_X 0
#define END_X 4 * M_PI
#define START_Y -1
#define END_Y 1
#define STEP_X (4 * M_PI) / (WIDTH - 1)
#endif
