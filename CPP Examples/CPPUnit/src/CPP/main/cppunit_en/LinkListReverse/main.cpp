#include <iostream>

using namespace std;

class Node {
public:
	int num;
	Node* next;
	Node() {
		next=NULL;
	}
	Node(int ip) {
	    num=ip;
		next=NULL;
	}
};

//Program for reversing the singly linked list.
int main() {
	Node *HEAD,*temp;
	int i,j,N;
	
	cout << "Give the no.of elements in the singly linked list" << endl;
	cin >> N;
	cout << " Type in the elements of the linked list " << endl;
	
	if(N>0) {
		cin >> j;
		HEAD = new Node(j);
		temp=HEAD;
	} else exit(1);
	
	i=1;
	while(i<N) {
		cin >> j;
		temp->next = new Node(j);
		temp = temp->next;
		i++;
	}
	
	//Reverse the singly linked list
	Node *tmp1,*tmp2;
	
	tmp1=NULL;
	temp=HEAD;
	
	while(temp!=NULL) {
		tmp2=temp->next;
		temp->next=tmp1;
		tmp1=temp;
		temp=tmp2;
		
	}
	
	HEAD=tmp1;
	
	temp=HEAD;
	while(temp!=NULL){
		cout <<"   " << temp->num;
		temp=temp->next;
	}
}
