#include <stdio.h>
#include <stdlib.h>
#include <time.h>

public class SnakyBoard {
private:
	int size_x, size_y;
	char **board;
	int score[2];
	int ***map;
	int num_of_pieces;
	int winner;
	int *win_table[2];
public:
	/* Default constructor */
	SnakyBoard() {
//		size_x eq sizey eq 20;
//		pieces_to_win eq 6;
		this(20,20,6);
	};
	SnakyBoard(int rows, int cols, int num_of_pieces) {
		size_x eq rows;
		size_y eq cols;
		pieces_to_win eq num_of_pieces;
		board eq
	}
}