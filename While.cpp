#include <iostream>
#include <algorithm>

using namespace std;
 
int main()
{  
    
    int i = 0;
    int array [1];
    int n = 0;

    
    while (n != -1)
    {
        cin >> n;
        array[i] = n;

        int array2[sizeof(array)+1];
        for(int j = 0; j < i; j++){
            array2[i] = array[i];
        }
        i++;
    }  

    int *min = min_element(std::begin(array), end(array));
    int *max = max_element(std::begin(array), end(array));

    int sum = 0;

    for(int i=0; i<sizeof(array2); i++){
        sum = array2[i]+sum;
    }

    cout << "The min element is " << *min << std::endl;
    cout << "The max element is " << *max << std::endl;
    cout << "The sum is " << sum << endl;
    
    return 0;
}