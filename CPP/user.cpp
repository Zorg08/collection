#include <iostream>
using namespace std;

int main()
{

int uservalue;

cout << "This program adds 10 to your input" << endl;
cout << "Please insert your input ";

cin >> uservalue;
cout << "The value inserted is " << uservalue;
cout << " and the new value is " << uservalue + 10 << endl;

cin.ignore();
cout << "Press Enter to exit....";
cin.ignore();

return 0;

}

