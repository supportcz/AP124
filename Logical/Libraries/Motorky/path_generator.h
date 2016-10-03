/********************************************************************
 * COPYRIGHT --  
 ********************************************************************
 * Library: Motorky
 * File: path_generator.h
 * Author: vancurar
 * Created: June 29, 2008
 *******************************************************************/

#include <bur/plctypes.h>

void PathGenerator(Motorky_PathGenerator *pPathGenerator);

void PathGeneratorInitialize(Motorky_PathGenerator *pPathGenerator, REAL taskTime);

void PathGeneratorResetError(Motorky_PathGenerator *pPathGenerator);

void PathGeneratorSetPosition(Motorky_PathGenerator *pPathGenerator, DINT position);

#define ABS(c)		(((c) >= 0) ? (c) : -(c))
