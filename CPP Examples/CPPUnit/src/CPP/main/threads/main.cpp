#include <iostream>
#include <pthread.h>

using namespace std;

class Node {
public:
	int value;
	Node *next;
	Node(int num) {
		value = num ;
		next = NULL ;
	}
};

Node *HEAD; 
int n=0;

void *thread1func(void *ptr);
void *thread2func(void *ptr);
void *thread3func(void *ptr);

int main ()  {
	pthread_t thread1,thread2,thread3;
	int retval;
	
	retval = pthread_create(&thread1,NULL,thread1func,(void*)HEAD);
	retval = pthread_create(&thread2,NULL,thread2func,(void*)HEAD);
	retval = pthread_create(&thread3,NULL,thread3func,(void*)&thread1);

	pthread_join(thread1,NULL);
	pthread_join(thread2,NULL);
	
	Node *tmp;
	cout << " The elements remained in the linked list are : ";
	if(HEAD!=NULL)
	for(tmp=HEAD;tmp!=NULL;tmp=tmp->next)
	{
		cout << tmp->value << "	";
	}
	
	exit(0);
}

void *thread1func (void *ptr) {
	Node *tmp1,*tmp2;
	tmp1=HEAD;
	int a,i;
	for(i=0;i<30;i++) {
		while(1) {
			if(n==0)
				break;
		}
		n=1;
		cout << " Enter the element to be added:  ";
		cin >> a;
		tmp2 = new Node(a);
		if(HEAD == NULL)
			HEAD = tmp2;
		else {
			tmp1 = HEAD;
			for(;tmp1->next!=NULL;tmp1=tmp1->next);
			tmp1->next = tmp2;
		}
		cout << " The element " << tmp2->value << " is added " << endl;
		n=0;
		sleep(1);
	}
	
}

void *thread2func(void *ptr) {
	Node *tmp1,*tmp2;
	tmp1=HEAD;
	int i;
	for(i=0;i<20;i++) {
		while(1) {
			if(n==0)
				break;
		}
		n=1;
		
		if(HEAD == NULL) {
			cout << " The list is now empty and there is no node to delete " << endl; 
		} else {
			tmp2 = HEAD; 
			tmp1 = tmp2->next;
			if(tmp1 == NULL) {
				cout << " The element " << tmp2->value << " is deleted " << endl;
				delete tmp2;
				HEAD = NULL;
			} else {
				for(;tmp1->next!=NULL;) {
					tmp1=tmp1->next;
					tmp2=tmp2->next;
				}
				cout << " The element " << tmp1->value << " is deleted " << endl;
				tmp2->next = NULL;
				delete tmp1;
			}
		}
		n=0;
		sleep(2);
	}
	
}

void *thread3func(void *ptr)
{
	pthread_t *thread;
	thread = (pthread_t*)ptr;
	pthread_join(*thread,NULL);
	cout << " Waited till all the addition of elements to the list is done " << endl;
}
