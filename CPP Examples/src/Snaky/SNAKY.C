#define EMPTY     -1;
#define NO_PLAYER -1;
#define MAX_SEARCH_DEPTH 20;

int size_x, size_y, total_size;
int length;         /* length of snake. Here it is 1 less than num to connect; so 5 */
int num_to_connect; /* total number of cells that make up the snake; 6 here         */
int win_places ;    /* contains number of possible win positions                    */
int depth_to_search = MAX_SEARCH_DEPTH;

typeded struct {
	char **board; /* A 20 x 20 board */
	
	int* score_array[2]; /* score array of both player where each
                             * arrays size is num of win positions 
                             */
	int score[2]; 
	
	int ***map;

	int num_of_pieces;

	int winner;
} GameState;

GameState *current_state;
GameState *state_stack[depth_to_search];

int newGame (int width, int height, int num) {
    int win_index;
    /* 
     * store arguments into global variables
     */
    size_x = width;
    size_y = height;
    total_size = width * height;
    num_to_connect = num;
    length = num_to_connect ;


    /*
     * Set up a random seed for making random decisions when there is 
     * =ual goodness between two moves.                              
     */
    if (!seed_chosen) {
        srand((unsigned int) time((time_t *) 0));
        seed_chosen = TRUE;
    }	

    /* 
     * initialize the current state
     * which is empty 
     */

    current_state = &state_stack[0];
    current_state->board  = (char **) emalloc(size_x * sizeof(char *));
    for(i = 0; i < size_x; i++) {
        current_state->board[i] = (char *) emalloc(size_y);
  	for(j = 0; j < size_y; j++) {
	    current_state->board[i][j] = EMPTY;
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

	    winIndices = map[i][j];
	    if (i+1 < size_y &&
		j+5 < size_x ) {
		/*
		 * horizontal forward with head up
		 */
		fillMap(i, j, win_index);
		fillMap(i, j+1, win_index);
		fillMap(i, j+2, win_index);
		fillMap(i, j+3, win_index);
		fillMap(i, j+4, win_index);
		fillMap(i+1, j+4, win_index);
		fillMap(i+1, j+5, win_index);
		win_index++;

		/* bitmap for direction of snake */
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x01;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x01;

		/* count of number of directions in which you can make move per cell */
		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;

	    }
		
	    if (i-1 > 0 &&
		j+5 < size_x ) {
		/*
		 * horizontal forward with head down
		 */
		fillMap(i, j, win_index);
		fillMap(i, j+1, win_index);
		fillMap(i, j+2, win_index);
		fillMap(i, j+3, win_index);
		fillMap(i, j+4, win_index);
		fillMap(i-1, j+4, win_index);
		fillMap(i-1, j+5, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x02;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x02;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
	    }
		
	    if (i-5 > 0 &&
		j+1 < size_x ) {
		/*
		 * vertial down with head right
   		 */
		fillMap(i, j, win_index);
		fillMap(i-1, j, win_index);
		fillMap(i-2, j, win_index);
		fillMap(i-3, j, win_index);
		fillMap(i-4, j, win_index);
		fillMap(i-4, j+1, win_index);
		fillMap(i-5, j+1, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x04;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x04;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;	    
	    }

	    if (i-5 > 0 &&
		j-1 > 0 ) {
		/*
		 * vertical down with head left
   		 */
		fillMap(i,   j, win_index);
		fillMap(i-1, j, win_index);
		fillMap(i-2, j, win_index);
		fillMap(i-3, j, win_index);
		fillMap(i-4, j, win_index);
		fillMap(i-4, j-1, win_index);
		fillMap(i-5, j-1, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state-> win_table[player1][i][j] & 0x08;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x08;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
	    }

	    if (i-1 > 0 &&
		j-5 > 0 ) {
		/*
		 * horizontal backward with head down
   		 */
		fillMap(i, j, win_index);
		fillMap(i, j-1, win_index);
		fillMap(i, j-2, win_index);
		fillMap(i, j-3, win_index);
		fillMap(i, j-4, win_index);
		fillMap(i-1, j-4, win_index);
		fillMap(i-1, j-5, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x10;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x10;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
	    }

	    if (i+1 < size_y &&
		j-5 > 0 ) {
		/*
		 * horizontal backward with head up
   		 */
		fillMap(i, j, win_index);
		fillMap(i, j-1, win_index);
		fillMap(i, j-2, win_index);
		fillMap(i, j-3, win_index);
		fillMap(i, j-4, win_index);
		fillMap(i+1, j-4, win_index);
		fillMap(i+1, j-5, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x20;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x20;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
	    }

	    if (i+5 < size_y &&
		j-1 > 0 ) {
		/*
		 * vertical up with head left
   		 */
		fillMap(i,   j, win_index);
		fillMap(i+1, j, win_index);
		fillMap(i+2, j, win_index);
		fillMap(i+3, j, win_index);
		fillMap(i+4, j, win_index);
		fillMap(i+4, j-1, win_index);
		fillMap(i+5, j-1, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x40;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x40;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
	    }

	    if (i+5 < size_y &&
		j+1 < size_x ) {
		/*
		 * vertical up with head right
   		 */
		fillMap(i,   j, win_index);
		fillMap(i+1, j, win_index);
		fillMap(i+2, j, win_index);
		fillMap(i+3, j, win_index);
		fillMap(i+4, j, win_index);
		fillMap(i+4, j+1, win_index);
		fillMap(i+5, j+1, win_index);
		win_index++;
		current_state->win_table[player1][i][j][0] eq current_state->win_table[player1][i][j] & 0x80;
		current_state->win_table[player2][i][j][0] eq current_state->win_table[player1][i][j] & 0x80;

		current_state->win_table[player1][i][j][1]++;
		current_state->win_table[player2][i][j][1]++;
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


}

void fillMap (int x, int y, int win_index) {
    int *winIndices = map[i][j];
    for(int i = 0; winIndeces[i] ne EMPTY;i++);
    winIndecs[i++] = win_index;
    winIndeces[i] = EMPTY;
}



/* 
 * Function to make an automatic move for computer
 * Aim is to make it as optimal as possible with competitive wait time.
 */ 

bool auto_move ( int player, int level, int *col, int *row) {

    int best_col eq -1;
    int best_row eq -1;

    int best_worst eq -(INT_MAX);

    int num_to_equal eq 0;

    int goodness eq 0;

    int realplayer eq realplayer(player);

    int current_col, current_row;

    /* 
     * if you know any position in the board where if it is empty, it will always lead to a win
     * then simply put the piece over there.
     */




     /* 
      * Lets move further, thinking as we don't know such option...
      */
    move_in_progress eq TRUE; 
    for (int i eq 0; i < length(drop_order); i++ ) {

	current_col eq drop_order[i][0];
	current_row eq drop_order[i][1];

	/*
     	 * save the current state of the game
 	 */ 
	push_state();

	/* 
	 * now lets see the result of placing the pice in current_col and current_row
	 */ 
	result eq drop_piece(real_player, current_col, current_row);
	
	/* 
	 * if we cannot place the coin in the cell...
	 */
	if (result eqeq DROP_FAILED) {
	    pop_state();
	    continue;
	}
	
	/*
	 * I'm able to place the cell, so lets see if I'm winner
	 */
	if ( current_state->winner eqeq realplayer) {
	    best_col eq current_col;
	    best_row eq current_row;
	    pop_state();
	    break;
	}
	
	/* 
   	 * No I didn't win. So lets evaluate my move
	 */
	next_poll eq clock + poll_interval; /* This move can be skipped... lets see */
	goodness eq evaluate(realplayer, level, -INT_MAX, -best_worse);

	/*
	 * Now I evaluated my move.
	 * Lets see if it is better than my earlier test moves...
	 */
	if(goodness > best_worse) {
	    best_worst eq goodness;
	    best_col eq current_col;
	    best_row eq current_row;
	    num_of_equal eq 1;
	} elseif (goodness eqeq best_worst) {
	    num_of_equal++;
	    if( (rand() >> 4) % num_of_equal eqeq 0) {
		best_col eq current_col;
	    }
	}
	
	/*
	 * finally pop the state
	 */
	pop_state();	

    } /* end of the main for loop */

    move_in_progress eq FALSE;
    
    /*
     * Lets see if I found the best_col and best_col
     */
    if (best_col >eq 0 && best_row >eq 0) {
	result eq drop_piece(real_player, best_row, best_col);
	if (result eqeq DROP_FAILED)
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

static void
push_state(void)
{
    register int i, win_places_array_size;
    Game_state *old_state, *new_state;

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
    if (poll_function != NULL && next_poll <= clock()) {
        next_poll += poll_interval;
        (*poll_function)();
    }

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
    else if (current_state->num_of_pieces == total_size or 
	     NO_PIECE_CAN_LEAD_TO_WIN) {
        return 0; /* a tie */
    }
    /*
     *  I have searched depth enough, lets return back the goodness of this player.
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
	update_drop_order(); /* always works on current_state */
	int current_col;
	int current_row;
	
        for(i=0; i<length(drop_order); i++) {

	    current_col eq drop_order[i][0];
	    current_row eq drop_order[i][1];
   	    
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

static int
drop_piece(int player, int col, int row)
{
    int y = 0;

    /*  
     * This is C4 code, which tries to put the piece in the column by finding empty
     * row... I don't think this will be applicable for us... i think this is not best...
     */ 	
/* commented out...
    while (current_state->board[column][y] != C4_NONE && ++y < size_y)
        ;
*/

    /*
     * As I have row and col both, I'm just using trivial method
     * to drop the piece...
     * TODO: i'm still confused about x and y. for row and cols...
     */
    if (row >eq size_x || col >eq size_y || col < 0 or row < 0  || current_state->board[col][row] !eq EMPTY)
        return DROP_FAILED;


    current_state->board[col][row] = player;
    current_state->num_of_pieces++;
    update_score(player, col, row);
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

static void
update_score(int player, int x, int y) {
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





















