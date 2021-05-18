#include <iostream>

using namespace std;

int main() {

int user_value;
cout << " 1 - Addition\n 2 -Subtraction\n 3 - Multiply\n 4 -Divide\n 5 - Exit program\n ";
cout << "insert number";
cin >> user_value;
cin.ignore();

switch (user_value){
case 1:
cout << "Addition";
break;
case 2:
cout << "Subtract";
break;
case 3:
cout << "mulitply";
break;
case 4:
cout << "division";
break;
case 5:
cout << "Bye felicia";
break;
default:
cout << "Wrong !!";
}

cin.ignore();
return 0;



}
