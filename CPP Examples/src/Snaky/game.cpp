/************************************
      x x
x x x x
 
The above mentioned animal is snaky and any translation (along X or Y), rotation (along X or Y) and reflection (along X or Y) is allowed means

    x                          x                             
    x                          x
    x                          x
    x x                      x x 
      x                      x

and many more are also snaky who ever human or computer make this shape first by his symbols is a winner

************************************/

#include <iostream.h>
#include "snaky.cpp"
//using namespace std;

/******* 20 X 20 Board ******/
int board[20][20]; //computer move will be stroed as 1, human move will be stored as 0 , and an un occupied place is -1
int comp_player = 1; // computer move will always stored as 1 in the borad
int human_player=0; // human player move will always stored as 0 in the board
int turn=-1; // first move will be taken by user or computer is undecided
char comp_symbol; //depending on who will take first move computer's symbol X or O will be decided 
char human_symbol; //depending on who will take first move human's symbol X or O will be decided

/*
 * ***** Function Prototypes *****
 */
void print_board(void);
void human_move(void);
void computer_move(void);
void start_game(void);
 
int main() {
   /************ Initial Configuration of the game *************/
	char p;
   /* initialize the board */
	new_game(20,20,6);

	/* print the board */
	print_board();

	/* ask who is playing what */

	cout<<"Snaky with basic Interface "<<endl;
	cout<<"==========================="<<endl;
	cout<<"Player 1 :   X"  <<endl;
	cout<<"Player 2 :   O"  <<endl;
	cout<<"Enter Your Choice X or O      :";
	while(1) {
	  cin>>p;
	  if(p=='X' || p=='x' || p=='o' || p=='O') {
		 break;
	  } else {
			cout<<"Invalid Input !"<<endl;
			cout<<"Player 1 :   X"  <<endl;
			cout<<"Player 2 :   O"  <<endl;
			cout<<"Enter Your Choice X or O      :";
	  }
	}

	if(p=='X' || p=='x') {
	  comp_symbol='O';
	  turn=human_player;
	  human_symbol='X';
	} else {
	  comp_symbol='X';
	  turn=comp_player;
	  human_symbol='O';
	}
	start_game(); // starting the game
	return 0;
}

/****** init_board implementation ******/
void init_board(void)  {
	for(int i =0; i<20;i++)	{
	  for(int k=0;k<20;k++) {
		  board[i][k]=-1; // no one occupying any place on the board
	  }
	}
}

/********** Print Board **************/

void print_board(void) {
  system("clear");

	/*************** Priniting Colum Numbers *************/

	 for(int cc=0;cc<20;cc++) {
		if(cc==0) {
			cout<<"     "<< cc+1 <<" ";
		} else {
			 if(cc+1<10) {
				cout<<" "<<cc+1<<" ";
			 } else {
				cout<<" "<<cc+1;
			 }
		}
	}
	cout<<endl;
	for(int i =0; i<20;i++) {
		/**** Just for the out put of row number ****/
		if(i+1<10) {
			cout<<" "<<i+1<<"  ";
	  } else {
			cout<<" "<<i+1<<" ";
	  }
		 /****** End of output row number *******/
	  for(int k=0;k<20;k++) {
		 if (board[i][k]==-1) {
			 cout<<" + "; // un occupied place is shown as + sign
		 } else if (board[i][k]==comp_player) {
			 cout<<" "<<comp_symbol<<" "; // place is occupied by computer
		 } else {
			 cout<<" "<<human_symbol<<" "; // place is occupied by computer
		 }
	  }
	  cout<<endl;
	}
}
/********************* This function will start the game and we will remain in this function until
either player wins or board gets full means its a tie *********/
void start_game(void) {
	while(1) {
		//if(some player won) // check winning conditions
		 //{
				// print winning player
				// break;
		 //}

		 //if(board is full)
			//{
				 //no body won its a tie
				 // break;
			//}

		if(turn==comp_player) {
		  computer_move();// this needs to be implemented
		  turn =human_player; //next move will be taken by human
		}
		if(turn==human_player) {
			 human_move();
			 turn =comp_player; //next move will be taken by computer
		}
	}
}


/***** This function is suppose to be implmented using min max search that which positon computer should occupy
either to stop human from winning and also making himself a winning position******/

void computer_move(void) {
	// This function is empty and needed to be imlemented
	 //place symbol at the selected position by computer based on min max
	 // weights gets recalculated after computer move and other stuff required for Artificial intellgience

}

/****** This is the function where human takes his move right now we are just placing human player at the particual position
but later we may add weighing conditions and re-calculation of fitness for each player that after human took move how good are things
for human and for computer now **********/

void human_move(void) {
  // not we are taking columns as first parameter of array and rows as second
  int row=-1;
  int col=-1;
  print_board();
	while(1) {
 /*************** taking row number ****************/
	  while(1) {
		  cout<<"Enter Row position of your desired move (Row Starts from 1 ) :";
		  cin>>row;
		  if(row<1 || row>20) {
			 cout <<"Invalid Row Number !"<<endl;
			 cout<<"Enter Row position of your desired move (Row Starts from 1 ) :";
			 cin>>row;
		  } else {
			  break;
		  }
	  }
		/************* taking column number *************/
	  while(1) {
		  cout<<"Enter Column position of your desired move (Column Starts from 1) :";
		  cin>>col;
		  if(col<1 || col>20)  {
			 cout <<"Invalid Column Number !"<<endl;
			 cout<<"Enter Column position of your desired move (Column Starts from 1 ) :";
			 cin>>col;
		  } else {
			  break;
		  }
	  }
	  if(board[row-1][col-1]==-1) {
		  board[row-1][col-1]=human_player; // assigning position to human player
		  // later will calculate the new goodness value for both players after this move
		  break;
	  } else {
		  cout <<"Position Already occupied !"<< endl;
	  }
	} // end of outer while
}// end of function
