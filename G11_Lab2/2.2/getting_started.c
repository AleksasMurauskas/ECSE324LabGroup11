
extern int MAX_2(int x, int y);

int main() {
	
	// Array
	int a[5] = {1, 20, 3, 4, 5};

	// Max value
	int max_val = a[0];

	// Array size
	int arr_size = 5;
	
	// Index var
	int i;
	
	// Iterate over the array
	for (i = 0; i < arr_size; i++) {

		// Get current and compare to max
		int cur = a[i];
		max_val = MAX_2(max_val, cur);
	}
	
	return max_val;	
}
