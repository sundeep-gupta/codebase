#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <mem.h>
#include <limits.h>

#define EMPTY            -1
#define NO_PLAYER        -1
#define MAX_SEARCH_DEPTH 10
#define TRUE  		  1
#define FALSE 		  0
#define EMPTY 		 -1
#define PLAYER1 	  0 /* For Human Player */
#define PLAYER2 	  1 /* For Computer */
#define NO_PLAYER 	 -1
#define TIE 		  2
#define MAX_DIRECTION 	  8
#define DEPTH_TO_SEARCH  10 /* Lets search only 10 levels down first */
#define DROP_FAILED 	  0
#define DROP_PASSED 	  1

/* Macros */
#define real_player(x)      ((x) & 1)
#define pop_state()         (current_state = &state_stack[--depth])
#define other(x)            ((x) ^ 1)
#define goodness_of(player) (current_state->score[player] - current_state->score[other(player)])

/*
 * Function prototype definition 
 */
int    num_of_win_places(int , int , int );
void   update_score(int , int x, int y);
int    drop_piece(int , int , int );
void   push_state(void);
int    evaluate(int , int , int , int );
void*  emalloc(unsigned int n);
void   fillMap (int , int , int ) ;
void   update_drop_order();
void   print_board(void) ;
void   human_move(void);
void   computer_move(void);
void   start_game(void);
/*****************************************************************************
 *      		  Define DataTypes 				     *
 *****************************************************************************/
typedef struct {
	int **board; /* A 20 x 20 board */
	int* score_array[2]; /* score array of both player where each
				  * arrays size is num of win positions
				  */
	int score[2];
	int num_of_pieces;
	int winner;
	int ***win_table[2];
	int **drop_order[2];
} GameState;
/*****************************************************************************
 *      		  Global variables 				     *
 *****************************************************************************/
/*****************************************************************************
 *                        One time assigning 				     *
 *****************************************************************************/
int size_x, size_y, total_size;
int length;         /* length of snake. Here it is 1 less than num to connect; so 5 */
int num_to_connect; /* total number of cells that make up the snake; 6 here         */
int win_places ;    /* contains number of possible win positions                    */
int depth_to_search = MAX_SEARCH_DEPTH;
int ***map;
int comp_player  = 1; // computer move will always stored as 1 in the borad
int human_player = 0; // human player move will always stored as 0 in the board

int seed_chosen     = FALSE;

int move_in_progress;
int depth;
int states_allocated = 0;
int turn = -1;    // first move will be taken by user or computer is undecided
char symbol[2];

GameState *current_state;
GameState state_stack[MAX_SEARCH_DEPTH+1];

void new_game (int width, int height, int num) {
    int win_index;
    int i,j;
    /*
     * store arguments into global variables
     */
    size_x         = width;
    size_y         =  height;
    total_size     = width * height;
    num_to_connect = num;
    length         = num_to_connect - 1 ;


    /*
     * Set up a random seed for making random decisions when there is
     * equal goodness between two moves.
     */
    if (!seed_chosen) {
	srand((unsigned int) time((time_t *) 0));
	seed_chosen = TRUE;
    }

    /*
     * initialize the current state
     * which is empty
     */
    depth 			= 0;
    current_state               = &state_stack[0];
    current_state->board        = (int **) emalloc(size_x * sizeof(char *));

    current_state->win_table[PLAYER1] = (int ***) emalloc(size_x * sizeof(int **));
    current_state->win_table[PLAYER2] = (int ***) emalloc(size_x * sizeof(int **));

    current_state->drop_order[PLAYER1] = (int **) emalloc(size_x * size_y * sizeof(int *));
    current_state->drop_order[PLAYER2] = (int **) emalloc(size_x * size_y * sizeof(int *));

	 for( i = 0; i < size_x; i++) {
		current_state->board[i] = (int *) emalloc(size_y);

		current_state->win_table[PLAYER1][i] = (int **) emalloc(size_y * sizeof(int *));
		current_state->win_table[PLAYER2][i] = (int **) emalloc(size_y * sizeof(int *));

		for( j = 0; j < size_y; j++) {
			current_state->board[i][j] = EMPTY;

			current_state->win_table[PLAYER1][i][j] = (int *) emalloc(2 * sizeof(int));
			current_state->win_table[PLAYER1][i][j][0] = EMPTY;
			current_state->win_table[PLAYER1][i][j][1] = EMPTY;

			current_state->win_table[PLAYER2][i][j] = (int *) emalloc(2 * sizeof(int));
			current_state->win_table[PLAYER2][i][j][0] = EMPTY;
			current_state->win_table[PLAYER2][i][j][1] = EMPTY;

			current_state->drop_order[PLAYER1][i*size_y+j] = (int *) emalloc(2 * sizeof(int));
			current_state->drop_order[PLAYER1][i*size_y+j][0] = EMPTY;
			current_state->drop_order[PLAYER1][i*size_y+j][1] = EMPTY;

			current_state->drop_order[PLAYER2][i*size_y+j] = (int *) emalloc(2 * sizeof(int));
			current_state->drop_order[PLAYER2][i*size_y+j][0] = EMPTY;
			current_state->drop_order[PLAYER2][i*size_y+j][1] = EMPTY;
		}
	 }


    /*
     * Find the number of possible win positions
     */
    win_places = num_of_win_places(size_x, size_y, num_to_connect);


    /*
     * set up the score array for each player
     */
    current_state->score_array[0] = (int *) emalloc(win_places * sizeof(int));
    current_state->score_array[1] = (int *) emalloc(win_places * sizeof(int));
    for (i=0; i<win_places; i++) {
	current_state->score_array[0][i] = 1;
	current_state->score_array[1][i] = 1;
    }

    /*
     * Save accumulative score of each player.
     */
    current_state->score[0] = current_state->score[1] = win_places;

    /*
     * Set the winner
     */
    current_state->winner = NO_PLAYER;

    /*
     * number of pieces in board is zero now.
     */
    current_state->num_of_pieces = 0;
	 states_allocated = 1;

    /* 
     * Prepare the map of winning positions
     */
    map = (int ***) emalloc(size_x * sizeof(int **));
	 for (i=0; i<size_x; i++) {
		  map[i] = (int **) emalloc(size_y * sizeof(int *));
		  for (j=0; j<size_y; j++) {
				map[i][j] = (int *) emalloc((num_to_connect * MAX_DIRECTION + 1) * sizeof(int));
		      map[i][j][0] = EMPTY;
        }
	 }

	 /*
	  * Fill winning positions for each win index
	  */
	 win_index = 0;
	for(i = 0; i < size_y; i++) {
		for(j = 0; j < size_x; j++) {

			/*
			 * horizontal forward with head up
			 */
			 if (i+1 < size_y &&	j+5 < size_x ) {
				fillMap(i, j, win_index);
				fillMap(i, j+1, win_index);
				fillMap(i, j+2, win_index);
				fillMap(i, j+3, win_index);
				fillMap(i, j+4, win_index);
				fillMap(i+1, j+4, win_index);
				fillMap(i+1, j+5, win_index);
				win_index++;

				/* bitmap for direction of snake */
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x01;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x01;

				/* count of number of directions in which you can make move per cell */
				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
		 }

		/*
		 * horizontal forward with head down
		 */
			if (i-1 > 0 && j+5 < size_x ) {
				fillMap(i, j, win_index);
				fillMap(i, j+1, win_index);
				fillMap(i, j+2, win_index);
				fillMap(i, j+3, win_index);
				fillMap(i, j+4, win_index);
				fillMap(i-1, j+4, win_index);
				fillMap(i-1, j+5, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x02;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x02;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

			/*
			 * vertial down with head right
			 */

			if (i-5 > 0 &&	j+1 < size_x ) {
				fillMap(i, j, win_index);
				fillMap(i-1, j, win_index);
				fillMap(i-2, j, win_index);
				fillMap(i-3, j, win_index);
				fillMap(i-4, j, win_index);
				fillMap(i-4, j+1, win_index);
				fillMap(i-5, j+1, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x04;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x04;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

			/*
			 * vertical down with head left
			 */
			if (i-5 > 0 && j-1 > 0 ) {
				fillMap(i,   j, win_index);
				fillMap(i-1, j, win_index);
				fillMap(i-2, j, win_index);
				fillMap(i-3, j, win_index);
				fillMap(i-4, j, win_index);
				fillMap(i-4, j-1, win_index);
				fillMap(i-5, j-1, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x08;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x08;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

			/*
			 * horizontal backward with head down
			 */

			if (i-1 > 0 && j-5 > 0 ) {
				fillMap(i, j, win_index);
				fillMap(i, j-1, win_index);
				fillMap(i, j-2, win_index);
				fillMap(i, j-3, win_index);
				fillMap(i, j-4, win_index);
				fillMap(i-1, j-4, win_index);
				fillMap(i-1, j-5, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x10;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x10;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

		/*
		 * horizontal backward with head up
		 */
			if (i+1 < size_y &&	j-5 > 0 ) {
				fillMap(i, j, win_index);
				fillMap(i, j-1, win_index);
				fillMap(i, j-2, win_index);
				fillMap(i, j-3, win_index);
				fillMap(i, j-4, win_index);
				fillMap(i+1, j-4, win_index);
				fillMap(i+1, j-5, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x20;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x20;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

		/*
		 * vertical up with head left
		 */
			if (i+5 < size_y && j-1 > 0 ) {
				fillMap(i,   j, win_index);
				fillMap(i+1, j, win_index);
				fillMap(i+2, j, win_index);
				fillMap(i+3, j, win_index);
				fillMap(i+4, j, win_index);
				fillMap(i+4, j-1, win_index);
				fillMap(i+5, j-1, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x40;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x40;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}

		/*
		 * vertical up with head right
		 */

			if (i+5 < size_y && j+1 < size_x ) {
				fillMap(i,   j, win_index);
				fillMap(i+1, j, win_index);
				fillMap(i+2, j, win_index);
				fillMap(i+3, j, win_index);
				fillMap(i+4, j, win_index);
				fillMap(i+4, j+1, win_index);
				fillMap(i+5, j+1, win_index);
				win_index++;
				current_state->win_table[PLAYER1][i][j][0] = current_state->win_table[PLAYER1][i][j][0] ^ 0x80;
				current_state->win_table[PLAYER2][i][j][0] = current_state->win_table[PLAYER2][i][j][0] ^ 0x80;

				current_state->win_table[PLAYER1][i][j][1]++;
				current_state->win_table[PLAYER2][i][j][1]++;
			}
		}
	}

/*
 *  define the drop order.
 *  order in which if we search, we can make best move with less search.
 *  this is complex again, coz I'm determining each of my next move based on
 *  this order, It must be a 2D array minimum, (can include players also).
 *  where I must get the best row to search and best column to put as first
 *  and the worst row / col at last
 *
 * Again I'm thinking it to add to current state, coz each time a move
 * is made, the drop order may change. Hence we can have good optimization
 * lets see....
 *
 * This should be dependent on win table of the current state
 *
 */
	update_drop_order();

}

/*
 * Update drop order
 * method to update the order in which we'll be attempting
 * to place the coin
 */

 void update_drop_order() {
	int i, j;
	int **copy_of_win_table[2];
	int next_max_player1, next_max_player2, next_row_player1;
	int next_col_player1, next_row_player2, next_col_player2;

	/* create a copy of win table  of current state */
	copy_of_win_table[PLAYER1] = (int **) emalloc(size_x * sizeof (int *));
	copy_of_win_table[PLAYER2] = (int **) emalloc(size_x * sizeof (int *));
	for(i = 0; i < size_x ; i++) {
		copy_of_win_table[PLAYER1][i] = (int *) emalloc(size_y * sizeof (int));
		copy_of_win_table[PLAYER2][i] = (int *) emalloc(size_y * sizeof (int));
		for(j = 0; j <  size_y; j++) {
			copy_of_win_table[PLAYER1][i][j] = current_state->win_table[PLAYER1][i][j][1];
			copy_of_win_table[PLAYER2][i][j] = current_state->win_table[PLAYER2][i][j][1];
		}
	}

	/* now find the position in the copied table, where if coin is placed has max possibilities */
	for(int k = 0; k < size_x * size_y; k++) {
		next_max_player1 = -1;
		next_max_player2 = -1;
		next_row_player1 = -1;
		next_col_player1 = -1;
		next_row_player2 = -1;
		next_col_player2 = -1;
		for (i = 0;i < size_x; i++ ) {
			for (j = 0; j < size_y; j++) {
				if (copy_of_win_table[PLAYER1][i][j] > next_max_player1) {
					next_max_player1 = copy_of_win_table[PLAYER1][i][j];
					next_row_player1 = i;
					next_col_player1 = j;
				}
				if (copy_of_win_table[PLAYER2][i][j] > next_max_player2) {
					next_max_player2 = copy_of_win_table[PLAYER2][i][j];
					next_row_player2 = i;
					next_col_player2 = j;
				}
			}
		}
		copy_of_win_table[PLAYER1][next_row_player1][next_col_player1]  = EMPTY;
		copy_of_win_table[PLAYER2][next_row_player2][next_col_player2]  = EMPTY;
		current_state->drop_order[PLAYER1][k][0] = next_row_player1;
		current_state->drop_order[PLAYER1][k][1] = next_col_player1;
		current_state->drop_order[PLAYER2][k][0] = next_row_player2;
		current_state->drop_order[PLAYER2][k][1] = next_col_player2;
	}
 }


void fillMap (int x, int y, int win_index) {
	 int *winIndices = map[x][y];
	 for(int i = 0; winIndices[i] != EMPTY;i++);
	 winIndices[i++] = win_index;
	 winIndices[i] = EMPTY;
}


/*
 * Returns the number of possible win positions
 * for the given board of width, and height with
 * num pieces to place
 */
int num_of_win_places (int width, int height, int num) {
	 /*
     * Currently I have number of possible win
     * places for 20 x 20 board. I need to find the
     * algorithm to get that number
     */
	 return (width == 20 && height == 20 && num == 6) ? 2432 : 0;
}

/*
 * Function to make an automatic move for computer
 * Aim is to make it as optimal as possible with competitive wait time.
 */

int auto_move ( int player, int level, int *col, int *row) {
	int result;
   int num_of_equal;
    int best_col = -1;
    int best_row = -1;

    int best_worst = -(INT_MAX);

    int num_to_equal = 0;

    int goodness = 0;

    int realplayer = real_player(player);

    int current_col, current_row;

    /* 
     * if you know any position in the board where if it is empty, it will always lead to a win
     * then simply put the piece over there.
     */




     /* 
      * Lets move further, thinking as we don't know such option...
      */
	 move_in_progress = TRUE;
	 for (int i = 0; current_state->drop_order[realplayer][i][0] != EMPTY &&
	 					  current_state->drop_order[realplayer][i][1] != EMPTY     ; i++ ) {

		current_row = current_state->drop_order[realplayer][i][0];
		current_col = current_state->drop_order[realplayer][i][1];

		/*
		 * save the current state of the game
		 */
		push_state();

		/*
		 * now lets see the result of placing the pice in current_col and current_row
		 */
		result = drop_piece(realplayer, current_row, current_col);
	
		/*
		 * if we cannot place the coin in the cell...
		 */
		if (result == DROP_FAILED) {
			 pop_state();
			 continue;
		}
	
		/*
		 * I'm able to place the cell, so lets see if I'm winner
		 */
		if ( current_state->winner == realplayer) {
			 best_col = current_col;
			 best_row = current_row;
			 pop_state();
			 break;
		}

		/*
		 * No I didn't win. So lets evaluate my move
		 */
//		next_poll = clock + poll_interval; /* This move can be skipped... lets see */
		goodness = evaluate(realplayer, level, -INT_MAX, -best_worst);

		/*
		 * Now I evaluated my move.
		 * Lets see if it is better than my earlier test moves...
		 */
		if(goodness > best_worst) {
			 best_worst = goodness;
			 best_col = current_col;
			 best_row = current_row;
			 num_of_equal = 1;
		} else if (goodness == best_worst) {
			 num_of_equal++;
			 if( (rand() >> 4) % num_of_equal == 0) {
				best_col = current_col;
			}
		}

		/*
		 * finally pop the state
		 */
		pop_state();

	} /* end of the main for loop */

	move_in_progress = FALSE;

	 /*
	  * Lets see if I found the best_col and best_col
	  */
	if (best_col >= 0 && best_row >= 0) {
		result = drop_piece(realplayer, best_row, best_col);
		if (result == DROP_FAILED)
			 return FALSE;
		return TRUE;
	}
	return FALSE;

}



/****************************************************************************/
/**                                                                        **/
/**  This function pushes the current state onto a stack.  pop_state()     **/
/**  is used to pop from this stack.                                       **/
/**                                                                        **/
/**  Technically what it does, since the current state is considered to    **/
/**  be the top of the stack, is push a copy of the current state onto     **/
/**  the stack right above it.  The stack pointer (depth) is then          **/
/**  incremented so that the new copy is considered to be the current      **/
/**  state.  That way, all pop_state() has to do is decrement the stack    **/
/**  pointer.                                                              **/
/**                                                                        **/
/**  For efficiency, memory for each stack state used is only allocated    **/
/**  once per game, and reused for the remainder of the game.              **/
/**                                                                        **/
/****************************************************************************/

void push_state(void) {
    register int i, win_places_array_size;
    GameState *old_state, *new_state;

    win_places_array_size = win_places * sizeof(int);
    old_state = &state_stack[depth++];
    new_state = &state_stack[depth];

    if (depth == states_allocated) {

        /* Allocate space for the board */

        new_state->board = (char **) emalloc(size_x * sizeof(char *));
        for (i=0; i<size_x; i++)
            new_state->board[i] = (char *) emalloc(size_y);

        /* Allocate space for the score array */

        new_state->score_array[0] = (int *) emalloc(win_places_array_size);
        new_state->score_array[1] = (int *) emalloc(win_places_array_size);

        states_allocated++;
    }

    /* Copy the board */

    for (i=0; i<size_x; i++)
        memcpy(new_state->board[i], old_state->board[i], size_y);

    /* Copy the score array */

    memcpy(new_state->score_array[0], old_state->score_array[0],
           win_places_array_size);
    memcpy(new_state->score_array[1], old_state->score_array[1],
           win_places_array_size);

    new_state->score[0] = old_state->score[0];
    new_state->score[1] = old_state->score[1];
    new_state->winner = old_state->winner;
    new_state->num_of_pieces = old_state->num_of_pieces;

    current_state = new_state;
    /* TODO: Push all other members of current state... coz above method is just
     * copy paste 
     */
}


/*
 *
 * Now lets frame another big function... evaluate
 * TODO: ANALYZE THE FUNCTION AND 
 */

/****************************************************************************/
/**                                                                        **/
/**  This recursive function determines how good the current state may     **/
/**  turn out to be for the specified player.  It does this by looking     **/
/**  ahead level moves.  It is assumed that both the specified player and  **/
/**  the opponent may make the best move possible.  alpha and beta are     **/
/**  used for alpha-beta cutoff so that the game tree can be pruned to     **/
/**  avoid searching unneccessary paths.                                   **/
/**                                                                        **/
/**  The specified poll function (if any) is called at the appropriate     **/
/**  intervals.                                                            **/
/**                                                                        **/
/**  The worst goodness that the current state can produce in the number   **/
/**  of moves (levels) searched is returned.  This is the best the         **/
/**  specified player can hope to achieve with this state (since it is     **/
/**  assumed that the opponent will make the best moves possible).         **/
/**                                                                        **/
/****************************************************************************/

static int
evaluate(int player, int level, int alpha, int beta)
{
    int i, goodness, best, maxab;
    /*
     * This is to call poll function... if it is defined
     * This may not be required... lets see...
     */
/*    if (poll_function != NULL && next_poll <= clock()) {
		  next_poll += poll_interval;
		  (*poll_function)();
	 }
*/
    /*
     * If current state indicates that the winner is found
     * then return the corresponding goodnes of the player
     * which obviously will be such that no value can overome it.
     */
    if (current_state->winner == player) {
        return INT_MAX - depth;
    } else if (current_state->winner == other(player)) {
        return -(INT_MAX - depth);
    }
    /* 
     * check if it is a tie...
     * tie can be identified based on num of pieces on table
     * or even if table has free cells, if we can find that
     * no move can lead to win position, then it is a tie.
     * TODO: second option...
     */
    else if (current_state->num_of_pieces == total_size || 
	     NO_PIECE_CAN_LEAD_TO_WIN) {
        return 0; /* a tie */
    }
    /*
     * I have searched depth enough, lets return back the goodness of this player.
     */
    else if (level == depth) {
        return goodness_of(player);
    }
    /*
     * Lets assume what opposite player will make a move like,
     * based on what I have moved...
     */
    else {
        /* Assume it is the other player's turn. */
        best = -(INT_MAX);
        maxab = alpha;
	/*
	 * get the new drop order
         * Note: Make sure we are not calculating it twice, coz drop_piece should
         * be the correct place to do this.
         */
//	update_drop_order(); /* always works on current_state */
	int current_col;
	int current_row;
	
	 for (int i = 0; current_state->drop_order[player][i][0] != EMPTY &&
						  current_state->drop_order[player][i][1] != EMPTY     ; i++ ) {

		current_row = current_state->drop_order[player][i][0];
		current_col = current_state->drop_order[player][i][1];
   	    
	    /*
 	     * C4 had check here to see if col is full 
	     * but I'm avoiding it... lets keep open to add it
	     * if required.
	     */

    	    /*
             * push the current state into the stack
             */
            push_state();
	
	    /* 
             * Now lets drop the piece into the best cell of the other player.
             * TODO: make sure your call to drop piece is correct... mainly order of parameters.
             */

            drop_piece(other(player), current_row, current_col);
	    /* 
             * unlike in auto move function, where we did check if we are winner, 
             * we did not do it here, coz evaluate does that as first step....
	     * my only concern is we are not capturing drop piece's result 
             * to check if that move cannot be made... lets do it...
	     * 
	     * So here I evaluate the move in view of opposite player and get his goodness.
             */
            goodness = evaluate(other(player), level, -beta, -maxab);
	    /* 
             * other player sees if it is his best move...
	     * just similar to what real player does.
	     */
            if (goodness > best) {
                best = goodness;
                if (best > maxab)
                    maxab = best;
            }
	    /*
	     * pop the state...
	     */
            pop_state();

	    /*
	     * finally I found the best...
	     * beta is nothing but real player's best (I think... not sure)
	     */ 
            if (best > beta)
                break;
        }

        /* What's good for the other player is bad for this one. */
        return -best;
    }
}


/*
 * Now lets see how the drop piece function should be like
 * I'm just copy pasting it...
 * we'll fix it asap... and I'm willing to nail them off tomm..
 */

/****************************************************************************/
/**                                                                        **/
/**  This function drops a piece of the specified player into the          **/
/**  specified column.  The row where the piece ended up is returned, or   **/
/**  -1 if the drop was unsuccessful (i.e., the specified column is full). **/
/**                                                                        **/
/****************************************************************************/

int drop_piece(int player, int col, int row) {
    /*
     * As I have row and col both, I'm just using trivial method
     * to drop the piece...
     * TODO: i'm still confused about x and y. for row and cols...
     */
	 if (row >= size_x || col >= size_y || col < 0 || row < 0  || current_state->board[col][row] != EMPTY)
        return DROP_FAILED;


    current_state->board[col][row] = player;
    current_state->num_of_pieces++;
	 update_score(player, col, row);
	 update_drop_order();
    return DROP_PASSED; /* as I already have row... I need not send it again... so using booleans...*/
}


/* 
 * Now lets put the update_score in place... 
 * and put down the points that need to be modified as per my knowledge.
 *
 */ 




/****************************************************************************/
/**                                                                        **/
/**  This function updates the score of the specified player in the        **/
/**  context of the current state,  given that the player has just placed  **/
/**  a game piece in column x, row y.                                      **/
/**                                                                        **/
/****************************************************************************/

void update_score(int player, int x, int y) {
    register int i;
    int win_index;
    int this_difference = 0, other_difference = 0;
    /*
     * Capture the current score array
     */ 
    int **current_score_array = current_state->score_array;
    int other_player = other(player);

  /*  This is C4 s algorithm and I'm commenting it out
   * For the given cell, i, j, we will be having all win indexes for that
   * cell in the map. So loop through all indexes of that cell.
   * 
   * So for each win index we will increase the score. 
   * for opposite player we will make that win index zero.
   * Finally do the adjusting to cumulative score.
   *
   * for (i=0; map[x][y][i] != -1; i++) {
   *     win_index = map[x][y][i];
   *     this_difference += current_score_array[player][win_index];
   *     other_difference += current_score_array[other_player][win_index];

   *     current_score_array[player][win_index] <<= 1;
	*     current_score_array[other_player][win_index] = 0;

   *     if (current_score_array[player][win_index] == magic_win_number)
   *         if (current_state->winner == C4_NONE)
   *             current_state->winner = player;
   * }
   *
   * current_state->score[player] += this_difference;
   * current_state->score[other_player] -= other_difference;
	*
	*/


	 /*
	  * here are some heuristic stuff... for Snaky
	  */
	 /*
	  * TODO: Something similar in case of updating score array
	  * But we also have some other elements like win table , which need to be
	  * updated as well... lets follow up on this tomm....
	  * Not satisfactory work... but pack of tomm... don't mood off yourself if u
	  * could not do coz of family... coz its ur mistake today.
	  * I'm happy India is thru to finals.
	  */


}



/****************************************************************************/
/**                                                                        **/
/**  A safer version of malloc().                                          **/
/**                                                                        **/
/****************************************************************************/

static void * emalloc(unsigned int n) {
    void *ptr;

    ptr = (void *) malloc(n);
    if (ptr == NULL) {
        fprintf(stderr, "c4: emalloc() - Can't allocate %d bytes.\n", n);
        exit(1);
	 }
	 return ptr;
}
 





/*
 * The UI part... copied from UI.cpp
 */
int main() {
    /* Initial Configuration of the game */
    char p;

    /* initialize the board */
    new_game(20,20,6);
    
    /* print the board */
    print_board();
    
    do {
	/* ask who is playing what */
	printf("Snaky with basic Interface \n");
	printf("===========================\n");;
	printf("Player 1 :   X" );
	printf("Player 2 :   O" );
	printf("X will always start first\n");
	printf("Enter Your Choice X or O      :");
	scanf("%c",&p);
	if(p=='X' || p=='x' || p=='o' || p=='O') {
	    break;
	} else {
	    printf("Invalid Input !\n");
	}
	/* flush(STDIN); */
    } while (TRUE);
   
     turn = (p=='X' ||  p=='x') ? PLAYER1 : PLAYER2;
     /* Store the symbols of the players*/
     symbol[turn]        = 'X';
     symbol[turn ^ 0x01] = 'O';  

     start_game(); // starting the game
     return 0;
}

/********** Print Board **************/
void print_board(void) {
/*    system("clear"); */
    
    /*************** Priniting Colum Numbers *************/
    for(int cc = 0;cc < 20; cc++) {
	if(cc==0) {
	    printf("     %d ",cc+1);
	} else {
	    if(cc+1 < 10) {
		printf(" %d ",cc+1);
	    } else {
		printf(" %d",cc+1);
	    }
	}
    }
    printf("\n");
    for(int i = 0; i < 20;i++) {
	/**** Just for the out put of row number ****/
	if(i+1<10) {
	    printf(" %d  ",i+1);
	} else {
	    printf(" %d ",i+1);
	}
	/****** End of output row number *******/
	for(int k=0;k<20;k++) {
	    if (current_state->board[i][k]==-1) {
		printf(" + "); // un occupied place is shown as + sign
	    } else {
		printf(" %c ",symbol[current_state->board[i][k]]); // place is occupied by computer
	    }
	}
	printf("\n");
    }
}

/********************* This function will start the game and we will remain in this function until
 * either player wins or board gets full means its a tie *********/
void start_game(void) {
    while(1) {
	if(current_state->winner == PLAYER1) {
	    /* Player 1 won   */
	    return;
	} else if (current_state->winner == PLAYER2) {
	    /** Player 2 won */
	    return;
	} else if (current_state->winner == TIE) {
	    /*
	     * There is a tie
	     * tie can be due to board full and
	     * my algorithm should handle this
	     * I'm not gonna handle it here.
	     */
	}
	/*
	 * Game is not over yet...
	 * So carry on guys...
	 */
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
    int row, col;
    if ( auto_move( comp_player, DEPTH_TO_SEARCH, &row, &col) == TRUE) {
	/* make move here */
	drop_piece(comp_player, row, col);
	/* check if drop was successful */
    } else {
	/* Come here only if
	 * no move is possible
	 * do the required....
	 */
    }
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
	    printf("Enter Row position of your desired move (Row Starts from 1 ) :");
	    scanf("%d",&row);
	    if(row<1 || row > size_x) {
		printf("Invalid Row Number !\n");
		printf("Enter Row position of your desired move (Row Starts from 1 ) :");
		scanf("%d",&row);
	    } else {
		break;
	    }
	}
	/************* taking column number *************/
	while(1) {
	    printf("Enter Column position of your desired move (Column Starts from 1) :");
	    scanf("%d",&col);
	    if(col<1 || col> size_y)  {
		printf("Invalid Column Number !\n");
		printf("Enter Column position of your desired move (Column Starts from 1 ) :");
		scanf("%d",&col);
	    } else {
		break;
	    }
	}
	if(current_state->board[row-1][col-1]==EMPTY) {
	     drop_piece(human_player, row-1, col-1);
	     /* TODO: check if move was succesful */
	     // later will calculate the new goodness value for both players after this move
	     break;
	} else {
	    printf("Position Already occupied !\n");
	}
    } // end of outer while
}// end of function














