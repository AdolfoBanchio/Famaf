#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include "array_helpers.h"

int min_temp(WeatherTable arr){
    int min = arr[0][0][0]._min_temp;
    for(unsigned int a = 0; a < YEARS; a++){
        for (unsigned int m = 0; m < MONTHS; m++){
            for (unsigned int d = 0; d < DAYS; d++){
               if (min > arr[a][m][d]._min_temp){
                  min = arr[a][m][d]._min_temp;
               }
               
            }
            
        }
        
    }
    return min;
}

void procedimiento(WeatherTable arr, int output[YEARS]){
    
    for(unsigned int a = 0; a < YEARS; a++){
        int temp_max = arr[a][0][0]._max_temp;
        for (unsigned int m = 0; m < MONTHS; m++){
            for (unsigned int d = 0; d < DAYS; d++){
               if (temp_max < arr[a][m][d]._max_temp){
                  temp_max = arr[a][m][d]._max_temp;
               }
               
            }
        }
    output[a] = temp_max;
    }
}

void mes_mas_lluvia(WeatherTable arr, month_t output[YEARS]){
    unsigned int prec_max,prec_m;
    month_t mes_max;
    for(unsigned int a = 0; a < YEARS; a++){
        mes_max = january;
        prec_max = 0;
        for (month_t m = january; m <= december; m++){
            prec_m = 0;
            for (unsigned int d = 0; d < DAYS; d++){
                prec_m = prec_m + arr[a][m][d]._rainfall;
            }
            if (prec_max < prec_m) {
                mes_max = m;
                prec_max = prec_m;
            }
        }
    output[a] = mes_max;
    }
}
