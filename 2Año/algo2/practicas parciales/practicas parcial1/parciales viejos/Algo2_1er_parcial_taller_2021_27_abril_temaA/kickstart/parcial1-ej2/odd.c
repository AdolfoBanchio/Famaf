#include <stdbool.h>

#include "odd.h"

bool is_odd_sorted(int array[], unsigned int length) {
	if(length < 3)
	{
	return True
	}
	int i;
	bool res;
	i = 3
	res = true;
	while(res && i<length){
		if(a[i-2]<a[i]){
		 res = true;
		 i = i +2
		}else{
		res = false			
		}	
	}
}
