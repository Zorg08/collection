#include <iostream> 

using namespace std;

int sum (int x, int y){

int z;
z = x +y;
return (z);

}


int main(){
int a, b, result;
cout << "enter the two numbers " << endl;
cin >> a;
cin.ignore();
cin >> b;
cin.ignore();

result = sum(a,b);

cout << "the reuslt is " << a << "+" << b << " is " << result;
cin.ignore();






}
