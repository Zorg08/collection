
#include <iostream>
using namespace std;

int main(){

int user_value;
for (;;){
cout << " 1 - Addtion\n 2 - Exit Program\n";
cout << "Insert a number: ";
cin >> user_value;
cin.ignore();

if (user_value == 1){
cout << "Your addition source code here\n\n";
}else if(user_value == 2){
cout << "Bye";
break;
}else{
cout << "Wrong data\n\n";
}

}

cin.ignore();
return 0;


}
