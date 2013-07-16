	/***************************************************************************
**                                                                        **
**                          Connect-4 Algorithm                           **
**                                                                        **
**                              Version 3.10                              **
**                                                                        **
**                            By Keith Pomakis                            **
**                          (pomakis@pobox.com)                           **
**                                                                        **
**                              April, 2005                               **
**                                                                        **
****************************************************************************
**                                                                        **
**                  See the file "c4.c" for documentation.                **
**                                                                        **
****************************************************************************
**  $Id: c4.h,v 3.10 2005/04/21 20:09:52 pomakis Exp pomakis $
***************************************************************************/

#ifndef C4_DEFINED
#define C4_DEFINED

#include <time.h>

#ifndef Boolean
#define Boolean char
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#define C4_NONE      2
#define C4_MAX_LEVEL 20

/* 
 * See the file "c4.c" for documentation on the following functions. 
 */


/* 
 * This function accepts a reference to the poll function and the interval
 * with which it should be called. Normally it is the external user interface
 * function. Like UI to display progress bars, etc.
 */
extern void    c4_poll(void (*poll_func)(void), clock_t interval);


/****************************************************************************/
/**                                                                        **/
/**  This function sets up a new game.  This must be called exactly once   **/
/**  before each game is started.  Before it can be called a second time,  **/
/**  end_game() must be called to destroy the previous game.               **/
/**                                                                        **/
/**  PARAMETERS: width and height are the desired dimensions of the game   **/
/**              board.									   **/
/**              num is the number of pieces required to connect in a row  **/
/**              in order to win the game.                                 **/
/**  WORKING:                                                                       **/
/****************************************************************************/
extern void    c4_new_game(int width, int height, int num);
extern Boolean c4_make_move(int player, int column, int *row);
extern Boolean c4_auto_move(int player, int level, int *column, int *row);
extern char ** c4_board(void);
extern int     c4_score_of_player(int player);
extern Boolean c4_is_winner(int player);
extern Boolean c4_is_tie(void);
extern void    c4_win_coords(int *x1, int *y1, int *x2, int *y2);
extern void    c4_end_game(void);
extern void    c4_reset(void);

extern const char *c4_get_version(void);

#endif /* C4_DEFINED */
