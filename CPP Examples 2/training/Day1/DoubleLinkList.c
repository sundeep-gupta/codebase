#include <stdio.h>
#include <malloc.h>

struct Employee {
    int emp_no;
    char *name;
    char *dept;
    float salary;
};

struct EmployeeTable {
    struct Employee *employee;
    struct EmployeeTable *next;
    struct EmployeeTable *prev;
};

struct EmployeeTable *et;
struct EmployeeTable *current, *first;

int add_emp(struct Employee *e) {
    /* This is the first node to get added */
    struct EmployeeTable *row;
    row = (struct EmployeeTable *) malloc(sizeof(struct EmployeeTable));
    row->next = NULL;
    row->prev = NULL;
    row->employee = malloc(sizeof(struct Employee));
    row->employee->emp_no = e->emp_no;
    row->employee->name = e->name;
    row->employee->dept = e->dept;
    row->employee->salary = e->salary;
    if (first == NULL) {
        current = row;
        first = current;
    } else {
        current->next = row;
        current->next->prev = current;
        current = row;
    }
}

int del_emp(int emp_no) {
    struct EmployeeTable *p = first;
    struct EmployeeTable *prev  = NULL;
    struct EmployeeTable *next = NULL;
    while(p) {
        if(p->employee->emp_no == emp_no){
            prev = p->prev;
            next = p->next;
            prev->next = next;
            next->prev = prev;
            free(p);
            return 1;
        }
        p = p->next;
    }
    printf("Failed to find\n");
    return 0;
}
int upd_emp(struct Employee *e){
    struct EmployeeTable *p = first;
    while(p) {
        if(p->employee->emp_no == e->emp_no) {
            p->employee->name = e->name;
            p->employee->salary = e->salary;
            p->employee->dept = e->dept;
            printf("Updated successfully\n");
            return 1;
        }
        p = p->next;
    }
    printf("Failed to update\n");
    return 0;
}
int search_emp(int emp_no) {
    struct EmployeeTable *p = first;
    while(p) {
        if (p->employee->emp_no == emp_no) {
            printf("Match found\n");
            return 1;
        }
        p = p->next;
    }
    printf("Not found");
    return 0;
}

void print_record(struct Employee *e) {
    if(e != NULL) {
        printf("%d : %s : %s : %f\n", e->emp_no, e->name, e->dept, e->salary);
    } else 
        printf("Null Found\n");
}

void print_records() {
    struct EmployeeTable *p = first;
    while(p) {
        print_record(p->employee);
        p = p->next;
    }
}
int main() {
    struct Employee e;
    e.emp_no = 1;
    e.name = "Sundeep";
    e.dept = "Kb";
    e.salary = 123.0;

    add_emp(&e);
    e.emp_no = 2;
    add_emp(&e);
    search_emp(1);
    e.name = "Tejas Patil";
    upd_emp(&e);
    e.emp_no = 3;
    e.name = "Anand Pandit";
    add_emp(&e);
    printf("Printing records after adding 3 records\n");
    print_records();
    del_emp(2);
    printf("Printing records after deleting record 2\n");
    print_records();
}
